//
// StateAccountResourcePreferencesPageRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateAccountResourcePreferencesPageRequest")
typealias StateAccountResourcePreferencesPageRequest = GatewayAPI.StateAccountResourcePreferencesPageRequest

extension GatewayAPI {

struct StateAccountResourcePreferencesPageRequest: Codable, Hashable {

    private(set) var atLedgerState: LedgerStateSelector?
    /** This cursor allows forward pagination, by providing the cursor from the previous request. */
    private(set) var cursor: String?
    /** The page size requested. */
    private(set) var limitPerPage: Int?
    /** Bech32m-encoded human readable version of the address. */
    private(set) var accountAddress: String

    init(atLedgerState: LedgerStateSelector? = nil, cursor: String? = nil, limitPerPage: Int? = nil, accountAddress: String) {
        self.atLedgerState = atLedgerState
        self.cursor = cursor
        self.limitPerPage = limitPerPage
        self.accountAddress = accountAddress
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case atLedgerState = "at_ledger_state"
        case cursor
        case limitPerPage = "limit_per_page"
        case accountAddress = "account_address"
    }

    // Encodable protocol methods

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(atLedgerState, forKey: .atLedgerState)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(limitPerPage, forKey: .limitPerPage)
        try container.encode(accountAddress, forKey: .accountAddress)
    }
}

}
