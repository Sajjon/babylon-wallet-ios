//
// ModelErrorResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - ModelErrorResponse
public struct ModelErrorResponse: Sendable, Codable, Hashable {
	/** A numeric code corresponding to the given error type, roughly aligned with HTTP Status Code semantics (eg 400/404/500). */
	public let code: Int
	/** A human-readable error message. */
	public let message: String
	public let details: GatewayError?
	/** A GUID to be used when reporting errors, to allow correlation with the Gateway API's error logs. */
	public let traceId: String?

	public init(code: Int, message: String, details: GatewayError? = nil, traceId: String? = nil) {
		self.code = code
		self.message = message
		self.details = details
		self.traceId = traceId
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case code
		case message
		case details
		case traceId = "trace_id"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(code, forKey: .code)
		try container.encode(message, forKey: .message)
		try container.encodeIfPresent(details, forKey: .details)
		try container.encodeIfPresent(traceId, forKey: .traceId)
	}
}
