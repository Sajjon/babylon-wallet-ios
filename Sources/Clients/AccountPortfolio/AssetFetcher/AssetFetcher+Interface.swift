import ClientPrelude
import struct Profile.AccountAddress // FIXME: should probably be in ProfileModels so we can remove this import altogether

// MARK: - AssetFetcher
public struct AssetFetcher: Sendable {
	public var fetchAssets: FetchAssets

	public init(
		fetchAssets: @escaping FetchAssets
	) {
		self.fetchAssets = fetchAssets
	}
}

// MARK: AssetFetcher.FetchAssets
public extension AssetFetcher {
	typealias FetchAssets = @Sendable (AccountAddress) async throws -> AccountPortfolio
}

public extension DependencyValues {
	var assetFetcher: AssetFetcher {
		get { self[AssetFetcher.self] }
		set { self[AssetFetcher.self] = newValue }
	}
}
