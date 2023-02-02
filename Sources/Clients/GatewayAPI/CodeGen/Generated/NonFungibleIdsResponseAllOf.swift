//
// NonFungibleLocalIdsResponseAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import ClientPrelude
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.NonFungibleLocalIdsResponseAllOf")
public typealias NonFungibleLocalIdsResponseAllOf = GatewayAPI.NonFungibleLocalIdsResponseAllOf

// MARK: - GatewayAPI.NonFungibleLocalIdsResponseAllOf
public extension GatewayAPI {
	struct NonFungibleLocalIdsResponseAllOf: Codable, Hashable {
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var address: String
		public private(set) var nonFungibleLocalIds: NonFungibleLocalIdsCollection

		public init(address: String, nonFungibleLocalIds: NonFungibleLocalIdsCollection) {
			self.address = address
			self.nonFungibleLocalIds = nonFungibleLocalIds
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case address
			case nonFungibleLocalIds = "non_fungible_ids"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(address, forKey: .address)
			try container.encode(nonFungibleLocalIds, forKey: .nonFungibleLocalIds)
		}
	}
}
