//
// TransactionCommittedDetailsResponseAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionCommittedDetailsResponseAllOf")
public typealias TransactionCommittedDetailsResponseAllOf = GatewayAPI.TransactionCommittedDetailsResponseAllOf

extension GatewayAPI {

public struct TransactionCommittedDetailsResponseAllOf: Codable, Hashable {

    public private(set) var transaction: CommittedTransactionInfo

    public init(transaction: CommittedTransactionInfo) {
        self.transaction = transaction
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case transaction
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transaction, forKey: .transaction)
    }
}

}
