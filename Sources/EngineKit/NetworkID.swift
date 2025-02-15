import Tagged

// MARK: - NetworkIDType

// TODO: move this type to Network.swift.
//
// public typealias NetworkID = Network.ID // or even deprecate it?
//
// ```
// public struct Network {
//     public typealias ID = Tagged<(Self, id: ()), UInt8>
// }
// ```
//
// Probably best to do when we move all models into a single package.

// TODO: We need a better type that we can serialize to a string.
public typealias NetworkID = Tagged<(network: (), id: ()), UInt8>

extension NetworkID {
	/// Public Facing Permanent Networks (0x00 - 0x09)
	// - mainnet
	// - stokenet

	/// Mainnet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L77
	/// Decimal value: 01
	public static let mainnet: Self = 0x01

	/// Stokenet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L78
	/// Decimal value: 02
	public static let stokenet: Self = 0x02

	/// Babylon Temporary Testnets (0x0a - 0x0f)
	// - adapanet = Babylon Alphanet, after Adapa
	// - nebunet = Babylon Betanet, after Nebuchadnezzar

	/// Adapanet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L83
	/// Decimal value: 10
	public static let adapanet: Self = 0x0A

	/// Nebunet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L84
	/// Decimal value: 11
	public static let nebunet: Self = 0x0B

	/// Kisharnet
	/// NB: The entry does not (yet?) exist at this line:
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L85
	/// Decimal value: 12
	public static let kisharnet: Self = 0x0C

	/// https://github.com/radixdlt/babylon-node/blob/96be25b8fb4beacf80f22f22ef8ece9ce55b68b4/common/src/main/java/com/radixdlt/networks/Network.java#L98
	public static let ansharnet: Self = 0x0D

	/// Zabanet
	/// Decimal value: 14
	public static let zabanet: Self = 0x0E

	/// RDX Development - Semi-permanent Testnets (start with 0x2)
	// - gilganet = Integration, after Gilgamesh
	// - enkinet = Misc Network 1, after Enki / Enkidu
	// - hammunet = Misc Network 2, after Hammurabi
	// - nergalnet = A Network for DevOps testing, after the Mesopotamian god Nergal
	// - mardunet = A staging Network for testing new releases to the primary public environment,
	//              after the Babylonian god Marduk

	/// Gilganet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L
	/// Decimal value: 32
	public static let gilganet: Self = 0x20

	/// Enkinet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L94
	/// Decimal value: 33
	public static let enkinet: Self = 0x21

	/// Hammunet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L95
	/// Decimal value: 34
	public static let hammunet: Self = 0x22

	/// Nergalnet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L96
	/// Decimal value: 35
	public static let nergalnet: Self = 0x23

	/// Mardunet
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L97
	/// Decimal value: 36
	public static let mardunet: Self = 0x24

	/// Ephemeral Networks (start with 0xF)
	// - localnet = The network used when running locally in development
	// - inttestnet = The network used when running integration tests

	/// Local Simulator
	/// https://github.com/radixdlt/babylon-node/blob/main/common/src/main/java/com/radixdlt/networks/Network.java#L104
	/// Decimal value: 242
	public static let simulator: Self = 0xF2
}

extension NetworkID {
	public typealias AllCases = [Self]

	public static var allCases: [NetworkID] {
		[.mainnet, .stokenet, .adapanet, .nebunet, .kisharnet, .gilganet, .enkinet, .hammunet, .nergalnet, .mardunet, .zabanet, .simulator]
	}

	public static func all(but excluded: NetworkID) -> AllCases {
		var allBut = allCases
		allBut.removeAll(where: { $0 == excluded })
		return allBut
	}
}
