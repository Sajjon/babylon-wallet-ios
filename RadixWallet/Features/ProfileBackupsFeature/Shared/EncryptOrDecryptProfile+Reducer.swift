import ComposableArchitecture
import SwiftUI

typealias EncryptionPassword = String
typealias EncryptedProfileJSONData = Data

// MARK: - EncryptOrDecryptProfile
struct EncryptOrDecryptProfile: Sendable, FeatureReducer {
	struct State: Sendable, Hashable {
		enum Mode: Sendable, Hashable {
			case decrypt(EncryptedProfileJSONData)

			case loadThenEncrypt

			case encryptSpecific(
				profileSnapshot: Profile
			)

			var isDecrypt: Bool {
				switch self {
				case .decrypt: true
				case .loadThenEncrypt, .encryptSpecific: false
				}
			}
		}

		enum Field: String, Sendable, Hashable {
			case encryptionPassword
			case confirmPassword
		}

		var isEncrypting: Bool {
			switch mode {
			case .decrypt: false
			case .encryptSpecific, .loadThenEncrypt: true
			}
		}

		@PresentationState
		var destination: Destination.State? = nil

		var mode: Mode
		var focusedField: Field?
		var enteredEncryptionPassword: String = ""
		var confirmedEncryptionPassword: String = ""

		init(mode: Mode) {
			self.mode = mode
		}
	}

	enum ViewAction: Sendable, Equatable {
		case appeared
		case closeButtonTapped
		case textFieldFocused(State.Field?)
		case passwordChanged(String)
		case passwordConfirmationChanged(String)
		case confirmedEncryptionPassword
	}

	enum InternalAction: Sendable, Equatable {
		case focusTextField(State.Field?)

		case loadProfileSnapshotToEncryptResult(
			TaskResult<Profile>
		)
	}

	enum DelegateAction: Sendable, Equatable {
		case dismiss
		case successfullyDecrypted(encrypted: EncryptedProfileJSONData, decrypted: Profile, containsP2PLinks: Bool)
		case successfullyEncrypted(plaintext: Profile, encrypted: EncryptedProfileJSONData)
	}

	// MARK: - Destination

	struct Destination: DestinationReducer {
		enum State: Hashable, Sendable {
			case incorrectPasswordAlert(AlertState<Action.IncorrectPasswordAlert>)
		}

		enum Action: Equatable, Sendable {
			case incorrectPasswordAlert(IncorrectPasswordAlert)

			enum IncorrectPasswordAlert: Sendable, Hashable {
				case okTapped
			}
		}

		var body: some ReducerOf<Self> {
			EmptyReducer()
		}
	}

	@Dependency(\.jsonEncoder) var jsonEncoder
	@Dependency(\.errorQueue) var errorQueue
	@Dependency(\.transportProfileClient) var transportProfileClient

	var body: some ReducerOf<Self> {
		Reduce(core)
			.ifLet(destinationPath, action: /Action.destination) {
				Destination()
			}
	}

	private let destinationPath: WritableKeyPath<State, PresentationState<Destination.State>> = \.$destination

	func reduce(into state: inout State, viewAction: ViewAction) -> Effect<Action> {
		switch viewAction {
		case .appeared:
			return .run { [mode = state.mode] send in
				await send(.internal(.focusTextField(.encryptionPassword)))
				switch mode {
				case .loadThenEncrypt:
					let result = await TaskResult { try await transportProfileClient.profileForExport() }

					await send(.internal(.loadProfileSnapshotToEncryptResult(
						result
					)))

				case .encryptSpecific:
					break

				case .decrypt:
					break
				}
			}

		case .confirmedEncryptionPassword:
			precondition(!state.enteredEncryptionPassword.isEmpty)

			if !state.mode.isDecrypt {
				precondition(state.enteredEncryptionPassword == state.confirmedEncryptionPassword)
			}

			let password = state.enteredEncryptionPassword

			switch state.mode {
			case .loadThenEncrypt:
				loggerGlobal.error("Should have loaded the profile to encrypt already")
				preconditionFailure("should have loaded already...")
				return .send(.delegate(.dismiss))

			case let .encryptSpecific(snapshot):
				let encrypted = snapshot.encrypt(password: password)
				return .send(.delegate(.successfullyEncrypted(plaintext: snapshot, encrypted: encrypted)))

			case let .decrypt(encrypted):
				do {
					let decrypted = try Profile(encrypted: encrypted, decryptionPassword: password)
					let containsP2PLinks = Profile.checkIfEncryptedProfileJsonContainsLegacyP2PLinks(
						contents: encrypted,
						password: password
					)
					return .send(.delegate(.successfullyDecrypted(encrypted: encrypted, decrypted: decrypted, containsP2PLinks: containsP2PLinks)))
				} catch {
					loggerGlobal.error("Failed to encrypt profile snapshot, error: \(error)")
					state.destination = .incorrectPasswordAlert(encrypt: false)
					return .none
				}
			}

		case .closeButtonTapped:
			return .send(.delegate(.dismiss))

		case let .textFieldFocused(focus):
			return .run { send in
				await send(.internal(.focusTextField(focus)))
			}

		case let .passwordChanged(password):
			state.enteredEncryptionPassword = password
			return .none

		case let .passwordConfirmationChanged(password):
			state.confirmedEncryptionPassword = password
			return .none
		}
	}

	func reduce(into state: inout State, internalAction: InternalAction) -> Effect<Action> {
		switch internalAction {
		case let .focusTextField(focus):
			state.focusedField = focus
			return .none

		case let .loadProfileSnapshotToEncryptResult(.success(snapshotToEncrypt)):
			state.mode = .encryptSpecific(
				profileSnapshot: snapshotToEncrypt
			)
			return .none

		case let .loadProfileSnapshotToEncryptResult(.failure(error)):
			let errorMsg = "Failed to load profile snapshot to encrypt, error: \(error)"
			loggerGlobal.error(.init(stringLiteral: errorMsg))
			errorQueue.schedule(error)
			return .none
		}
	}

	func reduce(into state: inout State, presentedAction: Destination.Action) -> Effect<Action> {
		switch presentedAction {
		case .incorrectPasswordAlert(.okTapped):
			state.destination = nil
			return .none
		}
	}
}

extension EncryptOrDecryptProfile.Destination.State {
	fileprivate static func incorrectPasswordAlert(encrypt: Bool) -> Self {
		.incorrectPasswordAlert(.init(
			title: { TextState(L10n.ProfileBackup.IncorrectPasswordAlert.title) },
			actions: {
				ButtonState(action: .okTapped, label: { TextState(L10n.ProfileBackup.IncorrectPasswordAlert.okAction) })
			},
			message: {
				TextState(
					encrypt
						? L10n.ProfileBackup.IncorrectPasswordAlert.messageEncryption
						: L10n.ProfileBackup.IncorrectPasswordAlert.messageDecryption
				)
			}
		))
	}
}
