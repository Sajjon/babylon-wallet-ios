//
// StateKeyValueStoreDataRequestKeyItem.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateKeyValueStoreDataRequestKeyItem")
public typealias StateKeyValueStoreDataRequestKeyItem = GatewayAPI.StateKeyValueStoreDataRequestKeyItem

extension GatewayAPI {

public struct StateKeyValueStoreDataRequestKeyItem: Codable, Hashable {

    /** Hex-encoded binary blob. */
    public private(set) var keyHex: String

    public init(keyHex: String) {
        self.keyHex = keyHex
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case keyHex = "key_hex"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keyHex, forKey: .keyHex)
    }
}

}
