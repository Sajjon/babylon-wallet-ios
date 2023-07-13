import Foundation

// MARK: - Engine.EcdsaSecp256k1PublicKey
extension Engine {
	public struct EcdsaSecp256k1PublicKey: Sendable, Codable, Hashable {
		// MARK: Stored properties
		public let bytes: [UInt8]

		// MARK: Init
		public init(bytes: [UInt8]) {
			self.bytes = bytes
		}

		public init(hex: String) throws {
			// TODO: Validation of length of array
			try self.init(bytes: [UInt8](hex: hex))
		}
	}
}

extension Engine.EcdsaSecp256k1PublicKey {
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case value, type
	}

	// MARK: Codable
	public func encode(to encoder: Encoder) throws {
		var container: SingleValueEncodingContainer = encoder.singleValueContainer()
		try container.encode(bytes.hex())
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		try self.init(hex: container.decode(String.self))
	}
}