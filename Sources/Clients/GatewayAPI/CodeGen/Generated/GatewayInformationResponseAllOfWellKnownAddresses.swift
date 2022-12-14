//
// GatewayInformationResponseAllOfWellKnownAddresses.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.GatewayInformationResponseAllOfWellKnownAddresses")
public typealias GatewayInformationResponseAllOfWellKnownAddresses = GatewayAPI.GatewayInformationResponseAllOfWellKnownAddresses

// MARK: - GatewayAPI.GatewayInformationResponseAllOfWellKnownAddresses
public extension GatewayAPI {
	struct GatewayInformationResponseAllOfWellKnownAddresses: Codable, Hashable {
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var accountPackage: String
		/** The Bech32m-encoded human readable version of the component (normal, account, system) global address. */
		public private(set) var faucet: String
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var epochManager: String
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var clock: String
		/** The Bech32m-encoded human readable version of the resource (fungible, non-fungible) global address. */
		public private(set) var ecdsaSecp256k1: String
		/** The Bech32m-encoded human readable version of the resource (fungible, non-fungible) global address. */
		public private(set) var eddsaEd25519: String
		/** The Bech32m-encoded human readable version of the resource (fungible, non-fungible) global address. */
		public private(set) var xrd: String

		public init(accountPackage: String, faucet: String, epochManager: String, clock: String, ecdsaSecp256k1: String, eddsaEd25519: String, xrd: String) {
			self.accountPackage = accountPackage
			self.faucet = faucet
			self.epochManager = epochManager
			self.clock = clock
			self.ecdsaSecp256k1 = ecdsaSecp256k1
			self.eddsaEd25519 = eddsaEd25519
			self.xrd = xrd
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case accountPackage = "account_package"
			case faucet
			case epochManager = "epoch_manager"
			case clock
			case ecdsaSecp256k1 = "ecdsa_secp256k1"
			case eddsaEd25519 = "eddsa_ed25519"
			case xrd
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(accountPackage, forKey: .accountPackage)
			try container.encode(faucet, forKey: .faucet)
			try container.encode(epochManager, forKey: .epochManager)
			try container.encode(clock, forKey: .clock)
			try container.encode(ecdsaSecp256k1, forKey: .ecdsaSecp256k1)
			try container.encode(eddsaEd25519, forKey: .eddsaEd25519)
			try container.encode(xrd, forKey: .xrd)
		}
	}
}