//
// StateEntityNonFungiblesPageRequestOptIns.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateEntityNonFungiblesPageRequestOptIns")
public typealias StateEntityNonFungiblesPageRequestOptIns = GatewayAPI.StateEntityNonFungiblesPageRequestOptIns

extension GatewayAPI {

public struct StateEntityNonFungiblesPageRequestOptIns: Codable, Hashable {

    public private(set) var nonFungibleIncludeNfids: Bool?
    public private(set) var explicitMetadata: [String]?

    public init(nonFungibleIncludeNfids: Bool? = nil, explicitMetadata: [String]? = nil) {
        self.nonFungibleIncludeNfids = nonFungibleIncludeNfids
        self.explicitMetadata = explicitMetadata
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case nonFungibleIncludeNfids = "non_fungible_include_nfids"
        case explicitMetadata = "explicit_metadata"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(nonFungibleIncludeNfids, forKey: .nonFungibleIncludeNfids)
        try container.encodeIfPresent(explicitMetadata, forKey: .explicitMetadata)
    }
}

}