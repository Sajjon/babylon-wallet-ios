import Foundation

// MARK: - SetComponentRoyaltyConfig
public struct SetComponentRoyaltyConfig: InstructionProtocol {
	// Type name, used as a discriminator
	public static let kind: InstructionKind = .setComponentRoyaltyConfig
	public func embed() -> Instruction {
		.setComponentRoyaltyConfig(self)
	}

	// MARK: Stored properties

	public let componentAddress: ComponentAddress
	public let royaltyConfig: ManifestASTValue

	// MARK: Init

	public init(componentAddress: ComponentAddress, royaltyConfig: ManifestASTValue) {
		self.componentAddress = componentAddress
		self.royaltyConfig = royaltyConfig
	}
}

extension SetComponentRoyaltyConfig {
	// MARK: CodingKeys

	private enum CodingKeys: String, CodingKey {
		case type = "instruction"
		case componentAddress = "component_address"
		case royaltyConfig = "royalty_config"
	}

	// MARK: Codable

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(Self.kind, forKey: .type)

		try container.encodeValue(componentAddress, forKey: .componentAddress)
		try container.encode(royaltyConfig, forKey: .royaltyConfig)
	}

	public init(from decoder: Decoder) throws {
		// Checking for type discriminator
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let kind: InstructionKind = try container.decode(InstructionKind.self, forKey: .type)
		if kind != Self.kind {
			throw InternalDecodingFailure.instructionTypeDiscriminatorMismatch(expected: Self.kind, butGot: kind)
		}

		try self.init(
			componentAddress: container.decodeValue(forKey: .componentAddress),
			royaltyConfig: container.decode(ManifestASTValue.self, forKey: .royaltyConfig)
		)
	}
}