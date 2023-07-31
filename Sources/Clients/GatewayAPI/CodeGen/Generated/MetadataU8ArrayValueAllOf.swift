//
// MetadataU8ArrayValueAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.MetadataU8ArrayValueAllOf")
public typealias MetadataU8ArrayValueAllOf = GatewayAPI.MetadataU8ArrayValueAllOf

extension GatewayAPI {

public struct MetadataU8ArrayValueAllOf: Codable, Hashable {

    public private(set) var valueHex: String

    public init(valueHex: String) {
        self.valueHex = valueHex
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case valueHex = "value_hex"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(valueHex, forKey: .valueHex)
    }
}

}