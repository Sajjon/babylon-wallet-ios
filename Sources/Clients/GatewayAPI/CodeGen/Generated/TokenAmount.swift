//
// TokenAmount.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TokenAmount")
public typealias TokenAmount = GatewayAPI.TokenAmount

// MARK: - GatewayAPI.TokenAmount
public extension GatewayAPI {
	struct TokenAmount: Codable, Hashable {
		/** The string-encoded decimal representing the amount */
		public private(set) var value: String
		/** The Bech32m-encoded human readable version of the resource (fungible, non-fungible) global address. */
		public private(set) var address: String?

		public init(value: String, address: String? = nil) {
			self.value = value
			self.address = address
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case value
			case address
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(value, forKey: .value)
			try container.encodeIfPresent(address, forKey: .address)
		}
	}
}