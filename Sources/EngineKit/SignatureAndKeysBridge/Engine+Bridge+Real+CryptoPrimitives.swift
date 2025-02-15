import Cryptography
import EngineToolkit
import Prelude

extension SLIP10.PublicKey {
	public init(engine enginePublicKey: PublicKey) throws {
		switch enginePublicKey {
		case let .ed25519(key):
			self = try .eddsaEd25519(Curve25519.Signing.PublicKey(rawRepresentation: key.bytes))
		case let .secp256k1(key):
			self = try .ecdsaSecp256k1(.init(compressedRepresentation: key.bytes))
		}
	}
}

extension SLIP10.PublicKey {
	public func intoEngine() -> PublicKey {
		switch self {
		case let .ecdsaSecp256k1(key):
			return .secp256k1(value: Array(key.compressedRepresentation))
		case let .eddsaEd25519(key):
			return .ed25519(value: [UInt8](key.rawRepresentation))
		}
	}
}

extension SLIP10.Signature {
	public init(engine engineSignature: Signature) throws {
		switch engineSignature {
		case let .ed25519(signature):
			// TODO: validate
			self = .eddsaEd25519(Data(signature.bytes))
		case let .secp256k1(signature):
			self = try .ecdsaSecp256k1(.init(compact: .init(rawRepresentation: Data(signature.bytes), format: .vrs)))
		}
	}
}

extension K1.PublicKey {
	public func intoEngine() -> EngineToolkit.PublicKey {
		.secp256k1(value: Array(compressedRepresentation))
	}
}

extension Cryptography.SignatureWithPublicKey {
	public func intoEngine() throws -> EngineToolkit.SignatureWithPublicKey {
		switch self {
		case let .ecdsaSecp256k1(signature, _):
			return try .secp256k1(signature: Array(signature.radixSerialize()))
		case let .eddsaEd25519(signature, publicKey):
			return .ed25519(
				signature: [UInt8](signature),
				publicKey: [UInt8](publicKey.rawRepresentation)
			)
		}
	}
}
