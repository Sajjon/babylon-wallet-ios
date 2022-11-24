//
// TransactionStatusRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionStatusRequest")
public typealias TransactionStatusRequest = GatewayAPI.TransactionStatusRequest

// MARK: - GatewayAPI.TransactionStatusRequest
public extension GatewayAPI {
	struct TransactionStatusRequest: Codable, Hashable {
		public private(set) var transactionIdentifier: TransactionLookupIdentifier
		public private(set) var atStateIdentifier: PartialLedgerStateIdentifier?

		public init(transactionIdentifier: TransactionLookupIdentifier, atStateIdentifier: PartialLedgerStateIdentifier? = nil) {
			self.transactionIdentifier = transactionIdentifier
			self.atStateIdentifier = atStateIdentifier
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case transactionIdentifier = "transaction_identifier"
			case atStateIdentifier = "at_state_identifier"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(transactionIdentifier, forKey: .transactionIdentifier)
			try container.encodeIfPresent(atStateIdentifier, forKey: .atStateIdentifier)
		}
	}
}