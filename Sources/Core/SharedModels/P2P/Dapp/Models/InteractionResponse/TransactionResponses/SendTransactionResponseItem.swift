import EngineKit
import Prelude

extension P2P.Dapp.Response.WalletInteractionSuccessResponse {
	/// Response to Dapp from wallet, info about a signed and submitted transaction, see [CAP21][cap].
	///
	/// [cap]: https://radixdlt.atlassian.net/wiki/spaces/AT/pages/2712895489/CAP-21+Message+format+between+dApp+and+wallet#Wallet-SDK-%E2%86%94%EF%B8%8F-Wallet-messages
	///
	public struct SendTransactionResponseItem: Sendable, Hashable, Encodable {
		public let transactionIntentHash: TXID

		enum CodingKeys: CodingKey {
			case transactionIntentHash
		}

		public init(txID: TXID) {
			transactionIntentHash = txID
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(
				// Bech32m encoded transaction ID
				transactionIntentHash.asStr(),
				forKey: .transactionIntentHash
			)
		}
	}
}
