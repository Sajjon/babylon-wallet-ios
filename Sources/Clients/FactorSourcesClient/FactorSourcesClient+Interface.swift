import ClientPrelude
import Profile

// MARK: - FactorSourcesClient
public struct FactorSourcesClient: Sendable {
	public var getCurrentNetworkID: GetCurrentNetworkID
	public var getFactorSources: GetFactorSources
	public var factorSourcesAsyncSequence: FactorSourcesAsyncSequence
	public var addPrivateHDFactorSource: AddPrivateHDFactorSource
	public var checkIfHasOlympiaFactorSourceForAccounts: CheckIfHasOlympiaFactorSourceForAccounts
	public var saveFactorSource: SaveFactorSource
	public var getSigningFactors: GetSigningFactors
	public var updateLastUsed: UpdateLastUsed

	public init(
		getCurrentNetworkID: @escaping GetCurrentNetworkID,
		getFactorSources: @escaping GetFactorSources,
		factorSourcesAsyncSequence: @escaping FactorSourcesAsyncSequence,
		addPrivateHDFactorSource: @escaping AddPrivateHDFactorSource,
		checkIfHasOlympiaFactorSourceForAccounts: @escaping CheckIfHasOlympiaFactorSourceForAccounts,
		saveFactorSource: @escaping SaveFactorSource,
		getSigningFactors: @escaping GetSigningFactors,
		updateLastUsed: @escaping UpdateLastUsed
	) {
		self.getCurrentNetworkID = getCurrentNetworkID
		self.getFactorSources = getFactorSources
		self.factorSourcesAsyncSequence = factorSourcesAsyncSequence
		self.addPrivateHDFactorSource = addPrivateHDFactorSource
		self.checkIfHasOlympiaFactorSourceForAccounts = checkIfHasOlympiaFactorSourceForAccounts
		self.saveFactorSource = saveFactorSource
		self.getSigningFactors = getSigningFactors
		self.updateLastUsed = updateLastUsed
	}
}

// MARK: FactorSourcesClient.GetFactorSources
extension FactorSourcesClient {
	public typealias GetCurrentNetworkID = @Sendable () async -> NetworkID
	public typealias GetFactorSources = @Sendable () async throws -> FactorSources
	public typealias FactorSourcesAsyncSequence = @Sendable () async -> AnyAsyncSequence<FactorSources>
	public typealias AddPrivateHDFactorSource = @Sendable (AddPrivateHDFactorSourceRequest) async throws -> FactorSourceID
	public typealias CheckIfHasOlympiaFactorSourceForAccounts = @Sendable (NonEmpty<OrderedSet<OlympiaAccountToMigrate>>) async -> FactorSourceID?
	public typealias SaveFactorSource = @Sendable (FactorSource) async throws -> Void
	public typealias GetSigningFactors = @Sendable (GetSigningFactorsRequest) async throws -> SigningFactors
	public typealias UpdateLastUsed = @Sendable (UpdateFactorSourceLastUsedRequest) async throws -> Void
}

// MARK: - AddPrivateHDFactorSourceRequest
public struct AddPrivateHDFactorSourceRequest: Sendable, Hashable {
	public let privateFactorSource: PrivateHDFactorSource
	/// E.g. import babylon factor sources should only be saved keychain, not profile (already there).
	public let saveIntoProfile: Bool
	public init(privateFactorSource: PrivateHDFactorSource, saveIntoProfile: Bool) {
		self.privateFactorSource = privateFactorSource
		self.saveIntoProfile = saveIntoProfile
	}
}

public typealias SigningFactors = OrderedDictionary<FactorSourceKind, NonEmpty<Set<SigningFactor>>>

extension SigningFactors {
	public var expectedSignatureCount: Int {
		values.flatMap { $0.map(\.expectedSignatureCount) }.reduce(0, +)
	}
}

// MARK: - GetSigningFactorsRequest
public struct GetSigningFactorsRequest: Sendable, Hashable {
	public let networkID: NetworkID
	public let signers: NonEmpty<Set<EntityPotentiallyVirtual>>
	public let signingPurpose: SigningPurpose
	public init(networkID: NetworkID, signers: NonEmpty<Set<EntityPotentiallyVirtual>>, signingPurpose: SigningPurpose) {
		self.networkID = networkID
		self.signers = signers
		self.signingPurpose = signingPurpose
	}
}

extension FactorSourcesClient {
	public func getFactorSource(
		id: FactorSourceID,
		matching filter: @escaping (FactorSource) -> Bool = { _ in true }
	) async throws -> FactorSource? {
		try await getFactorSources(matching: filter)[id: id]
	}

	public func getDeviceFactorSource(
		of hdFactorInstance: HierarchicalDeterministicFactorInstance
	) async throws -> HDOnDeviceFactorSource? {
		guard let factorSource = try await getFactorSource(of: hdFactorInstance.factorInstance) else {
			return nil
		}
		return try HDOnDeviceFactorSource(factorSource: factorSource)
	}

