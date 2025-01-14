//
// ValidatorsUptimeResponseAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.ValidatorsUptimeResponseAllOf")
public typealias ValidatorsUptimeResponseAllOf = GatewayAPI.ValidatorsUptimeResponseAllOf

extension GatewayAPI {

public struct ValidatorsUptimeResponseAllOf: Codable, Hashable {

    public private(set) var validators: ValidatorUptimeCollection

    public init(validators: ValidatorUptimeCollection) {
        self.validators = validators
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case validators
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(validators, forKey: .validators)
    }
}

}
