import Cryptography
import EngineToolkit
import Prelude
import ProfileModels

// MARK: - EncodeAddressRequest
// FIXME: replace with real EngineToolKit once we added binaries and made a release.
struct EncodeAddressRequest {
	let data: Data
	let addressKind: ProfileModels.AddressKind // This is missing in EngineToolkit today
	let networkID: NetworkID

	init(
		publicKey: SLIP10.PublicKey,
		addressKind: ProfileModels.AddressKind,
		networkID: NetworkID
	) {
		// https://rdxworks.slack.com/archives/C040KJQN5CL/p1665740463911069?thread_ts=1665738831.815739&cid=C040KJQN5CL
		self.data = publicKey.compressedData.prefix(25)
		self.addressKind = addressKind
		self.networkID = networkID
	}
}

public extension Profile {
	static func new(
		networkAndGateway: AppPreferences.NetworkAndGateway,
		mnemonic: Mnemonic,
		bip39Passphrase: String = "",
		firstAccountDisplayName: String? = "Main"
	) async throws -> Self {
		let curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource = try Curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource(
			mnemonic: mnemonic,
			bip39Passphrase: bip39Passphrase
		)

		return try await Self.new(
			networkAndGateway: networkAndGateway,
			firstAccountDisplayName: firstAccountDisplayName,
			curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource: curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource,
			createFactorInstance: { (createFactorInstanceRequest: CreateFactorInstanceRequest) async throws -> AnyCreateFactorInstanceForResponse? in
				switch createFactorInstanceRequest {
				case let .fromNonHardwareHierarchicalDeterministicMnemonicFactorSource(nonHWHDRequest):
					guard curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource.reference == nonHWHDRequest.reference else {
						return nil
					}
					let createFactorInstanceForResponse = try await curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource.createInstance(
						input: .init(
							mnemonic: mnemonic,
							bip39Passphrase: bip39Passphrase,
							derivationPath: nonHWHDRequest.derivationPath,
							includePrivateKey: false
						)
					)
					return try createFactorInstanceForResponse.eraseToAny()
				}
			}
		)
	}

	static func new(
		networkAndGateway: AppPreferences.NetworkAndGateway,
		firstAccountDisplayName: String?,
		curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource: Curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource,
		createFactorInstance: @escaping CreateFactorInstanceForRequest
	) async throws -> Self {
		let network = networkAndGateway.network
		let networkID = network.id
		let nonEmptyFactorSource = NonEmpty(
			rawValue: OrderedSet(
				[curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSource]
			)
		)!

		let factorSources = FactorSources(curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSources: nonEmptyFactorSource)

		let account0 = try await Self.createNewVirtualAccount(
			factorSources: factorSources,
			accountIndex: 0,
			networkID: networkID,
			displayName: firstAccountDisplayName,
			createFactorInstance: createFactorInstance
		)

		let onNetwork = OnNetwork(
			networkID: networkID,
			accounts: .init(rawValue: .init([account0]))!,
			personas: [],
			connectedDapps: []
		)

		let appPreferences = AppPreferences(
			display: .default,
			p2pClients: [],
			networkAndGateway: networkAndGateway
		)

		return Self(
			factorSources: factorSources,
			appPreferences: appPreferences,
			perNetwork: .init(onNetwork: onNetwork)
		)
	}
}

// MARK: - NoInstance
internal struct NoInstance: Swift.Error {}

// MARK: - FailedToFindFactorSource
internal struct FailedToFindFactorSource: Swift.Error {}

internal extension Profile {
	mutating func updateOnNetwork(_ onNetwork: OnNetwork) throws {
		try perNetwork.update(onNetwork)
	}
}

public extension Profile {
	func onNetwork(id needle: NetworkID) throws -> OnNetwork {
		try perNetwork.onNetwork(id: needle)
	}

	func containsNetwork(withID networkID: NetworkID) -> Bool {
		(try? onNetwork(id: networkID)) != nil
	}
}

// MARK: - WrongAddressType
struct WrongAddressType: Swift.Error {}