	public func getFactorSource(
		id: FactorSourceID,
		ensureKind kind: FactorSourceKind
	) async throws -> FactorSource? {
		try await getFactorSource(id: id) { $0.kind == kind }
	}

	public func getFactorSource(
		of factorInstance: FactorInstance
	) async throws -> FactorSource? {
		try await getFactorSource(id: factorInstance.factorSourceID)
	}

	public func getFactorSources(
		matching filter: (FactorSource) -> Bool
	) async throws -> IdentifiedArrayOf<FactorSource> {
		try await IdentifiedArrayOf(uniqueElements: getFactorSources().filter(filter))
	}

	public func getFactorSources(
		ofKind kind: FactorSourceKind
	) async throws -> IdentifiedArrayOf<FactorSource> {
		try await getFactorSources(matching: { $0.kind == kind })
	}
}

// MARK: - UpdateFactorSourceLastUsedRequest
public struct UpdateFactorSourceLastUsedRequest: Sendable, Hashable {
	public let factorSourceIDs: [FactorSource.ID]
	public let lastUsedOn: Date
	public let usagePurpose: SigningPurpose
	public init(
		factorSourceIDs: [FactorSource.ID],
		usagePurpose: SigningPurpose,
		lastUsedOn: Date = .init()
	) {
		self.factorSourceIDs = factorSourceIDs
		self.usagePurpose = usagePurpose
		self.lastUsedOn = lastUsedOn
	}
}

// MARK: - MnemonicBasedFactorSourceKind
public enum MnemonicBasedFactorSourceKind: Sendable, Hashable {
	public enum OnDeviceMnemonicKind: Sendable, Hashable {
		case babylon
		case olympia
	}

	case onDevice(OnDeviceMnemonicKind)
	case offDevice
}

// MARK: - SigningFactor
public struct SigningFactor: Sendable, Hashable, Identifiable {
	public typealias ID = FactorSource.ID
	public var id: ID { factorSource.id }
	public let factorSource: FactorSource
	public var signers: NonEmpty<IdentifiedArrayOf<Signer>>

	public var expectedSignatureCount: Int {
		signers.map(\.factorInstancesRequiredToSign.count).reduce(0, +)
	}

	public init(
		factorSource: FactorSource,
		signers: NonEmpty<IdentifiedArrayOf<Signer>>
	) {
		self.factorSource = factorSource
		self.signers = signers
	}

	public init(
		factorSource: FactorSource,
		signer: Signer
	) {
		self.init(
			factorSource: factorSource,
			signers: .init(rawValue: .init(uniqueElements: [signer]))! // ok to force unwrap since we know we have one element.
		)
	}
}

extension FactorSourcesClient {
	public func addOffDeviceFactorSource(
		mnemonicWithPassphrase: MnemonicWithPassphrase,
		label: FactorSource.Label,
		description: FactorSource.Description
	) async throws -> FactorSourceID {
		let privateFactorSource = try FactorSource.offDeviceMnemonic(
			withPassphrase: mnemonicWithPassphrase,
			label: label,
			description: description
		)
		return try await addPrivateHDFactorSource(.init(
			privateFactorSource: privateFactorSource,
			saveIntoProfile: true
		))
	}

	public func addOnDeviceFactorSource(
		onDeviceMnemonicKind: MnemonicBasedFactorSourceKind.OnDeviceMnemonicKind,
		mnemonicWithPassphrase: MnemonicWithPassphrase
	) async throws -> FactorSourceID {
		let isOlympia = onDeviceMnemonicKind == .olympia
		let hdOnDeviceFactorSource: HDOnDeviceFactorSource = isOlympia ? try FactorSource.olympia(
			mnemonicWithPassphrase: mnemonicWithPassphrase
		) : try FactorSource.babylon(mnemonicWithPassphrase: mnemonicWithPassphrase).hdOnDeviceFactorSource

		let privateFactorSource = try PrivateHDFactorSource(
			mnemonicWithPassphrase: mnemonicWithPassphrase,
			factorSource: hdOnDeviceFactorSource.factorSource
		)
		return try await addPrivateHDFactorSource(.init(
			privateFactorSource: privateFactorSource,
			saveIntoProfile: isOlympia
		))
	}
}

// Move elsewhere?
import Cryptography
extension MnemonicWithPassphrase {
	@discardableResult
	public func validatePublicKeysOf(
		softwareAccounts: NonEmpty<OrderedSet<OlympiaAccountToMigrate>>
	) throws -> Bool {
		let hdRoot = try self.hdRoot()

		for olympiaAccount in softwareAccounts {
			let path = olympiaAccount.path.fullPath

			let derivedPublicKey = try hdRoot.derivePrivateKey(
				path: path,
				curve: SECP256K1.self
			).publicKey

			guard derivedPublicKey == olympiaAccount.publicKey else {
				throw ValidateOlympiaAccountsFailure.publicKeyMismatch
			}
		}
		// PublicKeys matches
		return true
	}
}

// MARK: - ValidateOlympiaAccountsFailure
enum ValidateOlympiaAccountsFailure: LocalizedError {
	case publicKeyMismatch
}
