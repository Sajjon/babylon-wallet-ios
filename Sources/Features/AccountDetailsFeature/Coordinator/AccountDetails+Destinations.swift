import AssetTransferFeature
import FeaturePrelude

public extension AccountDetails {
	struct Destinations: Sendable, ReducerProtocol {
		public enum State: Sendable, Equatable {
			// TODO: case preferences(AccountPreferences.State)
			case transfer(AssetTransfer.State)
		}

		public enum Action: Sendable, Equatable {
			// TODO: case preferences(AccountPreferences.Action)
			case transfer(AssetTransfer.Action)
		}

		public var body: some ReducerProtocol<State, Action> {
			Scope(state: /State.transfer, action: /Action.transfer) {
				AssetTransfer()
			}
		}
	}
}