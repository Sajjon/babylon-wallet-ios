import CreateAccountFeature
import FeaturePrelude

// MARK: - OnboardingCoordinator
public struct OnboardingCoordinator: Sendable, FeatureReducer {
	public struct State: Sendable, Hashable {
		public enum Root: Sendable, Hashable {
			case startup(OnboardingStartup.State)
			case createAccountCoordinator(CreateAccountCoordinator.State)
		}

		public var root: Root

		public init() {
			self.root = .startup(.init())
		}
	}

	public enum ChildAction: Sendable, Equatable {
		case startup(OnboardingStartup.Action)
		case createAccountCoordinator(CreateAccountCoordinator.Action)
	}

	public enum DelegateAction: Sendable, Equatable {
		case completed(
			accountRecoveryIsNeeded: Bool
		)
	}

	public enum InternalAction: Sendable, Equatable {
		case commitEphemeralResult(TaskResult<Prelude.Unit>)
	}

	@Dependency(\.onboardingClient) var onboardingClient

	public init() {}

	public var body: some ReducerOf<Self> {
		Scope(state: \.root, action: /Action.child) {
			EmptyReducer()
				.ifCaseLet(/State.Root.startup, action: /ChildAction.startup) {
					OnboardingStartup()
				}
				.ifCaseLet(/State.Root.createAccountCoordinator, action: /ChildAction.createAccountCoordinator) {
					CreateAccountCoordinator()
				}
		}

		Reduce(core)
	}

	public func reduce(into state: inout State, internalAction: InternalAction) -> Effect<Action> {
		switch internalAction {
		case .commitEphemeralResult(.success):
			return sendDelegateCompleted(
				state: state,
				accountRecoveryIsNeeded: false
			)

		case let .commitEphemeralResult(.failure(error)):
			fatalError("Unable to use app, failed to commit profile, error: \(String(describing: error))")
		}
	}

	public func reduce(into state: inout State, childAction: ChildAction) -> Effect<Action> {
		switch childAction {
		case .startup(.delegate(.setupNewUser)):
			state.root = .createAccountCoordinator(
				.init(
					config: .init(purpose: .firstAccountForNewProfile)
				)
			)
			return .none

		case let .startup(.delegate(.completed(accountRecoveryIsNeeded))):
			return sendDelegateCompleted(
				state: state,
				accountRecoveryIsNeeded: accountRecoveryIsNeeded
			)

		case .createAccountCoordinator(.delegate(.completed)):
			return .run { send in
				let result = await TaskResult<Prelude.Unit> {
					try await onboardingClient.commitEphemeral()
				}
				await send(.internal(.commitEphemeralResult(result)))
			}

		default:
			return .none
		}
	}

	private func sendDelegateCompleted(
		state: State,
		accountRecoveryIsNeeded: Bool
	) -> Effect<Action> {
		.send(.delegate(.completed(
			accountRecoveryIsNeeded: accountRecoveryIsNeeded
		)))
	}
}
