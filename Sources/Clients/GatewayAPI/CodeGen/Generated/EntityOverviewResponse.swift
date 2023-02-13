//
// EntityOverviewResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.EntityOverviewResponse")
public typealias EntityOverviewResponse = GatewayAPI.EntityOverviewResponse

// MARK: - GatewayAPI.EntityOverviewResponse
extension GatewayAPI {
	public struct EntityOverviewResponse: Codable, Hashable {
		public private(set) var ledgerState: LedgerState
		public private(set) var entities: [EntityOverviewResponseEntityItem]

		public init(ledgerState: LedgerState, entities: [EntityOverviewResponseEntityItem]) {
			self.ledgerState = ledgerState
			self.entities = entities
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case ledgerState = "ledger_state"
			case entities
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(ledgerState, forKey: .ledgerState)
			try container.encode(entities, forKey: .entities)
		}
	}
}
