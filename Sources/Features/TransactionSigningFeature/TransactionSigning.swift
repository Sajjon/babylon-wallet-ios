import EngineToolkitClient
import FeaturePrelude
import TransactionClient

// MARK: - TransactionSigning
public struct TransactionSigning: Sendable, FeatureReducer {
	public struct State: Sendable, Hashable {
		let transactionManifestWithoutLockFee: TransactionManifest
		var transactionWithLockFee: TransactionManifest?
		var transactionWithLockFeeString: String?
		var makeTransactionHeaderInput: MakeTransactionHeaderInput
		var isSigningTX: Bool = false

		public init(
			transactionManifestWithoutLockFee: TransactionManifest,
			makeTransactionHeaderInput: MakeTransactionHeaderInput = .default
		) {
			self.transactionManifestWithoutLockFee = transactionManifestWithoutLockFee
			self.makeTransactionHeaderInput = makeTransactionHeaderInput
		}
	}

	public enum ViewAction: Sendable, Equatable {
		case appeared
		case signTransactionButtonTapped
	}

	public enum InternalAction: Sendable, Equatable {
		// TODO: replace with tuple when Apple makes them autoconform to Equatable
		public struct AddLockInstructionToManifestSuccessValues: Sendable, Equatable {
			let manifestWithLockFee: TransactionManifest
			let manifestWithLockFeeString: String
		}

		case addLockFeeInstructionToManifestResult(TaskResult<AddLockInstructionToManifestSuccessValues>)
		case signTransactionResult(TransactionResult)
	}

	public enum DelegateAction: Sendable, Equatable {
		case failed(ApproveTransactionFailure)
		case signedTXAndSubmittedToGateway(TransactionIntent.TXID)
	}

	@Dependency(\.errorQueue) var errorQueue
	@Dependency(\.profileClient) var profileClient
	@Dependency(\.transactionClient) var transactionClient

	public init() {}

	public func reduce(into state: inout State, viewAction: ViewAction) -> EffectTask<Action> {
		switch viewAction {
		case .appeared:
			return .run { [manifest = state.transactionManifestWithoutLockFee] send in
				let networkID = await profileClient.getCurrentNetworkID()
				let result = await TaskResult {
					let manifestWithLockFee = try await transactionClient.addLockFeeInstructionToManifest(manifest)
					let manifestWithLockFeeString = manifestWithLockFee.toString(
						preamble: "",
						blobOutputFormat: .includeBlobsByByteCountOnly,
						blobPreamble: "\n\nBLOBS:\n",
						networkID: networkID
					)
					return InternalAction.AddLockInstructionToManifestSuccessValues(
						manifestWithLockFee: manifestWithLockFee,
						manifestWithLockFeeString: manifestWithLockFeeString
					)
				}
				await send(.internal(.addLockFeeInstructionToManifestResult(result)))
			}

		case .signTransactionButtonTapped:
			guard
				let transactionWithLockFee = state.transactionWithLockFee
			else {
				return .none
			}

			state.isSigningTX = true

			let signRequest = SignManifestRequest(
				manifestToSign: transactionWithLockFee,
				makeTransactionHeaderInput: state.makeTransactionHeaderInput,
				unlockKeychainPromptShowToUser: L10n.TransactionSigning.biometricsPrompt
			)

			return .run { send in
				await send(.internal(.signTransactionResult(
					await transactionClient.signAndSubmitTransaction(signRequest)
				)))
			}
		}
	}

	public func reduce(into state: inout State, internalAction: InternalAction) -> EffectTask<Action> {
		switch internalAction {
		case let .addLockFeeInstructionToManifestResult(.success(values)):
			state.transactionWithLockFee = values.manifestWithLockFee
			state.transactionWithLockFeeString = values.manifestWithLockFeeString
			return .none

		case let .addLockFeeInstructionToManifestResult(.failure(error)):
			errorQueue.schedule(error)
			return .send(.delegate(.failed(ApproveTransactionFailure.prepareTransactionFailure(.addTransactionFee(error)))))

		case let .signTransactionResult(.success(txID)):
			state.isSigningTX = false
			return .send(.delegate(.signedTXAndSubmittedToGateway(txID)))

		case let .signTransactionResult(.failure(transactionFailure)):
			state.isSigningTX = false
			return .send(.delegate(.failed(.transactionFailure(transactionFailure))))
		}
	}
}