import ComposableArchitecture

public extension Home {
	// MARK: Reducer
	typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
	static let reducer = Reducer.combine(
		Home.Header.reducer
			.pullback(
				state: \.header,
				action: /Home.Action.header,
				environment: { _ in Home.Header.Environment() }
			),

		Home.AggregatedValue.reducer
			.pullback(
				state: \.aggregatedValue,
				action: /Home.Action.aggregatedValue,
				environment: { _ in Home.AggregatedValue.Environment() }
			),

		Home.VisitHub.reducer
			.pullback(
				state: \.visitHub,
				action: /Home.Action.visitHub,
				environment: { _ in Home.VisitHub.Environment() }
			),

		Home.AccountList.reducer
			.pullback(
				state: \.accountList,
				action: /Home.Action.accountList,
				environment: { _ in Home.AccountList.Environment(wallet: .placeholder) } // FIXME: replace wallet placeholder
			),

		Reducer { _, action, _ in
			switch action {
			case .header(.coordinate(.displaySettings)):
				return Effect(value: .coordinate(.displaySettings))
			case .header(.internal(_)):
				return .none
			case .aggregatedValue:
				return .none
			case .visitHub(.coordinate(.displayHub)):
				return Effect(value: .coordinate(.displayVisitHub))
			case .visitHub(.internal(_)):
				return .none
			case .internal(.user(.createAccountButtonTapped)):
				return Effect(value: .coordinate(.displayCreateAccount))
			case .internal:
				return .none
			case .coordinate:
				return .none
			case let .accountList(.coordinate(.displayAccountDetails(account))):
				return .run { send in
					await send(.coordinate(.displayAccountDetails(account)))
				}
			case let .accountList(.coordinate(.copyAddress(account))):
				return .run { send in
					await send(.coordinate(.copyAddress(account)))
				}
			// TODO: display confirmation popup? discuss with po / designer
			case .accountList:
				return .none
			}
		}
	)
}
