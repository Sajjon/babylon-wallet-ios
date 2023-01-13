import Foundation

// MARK: - WebRTCPeerConnectionConfig
public struct WebRTCPeerConnectionConfig: Sendable, Hashable, Codable, CustomStringConvertible {
	public let iceServerConfigs: [ICEServerConfig]
	public let sdpSemantics: WebRTCSDPSemantics
	public let continualGatheringPolicy: WebRTCContinualGatheringPolicy

	public init(
		iceServerConfigs: [ICEServerConfig] = .default,
		sdpSemantics: WebRTCSDPSemantics = .unifiedPlan,
		continualGatheringPolicy: WebRTCContinualGatheringPolicy = .gatherContinually
	) {
		self.iceServerConfigs = iceServerConfigs
		self.sdpSemantics = sdpSemantics
		self.continualGatheringPolicy = continualGatheringPolicy
	}

	public static let `default` = Self()
}

public extension WebRTCPeerConnectionConfig {
	var description: String {
		"""
		iceServerConfigs: \(iceServerConfigs),
		sdpSemantics: \(sdpSemantics),
		continualGatheringPolicy: \(continualGatheringPolicy)
		"""
	}
}

#if DEBUG
public extension WebRTCPeerConnectionConfig {
	static let placeholder = Self(
		iceServerConfigs: [],
		sdpSemantics: .unifiedPlan,
		continualGatheringPolicy: .gatherOnce
	)
}
#endif // DEBUG