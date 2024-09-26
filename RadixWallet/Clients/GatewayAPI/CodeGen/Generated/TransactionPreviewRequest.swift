//
// TransactionPreviewRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionPreviewRequest")
public typealias TransactionPreviewRequest = GatewayAPI.TransactionPreviewRequest

extension GatewayAPI {

public struct TransactionPreviewRequest: Codable, Hashable {

    public private(set) var optIns: TransactionPreviewOptIns?
    /** A text-representation of a transaction manifest */
    public private(set) var manifest: String
    /** An array of hex-encoded blob data, if referenced by the manifest. */
    public private(set) var blobsHex: [String]?
    /** An integer between `0` and `10^10`, marking the epoch at which the transaction starts being valid. If omitted, the current epoch will be used (taking into account the `at_ledger_state`, if specified).  */
    public private(set) var startEpochInclusive: Int64
    /** An integer between `0` and `10^10`, marking the epoch at which the transaction is no longer valid. If omitted, a maximum epoch (relative to the `start_epoch_inclusive`) will be used.  */
    public private(set) var endEpochExclusive: Int64
    public private(set) var notaryPublicKey: PublicKey?
    /** Whether the notary should count as a signatory (defaults to `false`). */
    public private(set) var notaryIsSignatory: Bool?
    /** An integer between `0` and `65535`, giving the validator tip as a percentage amount. A value of `1` corresponds to a 1% fee.  */
    public private(set) var tipPercentage: Int
    /** An integer between `0` and `2^32 - 1`, chosen to allow a unique intent to be created (to enable submitting an otherwise identical/duplicate intent).  */
    public private(set) var nonce: Int64
    /** A list of public keys to be used as transaction signers */
    public private(set) var signerPublicKeys: [PublicKey]
    /** An optional transaction message. Only affects the costing. This type is defined in the Core API as `TransactionMessage`. See the Core API documentation for more details.  */
    public private(set) var message: AnyCodable?
    public private(set) var flags: TransactionPreviewRequestFlags

    public init(optIns: TransactionPreviewOptIns? = nil, manifest: String, blobsHex: [String]? = nil, startEpochInclusive: Int64, endEpochExclusive: Int64, notaryPublicKey: PublicKey? = nil, notaryIsSignatory: Bool? = nil, tipPercentage: Int, nonce: Int64, signerPublicKeys: [PublicKey], message: AnyCodable? = nil, flags: TransactionPreviewRequestFlags) {
        self.optIns = optIns
        self.manifest = manifest
        self.blobsHex = blobsHex
        self.startEpochInclusive = startEpochInclusive
        self.endEpochExclusive = endEpochExclusive
        self.notaryPublicKey = notaryPublicKey
        self.notaryIsSignatory = notaryIsSignatory
        self.tipPercentage = tipPercentage
        self.nonce = nonce
        self.signerPublicKeys = signerPublicKeys
        self.message = message
        self.flags = flags
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case optIns = "opt_ins"
        case manifest
        case blobsHex = "blobs_hex"
        case startEpochInclusive = "start_epoch_inclusive"
        case endEpochExclusive = "end_epoch_exclusive"
        case notaryPublicKey = "notary_public_key"
        case notaryIsSignatory = "notary_is_signatory"
        case tipPercentage = "tip_percentage"
        case nonce
        case signerPublicKeys = "signer_public_keys"
        case message
        case flags
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(optIns, forKey: .optIns)
        try container.encode(manifest, forKey: .manifest)
        try container.encodeIfPresent(blobsHex, forKey: .blobsHex)
        try container.encode(startEpochInclusive, forKey: .startEpochInclusive)
        try container.encode(endEpochExclusive, forKey: .endEpochExclusive)
        try container.encodeIfPresent(notaryPublicKey, forKey: .notaryPublicKey)
        try container.encodeIfPresent(notaryIsSignatory, forKey: .notaryIsSignatory)
        try container.encode(tipPercentage, forKey: .tipPercentage)
        try container.encode(nonce, forKey: .nonce)
        try container.encode(signerPublicKeys, forKey: .signerPublicKeys)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encode(flags, forKey: .flags)
    }
}

}
