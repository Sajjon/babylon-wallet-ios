//
// NonFungibleResourcesCollectionItem.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.NonFungibleResourcesCollectionItem")
public typealias NonFungibleResourcesCollectionItem = GatewayAPI.NonFungibleResourcesCollectionItem

// MARK: - GatewayAPI.NonFungibleResourcesCollectionItem
public extension GatewayAPI {
	struct NonFungibleResourcesCollectionItem: Codable, Hashable {
		/** The Bech32m-encoded human readable version of the resource (fungible, non-fungible) global address. */
		public private(set) var address: String
		public private(set) var amount: Int64

		public init(address: String, amount: Int64) {
			self.address = address
			self.amount = amount
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case address
			case amount
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(address, forKey: .address)
			try container.encode(amount, forKey: .amount)
		}
	}
}