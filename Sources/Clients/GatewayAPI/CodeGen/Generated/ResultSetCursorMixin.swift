//
// ResultSetCursorMixin.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.ResultSetCursorMixin")
public typealias ResultSetCursorMixin = GatewayAPI.ResultSetCursorMixin

// MARK: - GatewayAPI.ResultSetCursorMixin
public extension GatewayAPI {
	struct ResultSetCursorMixin: Codable, Hashable {
		/** TBD (make it nullable when we're dealing with unknown result set sizes?) */
		public private(set) var totalCount: Int?
		/** TBD (maybe we should use HATEOAS-like permalinks?) */
		public private(set) var previousCursor: String?
		/** TBD (maybe we should use HATEOAS-like permalinks?) */
		public private(set) var nextCursor: String?

		public init(totalCount: Int? = nil, previousCursor: String? = nil, nextCursor: String? = nil) {
			self.totalCount = totalCount
			self.previousCursor = previousCursor
			self.nextCursor = nextCursor
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case totalCount = "total_count"
			case previousCursor = "previous_cursor"
			case nextCursor = "next_cursor"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encodeIfPresent(totalCount, forKey: .totalCount)
			try container.encodeIfPresent(previousCursor, forKey: .previousCursor)
			try container.encodeIfPresent(nextCursor, forKey: .nextCursor)
		}
	}
}