//
// TransactionPayloadGatewayHandlingStatus.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionPayloadGatewayHandlingStatus")
typealias TransactionPayloadGatewayHandlingStatus = GatewayAPI.TransactionPayloadGatewayHandlingStatus

extension GatewayAPI {

/** A status concerning the Gateway&#39;s handling status of this pending transaction.  */
enum TransactionPayloadGatewayHandlingStatus: String, Codable, CaseIterable {
    case handlingSubmission = "HandlingSubmission"
    case concluded = "Concluded"
}
}
