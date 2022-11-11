import ComposableArchitecture
import FungibleTokenListFeature
import NonFungibleTokenListFeature

public struct AssetsView: ReducerProtocol {
	public init() {}

	public var body: some ReducerProtocol<State, Action> {
		Scope(state: \.nonFungibleTokenList, action: /Action.child .. Action.ChildAction.nonFungibleTokenList) {
			NonFungibleTokenList()
		}

		Reduce { state, action in
			switch action {
			case let .internal(.view(.listSelectorTapped(type))):
				state.type = type
				return .none

			case .child, .delegate:
				return .none
			}
		}
	}
}
