//
// RecentTransactionsResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.RecentTransactionsResponse")
public typealias RecentTransactionsResponse = GatewayAPI.RecentTransactionsResponse

// MARK: - GatewayAPI.RecentTransactionsResponse
public extension GatewayAPI {
	struct RecentTransactionsResponse: Codable, Hashable {
		public private(set) var ledgerState: LedgerState
		/** TBD (make it nullable when we're dealing with unknown result set sizes?) */
		public private(set) var totalCount: Int?
		/** TBD (maybe we should use HATEOAS-like permalinks?) */
		public private(set) var previousCursor: String?
		/** TBD (maybe we should use HATEOAS-like permalinks?) */
		public private(set) var nextCursor: String?
		/** The page of user transactions. */
		public private(set) var items: [TransactionInfo]

		public init(ledgerState: LedgerState, totalCount: Int? = nil, previousCursor: String? = nil, nextCursor: String? = nil, items: [TransactionInfo]) {
			self.ledgerState = ledgerState
			self.totalCount = totalCount
			self.previousCursor = previousCursor
			self.nextCursor = nextCursor
			self.items = items
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case ledgerState = "ledger_state"
			case totalCount = "total_count"
			case previousCursor = "previous_cursor"
			case nextCursor = "next_cursor"
			case items
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(ledgerState, forKey: .ledgerState)
			try container.encodeIfPresent(totalCount, forKey: .totalCount)
			try container.encodeIfPresent(previousCursor, forKey: .previousCursor)
			try container.encodeIfPresent(nextCursor, forKey: .nextCursor)
			try container.encode(items, forKey: .items)
		}
	}
}