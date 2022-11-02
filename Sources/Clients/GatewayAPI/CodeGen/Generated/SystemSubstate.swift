//
// SystemSubstate.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - SystemSubstate
public struct SystemSubstate: Codable, Hashable {
	public private(set) var entityType: EntityType
	public private(set) var substateType: SubstateType
	/** An integer between 0 and 10^10, marking the current epoch */
	public private(set) var epoch: Int64

	public init(entityType: EntityType, substateType: SubstateType, epoch: Int64) {
		self.entityType = entityType
		self.substateType = substateType
		self.epoch = epoch
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case entityType = "entity_type"
		case substateType = "substate_type"
		case epoch
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(entityType, forKey: .entityType)
		try container.encode(substateType, forKey: .substateType)
		try container.encode(epoch, forKey: .epoch)
	}
}