//
// ComponentInfoSubstate.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - ComponentInfoSubstate
public struct ComponentInfoSubstate: Codable, Hashable {
	public private(set) var entityType: EntityType
	public private(set) var substateType: SubstateType
	/** The Bech32m-encoded human readable version of the package address */
	public private(set) var packageAddress: String
	public private(set) var blueprintName: String

	public init(entityType: EntityType, substateType: SubstateType, packageAddress: String, blueprintName: String) {
		self.entityType = entityType
		self.substateType = substateType
		self.packageAddress = packageAddress
		self.blueprintName = blueprintName
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case entityType = "entity_type"
		case substateType = "substate_type"
		case packageAddress = "package_address"
		case blueprintName = "blueprint_name"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(entityType, forKey: .entityType)
		try container.encode(substateType, forKey: .substateType)
		try container.encode(packageAddress, forKey: .packageAddress)
		try container.encode(blueprintName, forKey: .blueprintName)
	}
}