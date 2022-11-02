//
// ResourceManagerSubstateAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - ResourceManagerSubstateAllOf
public struct ResourceManagerSubstateAllOf: Codable, Hashable {
	public private(set) var resourceType: ResourceType
	public private(set) var fungibleDivisibility: Int?
	public private(set) var metadata: [ResourceManagerSubstateAllOfMetadata]
	/** A decimal-string-encoded integer between 0 and 2^255-1, which represents the total number of 10^(-18) subunits in the total supply of this resource.  */
	public private(set) var totalSupplyAttos: String

	public init(resourceType: ResourceType, fungibleDivisibility: Int? = nil, metadata: [ResourceManagerSubstateAllOfMetadata], totalSupplyAttos: String) {
		self.resourceType = resourceType
		self.fungibleDivisibility = fungibleDivisibility
		self.metadata = metadata
		self.totalSupplyAttos = totalSupplyAttos
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case resourceType = "resource_type"
		case fungibleDivisibility = "fungible_divisibility"
		case metadata
		case totalSupplyAttos = "total_supply_attos"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(resourceType, forKey: .resourceType)
		try container.encodeIfPresent(fungibleDivisibility, forKey: .fungibleDivisibility)
		try container.encode(metadata, forKey: .metadata)
		try container.encode(totalSupplyAttos, forKey: .totalSupplyAttos)
	}
}