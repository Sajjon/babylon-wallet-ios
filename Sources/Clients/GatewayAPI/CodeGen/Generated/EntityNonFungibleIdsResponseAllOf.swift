//
// EntityNonFungibleLocalIdsResponseAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import ClientPrelude
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.EntityNonFungibleLocalIdsResponseAllOf")
public typealias EntityNonFungibleLocalIdsResponseAllOf = GatewayAPI.EntityNonFungibleLocalIdsResponseAllOf

// MARK: - GatewayAPI.EntityNonFungibleLocalIdsResponseAllOf
public extension GatewayAPI {
	struct EntityNonFungibleLocalIdsResponseAllOf: Codable, Hashable {
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var address: String
		/** The Bech32m-encoded human readable version of the resource (fungible, non-fungible) global address. */
		public private(set) var resourceAddress: String
		public private(set) var nonFungibleLocalIds: NonFungibleLocalIdsCollection

		public init(address: String, resourceAddress: String, nonFungibleLocalIds: NonFungibleLocalIdsCollection) {
			self.address = address
			self.resourceAddress = resourceAddress
			self.nonFungibleLocalIds = nonFungibleLocalIds
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case address
			case resourceAddress = "resource_address"
			case nonFungibleLocalIds = "non_fungible_ids"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(address, forKey: .address)
			try container.encode(resourceAddress, forKey: .resourceAddress)
			try container.encode(nonFungibleLocalIds, forKey: .nonFungibleLocalIds)
		}
	}
}
