//
// EntityResourcesResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.EntityResourcesResponse")
public typealias EntityResourcesResponse = GatewayAPI.EntityResourcesResponse

// MARK: - GatewayAPI.EntityResourcesResponse
public extension GatewayAPI {
	struct EntityResourcesResponse: Codable, Hashable {
		public private(set) var ledgerState: LedgerState
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var address: String
		public private(set) var fungibleResources: EntityResourcesResponseFungibleResources
		public private(set) var nonFungibleResources: EntityResourcesResponseNonFungibleResources

		public init(ledgerState: LedgerState, address: String, fungibleResources: EntityResourcesResponseFungibleResources, nonFungibleResources: EntityResourcesResponseNonFungibleResources) {
			self.ledgerState = ledgerState
			self.address = address
			self.fungibleResources = fungibleResources
			self.nonFungibleResources = nonFungibleResources
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case ledgerState = "ledger_state"
			case address
			case fungibleResources = "fungible_resources"
			case nonFungibleResources = "non_fungible_resources"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(ledgerState, forKey: .ledgerState)
			try container.encode(address, forKey: .address)
			try container.encode(fungibleResources, forKey: .fungibleResources)
			try container.encode(nonFungibleResources, forKey: .nonFungibleResources)
		}
	}
}