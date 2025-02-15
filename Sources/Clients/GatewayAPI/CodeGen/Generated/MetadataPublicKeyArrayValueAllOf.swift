//
// MetadataPublicKeyArrayValueAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.MetadataPublicKeyArrayValueAllOf")
public typealias MetadataPublicKeyArrayValueAllOf = GatewayAPI.MetadataPublicKeyArrayValueAllOf

extension GatewayAPI {

public struct MetadataPublicKeyArrayValueAllOf: Codable, Hashable {

    public private(set) var values: [PublicKey]

    public init(values: [PublicKey]) {
        self.values = values
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case values
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(values, forKey: .values)
    }
}

}
