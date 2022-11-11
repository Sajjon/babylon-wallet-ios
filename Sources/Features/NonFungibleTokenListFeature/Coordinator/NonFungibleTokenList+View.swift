import ComposableArchitecture
import SwiftUI

// MARK: - NonFungibleTokenList.View
public extension NonFungibleTokenList {
	struct View: SwiftUI.View {
		public typealias Store = ComposableArchitecture.Store<State, Action>
		private let store: Store

		public init(
			store: Store
		) {
			self.store = store
		}
	}
}

public extension NonFungibleTokenList.View {
	var body: some View {
		WithViewStore(
			store.actionless,
			observe: ViewState.init(state:)
		) { _ in
			VStack(spacing: 25) {
				ForEachStore(
					store.scope(
						state: \.rows,
						action: { .child(.asset(id: $0, action: $1)) }
					),
					content: NonFungibleTokenList.Row.View.init(store:)
				)
			}
		}
	}
}

// MARK: - NonFungibleTokenList.View.ViewState
extension NonFungibleTokenList.View {
	// MARK: ViewState
	struct ViewState: Equatable {
		init(state _: NonFungibleTokenList.State) {}
	}
}

// MARK: - NonFungibleTokenList_Preview
struct NonFungibleTokenList_Preview: PreviewProvider {
	static var previews: some View {
		NonFungibleTokenList.View(
			store: .init(
				initialState: .init(rows: []),
				reducer: NonFungibleTokenList()
			)
		)
	}
}
