//
// VaultPayment.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.VaultPayment")
public typealias VaultPayment = GatewayAPI.VaultPayment

extension GatewayAPI {

public struct VaultPayment: Codable, Hashable {

    public private(set) var vaultEntity: EntityReference
    /** The string-encoded decimal representing the amount of fee in XRD paid by this vault. A decimal is formed of some signed integer `m` of attos (`10^(-18)`) units, where `-2^(256 - 1) <= m < 2^(256 - 1)`.  */
    public private(set) var xrdAmount: String

    public init(vaultEntity: EntityReference, xrdAmount: String) {
        self.vaultEntity = vaultEntity
        self.xrdAmount = xrdAmount
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case vaultEntity = "vault_entity"
        case xrdAmount = "xrd_amount"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(vaultEntity, forKey: .vaultEntity)
        try container.encode(xrdAmount, forKey: .xrdAmount)
    }
}

}