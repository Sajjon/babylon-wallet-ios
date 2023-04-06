//
// StateEntityDetailsResponseNonFungibleResourceDetails.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateEntityDetailsResponseNonFungibleResourceDetails")
public typealias StateEntityDetailsResponseNonFungibleResourceDetails = GatewayAPI.StateEntityDetailsResponseNonFungibleResourceDetails

// MARK: - GatewayAPI.StateEntityDetailsResponseNonFungibleResourceDetails
extension GatewayAPI {
	public struct StateEntityDetailsResponseNonFungibleResourceDetails: Codable, Hashable {
		public private(set) var type: StateEntityDetailsResponseItemDetailsType
		public private(set) var accessRulesChain: AnyCodable
		public private(set) var vaultAccessRulesChain: AnyCodable
		public private(set) var nonFungibleIdType: NonFungibleIdType

		public init(type: StateEntityDetailsResponseItemDetailsType, accessRulesChain: AnyCodable, vaultAccessRulesChain: AnyCodable, nonFungibleIdType: NonFungibleIdType) {
			self.type = type
			self.accessRulesChain = accessRulesChain
			self.vaultAccessRulesChain = vaultAccessRulesChain
			self.nonFungibleIdType = nonFungibleIdType
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case type
			case accessRulesChain = "access_rules_chain"
			case vaultAccessRulesChain = "vault_access_rules_chain"
			case nonFungibleIdType = "non_fungible_id_type"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(type, forKey: .type)
			try container.encode(accessRulesChain, forKey: .accessRulesChain)
			try container.encode(vaultAccessRulesChain, forKey: .vaultAccessRulesChain)
			try container.encode(nonFungibleIdType, forKey: .nonFungibleIdType)
		}
	}
}