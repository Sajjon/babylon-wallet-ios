//
// StreamTransactionsRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StreamTransactionsRequest")
public typealias StreamTransactionsRequest = GatewayAPI.StreamTransactionsRequest

extension GatewayAPI {

public struct StreamTransactionsRequest: Codable, Hashable {

    public enum KindFilter: String, Codable, CaseIterable {
        case user = "User"
        case epochChange = "EpochChange"
        case all = "All"
    }
    public enum Order: String, Codable, CaseIterable {
        case asc = "Asc"
        case desc = "Desc"
    }
    public private(set) var atLedgerState: LedgerStateSelector?
    /** This cursor allows forward pagination, by providing the cursor from the previous request. */
    public private(set) var cursor: String?
    /** The page size requested. */
    public private(set) var limitPerPage: Int?
    public private(set) var fromLedgerState: LedgerStateSelector?
    /** Limit returned transactions by their kind. Defaults to `user`. */
    public private(set) var kindFilter: KindFilter?
    public private(set) var manifestAccountsWithdrawnFromFilter: [String]?
    public private(set) var manifestAccountsDepositedIntoFilter: [String]?
    public private(set) var manifestResourcesFilter: [String]?
    public private(set) var affectedGlobalEntitiesFilter: [String]?
    public private(set) var eventsFilter: [StreamTransactionsRequestEventFilterItem]?
    /** Configures the order of returned result set. Defaults to `desc`. */
    public private(set) var order: Order?
    public private(set) var optIns: TransactionDetailsOptIns?

    public init(atLedgerState: LedgerStateSelector? = nil, cursor: String? = nil, limitPerPage: Int? = nil, fromLedgerState: LedgerStateSelector? = nil, kindFilter: KindFilter? = nil, manifestAccountsWithdrawnFromFilter: [String]? = nil, manifestAccountsDepositedIntoFilter: [String]? = nil, manifestResourcesFilter: [String]? = nil, affectedGlobalEntitiesFilter: [String]? = nil, eventsFilter: [StreamTransactionsRequestEventFilterItem]? = nil, order: Order? = nil, optIns: TransactionDetailsOptIns? = nil) {
        self.atLedgerState = atLedgerState
        self.cursor = cursor
        self.limitPerPage = limitPerPage
        self.fromLedgerState = fromLedgerState
        self.kindFilter = kindFilter
        self.manifestAccountsWithdrawnFromFilter = manifestAccountsWithdrawnFromFilter
        self.manifestAccountsDepositedIntoFilter = manifestAccountsDepositedIntoFilter
        self.manifestResourcesFilter = manifestResourcesFilter
        self.affectedGlobalEntitiesFilter = affectedGlobalEntitiesFilter
        self.eventsFilter = eventsFilter
        self.order = order
        self.optIns = optIns
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case atLedgerState = "at_ledger_state"
        case cursor
        case limitPerPage = "limit_per_page"
        case fromLedgerState = "from_ledger_state"
        case kindFilter = "kind_filter"
        case manifestAccountsWithdrawnFromFilter = "manifest_accounts_withdrawn_from_filter"
        case manifestAccountsDepositedIntoFilter = "manifest_accounts_deposited_into_filter"
        case manifestResourcesFilter = "manifest_resources_filter"
        case affectedGlobalEntitiesFilter = "affected_global_entities_filter"
        case eventsFilter = "events_filter"
        case order
        case optIns = "opt_ins"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(atLedgerState, forKey: .atLedgerState)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(limitPerPage, forKey: .limitPerPage)
        try container.encodeIfPresent(fromLedgerState, forKey: .fromLedgerState)
        try container.encodeIfPresent(kindFilter, forKey: .kindFilter)
        try container.encodeIfPresent(manifestAccountsWithdrawnFromFilter, forKey: .manifestAccountsWithdrawnFromFilter)
        try container.encodeIfPresent(manifestAccountsDepositedIntoFilter, forKey: .manifestAccountsDepositedIntoFilter)
        try container.encodeIfPresent(manifestResourcesFilter, forKey: .manifestResourcesFilter)
        try container.encodeIfPresent(affectedGlobalEntitiesFilter, forKey: .affectedGlobalEntitiesFilter)
        try container.encodeIfPresent(eventsFilter, forKey: .eventsFilter)
        try container.encodeIfPresent(order, forKey: .order)
        try container.encodeIfPresent(optIns, forKey: .optIns)
    }
}

}
