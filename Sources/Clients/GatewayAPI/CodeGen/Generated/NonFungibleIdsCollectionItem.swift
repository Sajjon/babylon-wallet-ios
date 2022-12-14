//
// NonFungibleIdsCollectionItem.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.NonFungibleIdsCollectionItem")
public typealias NonFungibleIdsCollectionItem = GatewayAPI.NonFungibleIdsCollectionItem

// MARK: - GatewayAPI.NonFungibleIdsCollectionItem
public extension GatewayAPI {
	struct NonFungibleIdsCollectionItem: Codable, Hashable {
		public private(set) var nonFungibleId: String

		public init(nonFungibleId: String) {
			self.nonFungibleId = nonFungibleId
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case nonFungibleId = "non_fungible_id"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(nonFungibleId, forKey: .nonFungibleId)
		}
	}
}