// MARK: - SborDecodeRequest
public struct SborDecodeRequest: Sendable, Codable, Hashable {
	// MARK: Stored properties

	public let encodedValue: [UInt8]
	public let networkId: NetworkID

	// MARK: Init

	public init(encodedBytes: [UInt8], networkId: NetworkID) {
		self.encodedValue = encodedBytes
		self.networkId = networkId
	}

	public init(encodedHex: String, networkId: NetworkID) throws {
		try self.init(encodedBytes: [UInt8](hex: encodedHex), networkId: networkId)
	}
}

extension SborDecodeRequest {
	// MARK: CodingKeys

	private enum CodingKeys: String, CodingKey {
		case encodedValue = "encoded_value"
		case networkId = "network_id"
	}

	// MARK: Codable

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(encodedValue.hex(), forKey: .encodedValue)
		try container.encode(String(networkId), forKey: .networkId)
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		try self.init(
			encodedHex: container.decode(String.self, forKey: .encodedValue),
			networkId: NetworkID(decodeAndConvertToNumericType(container: container, key: .networkId))
		)
	}
}

// MARK: - SborDecodeResponse
public struct SborDecodeResponse: Sendable, Codable, Hashable {
	public let value: Value_

	public init(value: Value_) {
		self.value = value
	}
}

extension SborDecodeResponse {
	private enum CodingKeys: String, CodingKey {
		case value
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(value, forKey: .value)
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		try self.init(value: container.decode(Value_.self, forKey: .value))
	}
}