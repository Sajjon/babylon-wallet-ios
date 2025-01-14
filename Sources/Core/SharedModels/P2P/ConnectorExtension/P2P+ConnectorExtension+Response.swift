import Prelude
import Profile
import Tagged

// MARK: - P2P.ConnectorExtension.Response
extension P2P.ConnectorExtension {
	/// A response received from connector extension for some request we have sent.
	public enum Response: Sendable, Hashable, Decodable {
		/// Messages sent from Connector Extension being a response
		/// from an interaction with a Ledger hardware wallet by LedgerHQ,
		/// e.g. Ledger Nano S
		case ledgerHardwareWallet(LedgerHardwareWallet)

		public init(from decoder: Decoder) throws {
			self = try .ledgerHardwareWallet(.init(from: decoder))
		}
	}
}

// MARK: - P2P.ConnectorExtension.Response.LedgerHardwareWallet
extension P2P.ConnectorExtension.Response {
	/// Message sent from Connector Extension being a response
	/// from an interaction with a Ledger hardware wallet by LedgerHQ,
	/// e.g. Ledger Nano S
	public struct LedgerHardwareWallet: Sendable, Hashable, Decodable {
		public let interactionID: P2P.LedgerHardwareWallet.InteractionId
		public let discriminator: P2P.LedgerHardwareWallet.Discriminator
		public let response: Result<Success, Failure>
	}
}

// MARK: - P2P.ConnectorExtension.Response.LedgerHardwareWallet.Failure
extension P2P.ConnectorExtension.Response.LedgerHardwareWallet {
	public struct Failure: LocalizedError, Sendable, Hashable, Decodable {
		public enum Reason: Int, Sendable, Hashable, Decodable {
			case generic = 0
			case blindSigningNotEnabledButRequired = 1
			public var userFacingErrorDescription: String {
				switch self {
				case .generic:
					return "Unknown" // FIXME: Strings
				case .blindSigningNotEnabledButRequired:
					return "Blind signing not enabled but required" // FIXME: Strings
				}
			}
		}

		public let code: Reason
		public let message: String
		public var errorDescription: String? {
			var description = code.userFacingErrorDescription
			#if DEBUG
			return "[DEBUG ONLY] \(description)\nmessage from Ledger: '\(message)'"
			#else
			return description
			#endif
		}

		public enum CodingKeys: CodingKey {
			case code
			case message
		}
	}
}

extension P2P.ConnectorExtension.Response.LedgerHardwareWallet.Failure {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let codeRaw = try container.decode(Reason.RawValue.self, forKey: .code)
		let code = Reason(rawValue: codeRaw) ?? .generic
		let message = try container.decode(String.self, forKey: .message)
		self.init(code: code, message: message)
	}
}

extension P2P.ConnectorExtension.Response.LedgerHardwareWallet {
	public enum Success: Sendable, Hashable {
		case getDeviceInfo(GetDeviceInfo)
		case derivePublicKeys([DerivedPublicKey])
		case signTransaction([SignatureOfSigner])
		case signChallenge([SignatureOfSigner])
		case deriveAndDisplayAddress(DerivedAddress)

		public struct GetDeviceInfo: Sendable, Hashable, Decodable {
			public let id: HexCodable32Bytes
			public let model: P2P.LedgerHardwareWallet.Model

			public init(
				id: HexCodable32Bytes,
				model: P2P.LedgerHardwareWallet.Model
			) {
				self.id = id
				self.model = model
			}
		}

		public struct DerivedAddress: Sendable, Hashable, Decodable {
			public let derivedKey: DerivedPublicKey
			public let address: String
		}

		public struct DerivedPublicKey: Sendable, Hashable, Decodable {
			public let curve: String
			public let derivationPath: String
			public let publicKey: HexCodable

			public init(
				curve: String,
				derivationPath: String,
				publicKey: HexCodable
			) {
				self.curve = curve
				self.derivationPath = derivationPath
				self.publicKey = publicKey
			}
		}

		public struct SignatureOfSigner: Sendable, Hashable, Decodable {
			public let signature: HexCodable
			public let derivedPublicKey: DerivedPublicKey

			public init(
				derivedPublicKey: DerivedPublicKey,
				signature: HexCodable
			) {
				self.derivedPublicKey = derivedPublicKey
				self.signature = signature
			}
		}
	}

	private typealias CodingKeys = P2P.LedgerHardwareWallet.CodingKeys

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let discriminator = try container.decode(
			P2P.LedgerHardwareWallet.Discriminator.self,
			forKey: .discriminator
		)
		self.discriminator = discriminator
		self.interactionID = try container.decode(P2P.LedgerHardwareWallet.InteractionId.self, forKey: .interactionID)

		func decodeResponse<T: Decodable>(embed: (T) -> Success) throws -> Result<Success, Failure> {
			do {
				let success = try container.decode(T.self, forKey: .success)
				return .success(embed(success))
			} catch {
				return try .failure(container.decode(Failure.self, forKey: .error))
			}
		}
		switch discriminator {
		case .derivePublicKeys:
			self.response = try decodeResponse {
				Success.derivePublicKeys($0)
			}
		case .getDeviceInfo:
			self.response = try decodeResponse {
				Success.getDeviceInfo($0)
			}
		case .signTransaction:
			self.response = try decodeResponse {
				Success.signTransaction($0)
			}
		case .signChallenge:
			self.response = try decodeResponse {
				Success.signChallenge($0)
			}

		case .deriveAndDisplayAddress:
			self.response = try decodeResponse {
				Success.deriveAndDisplayAddress($0)
			}
		}
	}
}
