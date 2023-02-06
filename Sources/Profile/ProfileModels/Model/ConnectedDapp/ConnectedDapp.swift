import Prelude

// MARK: - OnNetwork.ConnectedDapp
public extension OnNetwork {
	/// A connection made between a Radix Dapp and the user.
	struct ConnectedDapp:
		Sendable,
		Hashable,
		Codable,
		Identifiable,
		CustomStringConvertible,
		CustomDumpReflectable
	{
		public let networkID: Network.ID

		public let dAppDefinitionAddress: DappDefinitionAddress

		public let displayName: NonEmpty<String>

		// mutable so that we can add new authorized personas
		public var referencesToAuthorizedPersonas: IdentifiedArrayOf<AuthorizedPersonaSimple>

		public init(
			networkID: Network.ID,
			dAppDefinitionAddress: DappDefinitionAddress,
			displayName: NonEmpty<String>,
			referencesToAuthorizedPersonas: IdentifiedArrayOf<AuthorizedPersonaSimple> = .init()
		) {
			self.networkID = networkID
			self.dAppDefinitionAddress = dAppDefinitionAddress
			self.displayName = displayName
			self.referencesToAuthorizedPersonas = referencesToAuthorizedPersonas
		}
	}
}

// MARK: - OnNetwork.ConnectedDapp.AuthorizedPersonaSimple
public extension OnNetwork.ConnectedDapp {
	struct AuthorizedPersonaSimple:
		Sendable,
		Hashable,
		Identifiable,
		Codable
	{
		public typealias ID = IdentityAddress
		/// The globally unique identifier of a Persona is its address, used
		/// to lookup persona
		public let identityAddress: IdentityAddress

		/// List of "ongoing personaData" (identified by OnNetwork.Persona.Field.ID) that user has given the Dapp access to.
		/// mutable so that we can mutate the fields
		public var fieldIDs: OrderedSet<OnNetwork.Persona.Field.ID>

		/// List of "ongoing accountAddresses" that user given the dApp access to.
		public var sharedAccounts: SharedAccounts

		public struct SharedAccounts:
			Sendable,
			Hashable,
			Codable
		{
			public struct NumberOfAccounts: Sendable, Hashable, Codable {
				public enum Quantifier: String, Sendable, Hashable, Codable {
					case exactly
					case atLeast
				}

				public let quantifier: Quantifier
				public let quantity: Int

				public static func exactly(_ quantity: Int) -> Self {
					.init(quantifier: .exactly, quantity: quantity)
				}

				public static func atLeast(_ quantity: Int) -> Self {
					.init(quantifier: .atLeast, quantity: quantity)
				}
			}

			public let request: NumberOfAccounts
			public private(set) var accountsReferencedByAddress: OrderedSet<AccountAddress>

			public init(
				accountsReferencedByAddress: OrderedSet<AccountAddress>,
				forRequest request: NumberOfAccounts
			) throws {
				try Self.validate(accountsReferencedByAddress: accountsReferencedByAddress, forRequest: request)
				self.request = request
				self.accountsReferencedByAddress = accountsReferencedByAddress
			}
		}

		public init(
			identityAddress: IdentityAddress,
			fieldIDs: OrderedSet<OnNetwork.Persona.Field.ID>,
			sharedAccounts: SharedAccounts
		) {
			self.identityAddress = identityAddress
			self.fieldIDs = fieldIDs
			self.sharedAccounts = sharedAccounts
		}
	}
}

public extension OnNetwork.ConnectedDapp.AuthorizedPersonaSimple.SharedAccounts {
	static func validate(
		accountsReferencedByAddress: OrderedSet<AccountAddress>,
		forRequest request: NumberOfAccounts
	) throws {
		switch request.quantifier {
		case .atLeast:
			guard accountsReferencedByAddress.count >= request.quantity else {
				struct NotEnoughAccountsProvided: Swift.Error {}
				throw NotEnoughAccountsProvided()
			}
		// all good
		case .exactly:
			guard accountsReferencedByAddress.count == request.quantity else {
				struct InvalidNumberOfAccounts: Swift.Error {}
				throw InvalidNumberOfAccounts()
			}
			// all good
		}
	}

	mutating func updateAccounts(_ new: OrderedSet<AccountAddress>) throws {
		try Self.validate(accountsReferencedByAddress: new, forRequest: self.request)
		self.accountsReferencedByAddress = new
	}
}

public extension OnNetwork.ConnectedDapp.AuthorizedPersonaSimple {
	var id: ID {
		identityAddress
	}
}

public extension OnNetwork.ConnectedDapp {
	var id: DappDefinitionAddress {
		dAppDefinitionAddress
	}
}

public extension OnNetwork.ConnectedDapp {
	var customDumpMirror: Mirror {
		.init(
			self,
			children: [
				"dAppDefinitionAddress": dAppDefinitionAddress,
				"displayName": String(describing: displayName),
			],
			displayStyle: .struct
		)
	}

	var description: String {
		"""
		dAppDefinitionAddress: \(dAppDefinitionAddress),
		displayName: \(String(describing: displayName)),
		"""
	}
}
