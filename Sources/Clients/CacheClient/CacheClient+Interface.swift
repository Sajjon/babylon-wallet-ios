import ClientPrelude
import EngineKit

// MARK: - CacheClient
public struct CacheClient: Sendable {
	public var save: Save
	public var load: Load
	public var removeFile: RemoveFile
	public var removeFolder: RemoveFolder
	public var removeAll: RemoveAll

	init(
		save: @escaping Save,
		load: @escaping Load,
		removeFile: @escaping RemoveFile,
		removeFolder: @escaping RemoveFolder,
		removeAll: @escaping RemoveAll
	) {
		self.save = save
		self.load = load
		self.removeFile = removeFile
		self.removeFolder = removeFolder
		self.removeAll = removeAll
	}
}

extension CacheClient {
	public typealias Save = @Sendable (Encodable, Entry) -> Void
	public typealias Load = @Sendable (Decodable.Type, Entry) throws -> Decodable
	public typealias RemoveFile = @Sendable (Entry) -> Void
	public typealias RemoveFolder = @Sendable (Entry) -> Void
	public typealias RemoveAll = @Sendable () -> Void
}

extension DependencyValues {
	public var cacheClient: CacheClient {
		get { self[CacheClient.self] }
		set { self[CacheClient.self] = newValue }
	}
}

// MARK: - InvalidateCachedDecision
public enum InvalidateCachedDecision {
	case cachedIsInvalid
	case cachedIsValid
}

extension CacheClient {
	public func withCaching<Model: Codable>(
		cacheEntry: Entry,
		forceRefresh: Bool = false,
		invalidateCached: (Model) -> InvalidateCachedDecision = { _ in .cachedIsValid },
		request: () async throws -> Model
	) async throws -> Model {
		@Sendable func fetchNew() async throws -> Model {
			let model = try await request()
			save(model, cacheEntry)
			return model
		}

		if !forceRefresh, let model = try? load(Model.self, cacheEntry) as? Model {
			switch invalidateCached(model) {
			case .cachedIsInvalid:
				removeFile(cacheEntry)
				return try await fetchNew()
			case .cachedIsValid:
				return model
			}
		} else {
			return try await fetchNew()
		}
	}
}

extension CacheClient {
	public enum Entry: Equatable {
		case accountPortfolio(AccountQuantifier)
		case onLedgerEntity(address: String)
		case networkName(_ url: String)
		case dAppMetadata(_ definitionAddress: String)
		case dAppRequestMetadata(_ definitionAddress: String)
		case rolaDappVerificationMetadata(_ definitionAddress: String)
		case rolaWellKnownFileVerification(_ url: String)

		public enum AccountQuantifier: Equatable {
			case single(_ address: String)
			case all
		}

		var filesystemFilePath: String {
			switch self {
			case let .accountPortfolio(address):
				return "\(filesystemFolderPath)/accountPortfolio-\(address)"
			case let .onLedgerEntity(address):
				return "\(filesystemFolderPath)/onLedgerEntity-\(address)"
			case let .networkName(url):
				return "\(filesystemFolderPath)/networkName-\(url)"
			case let .dAppMetadata(definitionAddress):
				return "\(filesystemFolderPath)/DappMetadata-\(definitionAddress)"
			case let .dAppRequestMetadata(definitionAddress):
				return "\(filesystemFolderPath)/DappRequestMetadata-\(definitionAddress)"
			case let .rolaDappVerificationMetadata(definitionAddress):
				return "\(filesystemFolderPath)/RolaDappVerificationMetadata-\(definitionAddress)"
			case let .rolaWellKnownFileVerification(url):
				return "\(filesystemFolderPath)/RolaWellKnownFileVerification-\(url)"
			}
		}

		var filesystemFolderPath: String {
			switch self {
			case .accountPortfolio:
				return "AccountPortfolio"
			case .onLedgerEntity:
				return "OnLedgerEntity"
			case .networkName:
				return "NetworkName"
			case .dAppMetadata:
				return "DappMetadata"
			case .dAppRequestMetadata:
				return "DappRequestMetadata"
			case .rolaDappVerificationMetadata:
				return "RolaDappVerificationMetadata"
			case .rolaWellKnownFileVerification:
				return "RolaWellKnownFileVerification"
			}
		}

		var expirationDateFilePath: String {
			"\(filesystemFilePath)-expirationDate"
		}

		var lifetime: TimeInterval {
			switch self {
			case .accountPortfolio, .networkName, .onLedgerEntity:
				return 300
			case .dAppMetadata, .dAppRequestMetadata, .rolaDappVerificationMetadata, .rolaWellKnownFileVerification:
				return 60
			}
		}
	}

	public enum Error: Swift.Error {
		case dataLoadingFailed
		case expirationDateLoadingFailed
		case entryLifetimeExpired
	}
}

extension CacheClient {
	@Sendable
	public func clearCacheForAccounts(
		_ accounts: Set<AccountAddress> = .init()
	) {
		if !accounts.isEmpty {
			accounts.forEach { removeFile(.accountPortfolio(.single($0.address))) }
		} else {
			removeFolder(.accountPortfolio(.all))
		}
	}
}
