import BrowserExtensionsConnectivityClient
import ComposableArchitecture
import EngineToolkit
import Foundation
import ProfileClient

// MARK: - TransactionSigning.Action
public extension TransactionSigning {
	enum Action: Equatable {
		public static func view(_ action: ViewAction) -> Self { .internal(.view(action)) }
		case `internal`(InternalAction)
		case delegate(DelegateAction)
	}
}

// MARK: - TransactionSigning.Action.ViewAction
public extension TransactionSigning.Action {
	enum ViewAction: Equatable {
		case signTransactionButtonTapped
		case errorAlertDismissButtonTapped
		case closeButtonTapped
	}
}

// MARK: - TransactionSigning.Action.InternalAction
public extension TransactionSigning.Action {
	enum InternalAction: Equatable {
		case view(ViewAction)
		case signTransactionResult(TaskResult<TransactionIntent.TXID>)
	}
}

// MARK: - TransactionSigning.Action.DelegateAction
public extension TransactionSigning.Action {
	enum DelegateAction: Equatable {
		case dismissView

		case signedTXAndSubmittedToGateway(
			TransactionIntent.TXID,
			incomingMessageFromBrowser: IncomingMessageFromBrowser
		)
	}
}