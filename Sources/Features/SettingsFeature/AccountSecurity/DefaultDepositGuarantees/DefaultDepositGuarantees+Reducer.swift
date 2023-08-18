import AppPreferencesClient
import FactorSourcesClient
import FeaturePrelude
import LedgerHardwareDevicesFeature
import TransactionReviewFeature

public struct DefaultDepositGuarantees: Sendable, FeatureReducer {
	public typealias Store = StoreOf<Self>

	public init() {}

	// MARK: State

	public struct State: Sendable, Hashable {
		public var depositGuarantee: BigDecimal? {
			percentageStepper.value.map { 0.01 * $0 }
		}

		var percentageStepper: MinimumPercentageStepper.State

		public init(depositGuarantee: BigDecimal) {
			self.percentageStepper = .init(value: 100 * depositGuarantee)
		}
	}

	// MARK: Action

	public enum ChildAction: Sendable, Equatable {
		case percentageStepper(MinimumPercentageStepper.Action)
	}

	// MARK: Reducer

	public var body: some ReducerProtocolOf<Self> {
		Scope(state: \.percentageStepper, action: /Action.child .. /ChildAction.percentageStepper) {
			MinimumPercentageStepper()
		}
	}
}
