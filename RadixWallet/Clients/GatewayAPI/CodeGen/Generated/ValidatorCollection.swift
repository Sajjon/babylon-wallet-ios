//
// ValidatorCollection.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.ValidatorCollection")
typealias ValidatorCollection = GatewayAPI.ValidatorCollection

extension GatewayAPI {

struct ValidatorCollection: Codable, Hashable {

    /** Total number of items in underlying collection, fragment of which is available in `items` collection. */
    private(set) var totalCount: Int64?
    /** If specified, contains a cursor to query next page of the `items` collection. */
    private(set) var nextCursor: String?
    private(set) var items: [ValidatorCollectionItem]

    init(totalCount: Int64? = nil, nextCursor: String? = nil, items: [ValidatorCollectionItem]) {
        self.totalCount = totalCount
        self.nextCursor = nextCursor
        self.items = items
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case totalCount = "total_count"
        case nextCursor = "next_cursor"
        case items
    }

    // Encodable protocol methods

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(totalCount, forKey: .totalCount)
        try container.encodeIfPresent(nextCursor, forKey: .nextCursor)
        try container.encode(items, forKey: .items)
    }
}

}
