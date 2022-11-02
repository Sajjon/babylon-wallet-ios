// Extensions.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - Bool + JSONEncodable
extension Bool: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - Float + JSONEncodable
extension Float: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - Int + JSONEncodable
extension Int: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - Int32 + JSONEncodable
extension Int32: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - Int64 + JSONEncodable
extension Int64: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - Double + JSONEncodable
extension Double: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - String + JSONEncodable
extension String: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - URL + JSONEncodable
extension URL: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

// MARK: - UUID + JSONEncodable
extension UUID: JSONEncodable {
	func encodeToJSON() -> Any { self }
}

extension RawRepresentable where RawValue: JSONEncodable {
	func encodeToJSON() -> Any { rawValue }
}

private func encodeIfPossible<T>(_ object: T) -> Any {
	if let encodableObject = object as? JSONEncodable {
		return encodableObject.encodeToJSON()
	} else {
		return object
	}
}

// MARK: - Array + JSONEncodable
extension Array: JSONEncodable {
	func encodeToJSON() -> Any {
		map(encodeIfPossible)
	}
}

// MARK: - Set + JSONEncodable
extension Set: JSONEncodable {
	func encodeToJSON() -> Any {
		Array(self).encodeToJSON()
	}
}

// MARK: - Dictionary + JSONEncodable
extension Dictionary: JSONEncodable {
	func encodeToJSON() -> Any {
		var dictionary = [AnyHashable: Any]()
		for (key, value) in self {
			dictionary[key] = encodeIfPossible(value)
		}
		return dictionary
	}
}

// MARK: - Data + JSONEncodable
extension Data: JSONEncodable {
	func encodeToJSON() -> Any {
		base64EncodedString(options: Data.Base64EncodingOptions())
	}
}

// MARK: - Date + JSONEncodable
extension Date: JSONEncodable {
	func encodeToJSON() -> Any {
		CodableHelper.dateFormatter.string(from: self)
	}
}

extension JSONEncodable where Self: Encodable {
	func encodeToJSON() -> Any {
		guard let data = try? CodableHelper.jsonEncoder.encode(self) else {
			fatalError("Could not encode to json: \(self)")
		}
		return data.encodeToJSON()
	}
}

// MARK: - String + CodingKey
extension String: CodingKey {
	public var stringValue: String {
		self
	}

	public init?(stringValue: String) {
		self.init(stringLiteral: stringValue)
	}

	public var intValue: Int? {
		nil
	}

	public init?(intValue _: Int) {
		nil
	}
}

public extension KeyedEncodingContainerProtocol {
	mutating func encodeArray<T>(_ values: [T], forKey key: Self.Key) throws where T: Encodable {
		var arrayContainer = nestedUnkeyedContainer(forKey: key)
		try arrayContainer.encode(contentsOf: values)
	}

	mutating func encodeArrayIfPresent<T>(_ values: [T]?, forKey key: Self.Key) throws where T: Encodable {
		if let values = values {
			try encodeArray(values, forKey: key)
		}
	}

	mutating func encodeMap<T>(_ pairs: [Self.Key: T]) throws where T: Encodable {
		for (key, value) in pairs {
			try encode(value, forKey: key)
		}
	}

	mutating func encodeMapIfPresent<T>(_ pairs: [Self.Key: T]?) throws where T: Encodable {
		if let pairs = pairs {
			try encodeMap(pairs)
		}
	}
}

public extension KeyedDecodingContainerProtocol {
	func decodeArray<T>(_: T.Type, forKey key: Self.Key) throws -> [T] where T: Decodable {
		var tmpArray = [T]()

		var nestedContainer = try nestedUnkeyedContainer(forKey: key)
		while !nestedContainer.isAtEnd {
			let arrayValue = try nestedContainer.decode(T.self)
			tmpArray.append(arrayValue)
		}

		return tmpArray
	}

	func decodeArrayIfPresent<T>(_: T.Type, forKey key: Self.Key) throws -> [T]? where T: Decodable {
		var tmpArray: [T]?

		if contains(key) {
			tmpArray = try decodeArray(T.self, forKey: key)
		}

		return tmpArray
	}

	func decodeMap<T>(_: T.Type, excludedKeys: Set<Self.Key>) throws -> [Self.Key: T] where T: Decodable {
		var map: [Self.Key: T] = [:]

		for key in allKeys {
			if !excludedKeys.contains(key) {
				let value = try decode(T.self, forKey: key)
				map[key] = value
			}
		}

		return map
	}
}

extension HTTPURLResponse {
	var isStatusCodeSuccessful: Bool {
		(200 ..< 300).contains(statusCode)
	}
}