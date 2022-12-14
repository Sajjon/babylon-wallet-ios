//
// EntityDetailsResponsePackageDetails.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.EntityDetailsResponsePackageDetails")
public typealias EntityDetailsResponsePackageDetails = GatewayAPI.EntityDetailsResponsePackageDetails

// MARK: - GatewayAPI.EntityDetailsResponsePackageDetails
public extension GatewayAPI {
	struct EntityDetailsResponsePackageDetails: Codable, Hashable {
		public private(set) var discriminator: EntityDetailsResponseDetailsType
		public private(set) var codeHex: String

		public init(discriminator: EntityDetailsResponseDetailsType, codeHex: String) {
			self.discriminator = discriminator
			self.codeHex = codeHex
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case discriminator
			case codeHex = "code_hex"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(discriminator, forKey: .discriminator)
			try container.encode(codeHex, forKey: .codeHex)
		}
	}
}