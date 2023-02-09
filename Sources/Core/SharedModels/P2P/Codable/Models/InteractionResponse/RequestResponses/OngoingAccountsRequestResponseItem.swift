import Prelude

// MARK: - P2P.ToDapp.WalletInteractionSuccessResponse.OngoingAccountsRequestResponseItem
public extension P2P.ToDapp.WalletInteractionSuccessResponse {
	enum OngoingAccountsRequestResponseItem: Sendable, Hashable, Encodable {
		case withoutProof(OngoingAccountsWithoutProofOfOwnershipRequestResponseItem)
		case withProof(OngoingAccountsWithProofOfOwnershipRequestResponseItem)

		public func encode(to encoder: Encoder) throws {
			switch self {
			case let .withProof(response):
				try response.encode(to: encoder)
			case let .withoutProof(response):
				try response.encode(to: encoder)
			}
		}
	}
}

public extension P2P.ToDapp.WalletInteractionSuccessResponse {
	struct OngoingAccountsWithoutProofOfOwnershipRequestResponseItem: Sendable, Hashable, Encodable {
		public let accounts: [P2P.ToDapp.WalletAccount]

		public init(accounts: [P2P.ToDapp.WalletAccount]) {
			self.accounts = accounts
		}
	}

	struct OngoingAccountsWithProofOfOwnershipRequestResponseItem: Sendable, Hashable, Encodable {
		public let accounts: [P2P.ToDapp.WalletAccountWithProof]

		public init(accounts: [P2P.ToDapp.WalletAccountWithProof]) {
			self.accounts = accounts
		}
	}
}