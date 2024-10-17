//
// LedgerStateSelector.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.LedgerStateSelector")
typealias LedgerStateSelector = GatewayAPI.LedgerStateSelector

extension GatewayAPI {

/** Optional. This allows for a request to be made against a historic state. If a constraint is specified, the Gateway will resolve the request against the ledger state at that time. If not specified, requests will be made with respect to the top of the committed ledger.  */
struct LedgerStateSelector: Codable, Hashable {

    /** If provided, the latest ledger state lower than or equal to the given state version is returned. */
    private(set) var stateVersion: Int64?
    /** If provided, the latest ledger state lower than or equal to the given round timestamp is returned. */
    private(set) var timestamp: Date?
    /** If provided, the ledger state lower than or equal to the given epoch at round 0 is returned. */
    private(set) var epoch: Int64?
    /** If provided must be accompanied with `epoch`, the ledger state lower than or equal to the given epoch and round is returned. */
    private(set) var round: Int64?

    init(stateVersion: Int64? = nil, timestamp: Date? = nil, epoch: Int64? = nil, round: Int64? = nil) {
        self.stateVersion = stateVersion
        self.timestamp = timestamp
        self.epoch = epoch
        self.round = round
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case stateVersion = "state_version"
        case timestamp
        case epoch
        case round
    }

    // Encodable protocol methods

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(stateVersion, forKey: .stateVersion)
        try container.encodeIfPresent(timestamp, forKey: .timestamp)
        try container.encodeIfPresent(epoch, forKey: .epoch)
        try container.encodeIfPresent(round, forKey: .round)
    }
}

}
