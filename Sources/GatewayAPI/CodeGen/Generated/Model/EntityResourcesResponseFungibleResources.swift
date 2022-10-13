//
// EntityResourcesResponseFungibleResources.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - EntityResourcesResponseFungibleResources
public struct EntityResourcesResponseFungibleResources: Sendable, Codable, Hashable {
	/** TBD (make it nullable when we're dealing with unknown result set sizes?) */
	public let totalCount: Int
	/** TBD (maybe we should use HATEOAS-like permalinks?) */
	public let previousCursor: String?
	/** TBD (maybe we should use HATEOAS-like permalinks?) */
	public let nextCursor: String?
	public let results: [EntityStateResponseFungibleResource]

	public init(totalCount: Int, previousCursor: String? = nil, nextCursor: String? = nil, results: [EntityStateResponseFungibleResource]) {
		self.totalCount = totalCount
		self.previousCursor = previousCursor
		self.nextCursor = nextCursor
		self.results = results
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case totalCount = "total_count"
		case previousCursor = "previous_cursor"
		case nextCursor = "next_cursor"
		case results
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(totalCount, forKey: .totalCount)
		try container.encodeIfPresent(previousCursor, forKey: .previousCursor)
		try container.encodeIfPresent(nextCursor, forKey: .nextCursor)
		try container.encode(results, forKey: .results)
	}
}
