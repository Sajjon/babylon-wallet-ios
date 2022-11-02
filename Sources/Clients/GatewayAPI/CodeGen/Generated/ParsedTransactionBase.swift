//
// ParsedTransactionBase.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - ParsedTransactionBase
public struct ParsedTransactionBase: Codable, Hashable {
	public private(set) var type: ParsedTransactionType

	public init(type: ParsedTransactionType) {
		self.type = type
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case type
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(type, forKey: .type)
	}
}