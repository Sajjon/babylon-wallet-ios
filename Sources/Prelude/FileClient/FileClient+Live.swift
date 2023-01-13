import Dependencies

extension FileClient: DependencyKey {
	public static let liveValue = Self(
		read: { url, options in try Data(contentsOf: url, options: options) }
	)
}