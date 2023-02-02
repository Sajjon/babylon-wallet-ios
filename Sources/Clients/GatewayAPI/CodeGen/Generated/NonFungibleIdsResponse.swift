//
// NonFungibleLocalIdsResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import ClientPrelude
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.NonFungibleLocalIdsResponse")
public typealias NonFungibleLocalIdsResponse = GatewayAPI.NonFungibleLocalIdsResponse

// MARK: - GatewayAPI.NonFungibleLocalIdsResponse
public extension GatewayAPI {
	struct NonFungibleLocalIdsResponse: Codable, Hashable {
		public private(set) var ledgerState: LedgerState
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var address: String
		public private(set) var nonFungibleLocalIds: NonFungibleLocalIdsCollection

		public init(ledgerState: LedgerState, address: String, nonFungibleLocalIds: NonFungibleLocalIdsCollection) {
			self.ledgerState = ledgerState
			self.address = address
			self.nonFungibleLocalIds = nonFungibleLocalIds
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case ledgerState = "ledger_state"
			case address
			case nonFungibleLocalIds = "non_fungible_ids"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(ledgerState, forKey: .ledgerState)
			try container.encode(address, forKey: .address)
			try container.encode(nonFungibleLocalIds, forKey: .nonFungibleLocalIds)
		}
	}
}
