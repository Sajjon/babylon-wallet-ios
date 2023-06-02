import FactorSourcesClient
import FeaturePrelude

// MARK: - SignWithFactorSourcesOfKindDelegateActionProtocol
protocol SignWithFactorSourcesOfKindDelegateActionProtocol: Sendable, Equatable {
	static func done(
		signingFactors: NonEmpty<Set<SigningFactor>>,
		signatures: Set<SignatureOfEntity>
	) -> Self
}

// MARK: - SignWithFactorSourcesOfKindInternalActionProtocol
protocol SignWithFactorSourcesOfKindInternalActionProtocol: Sendable, Equatable {
	static func signingWithFactor(_ signingFactor: SigningFactor) -> Self
}

// MARK: - SignWithFactorSourcesOfKindViewActionProtocol
protocol SignWithFactorSourcesOfKindViewActionProtocol: Sendable, Equatable {
	static var onFirstTask: Self { get }
}

// MARK: - SignWithFactorSourcesOfKindState
public struct SignWithFactorSourcesOfKindState<Factor: FactorSourceProtocol>:
	Sendable,
	Hashable
{
	public let signingFactors: NonEmpty<Set<SigningFactor>>
	public let signingPurposeWithPayload: SigningPurposeWithPayload
	public var currentSigningFactor: SigningFactor?

	public init(
		signingFactors: NonEmpty<Set<SigningFactor>>,
		signingPurposeWithPayload: SigningPurposeWithPayload,
		currentSigningFactor: SigningFactor? = nil
	) {
		assert(signingFactors.allSatisfy { $0.factorSource.kind == Factor.kind })
		self.signingFactors = signingFactors
		self.signingPurposeWithPayload = signingPurposeWithPayload
		self.currentSigningFactor = currentSigningFactor
	}
}

// MARK: - SignWithFactorSourcesOfKindReducerProtocol
protocol SignWithFactorSourcesOfKindReducerProtocol:
	Sendable,
	FeatureReducer
	where
	DelegateAction: SignWithFactorSourcesOfKindDelegateActionProtocol,
	State == SignWithFactorSourcesOfKindState<Factor>,
	InternalAction: SignWithFactorSourcesOfKindInternalActionProtocol,
	ViewAction: SignWithFactorSourcesOfKindViewActionProtocol
{
	associatedtype Factor: FactorSourceProtocol

	func sign(
		signers: SigningFactor.Signers,
		factor: Factor,
		state: State
	) async throws -> Set<SignatureOfEntity>
}

extension SignWithFactorSourcesOfKindReducerProtocol {
	func signWithSigningFactors(of state: State) -> EffectTask<Action> {
		.run { [signingFactors = state.signingFactors] send in
			var allSignatures = Set<SignatureOfEntity>()
			for signingFactor in signingFactors {
				await send(.internal(.signingWithFactor(signingFactor)))

				let signatures = try await sign(
					signers: signingFactor.signers,
					factor: signingFactor.factorSource.extract(as: Factor.self),
					state: state
				)

				allSignatures.append(contentsOf: signatures)
			}
			await send(.delegate(.done(signingFactors: signingFactors, signatures: allSignatures)))
		} catch: { _, _ in
			loggerGlobal.error("Failed to sign with factor source of kind: \(Factor.kind)")
		}
	}
}
