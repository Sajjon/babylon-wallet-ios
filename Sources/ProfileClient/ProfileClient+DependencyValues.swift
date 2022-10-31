import Dependencies
import Foundation

// MARK: - ProfileClientKey
public extension ProfileClient {
	static let liveValue = Self.live()

	#if DEBUG
	static let testValue = Self.mock()
	#endif // DEBUG
}

public extension DependencyValues {
	var profileClient: ProfileClient {
		get { self[ProfileClient.self] }
		set { self[ProfileClient.self] = newValue }
	}
}
