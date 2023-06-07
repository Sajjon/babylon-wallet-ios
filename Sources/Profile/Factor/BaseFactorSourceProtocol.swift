import Foundation

// MARK: - BaseFactorSourceProtocol
public protocol BaseFactorSourceProtocol {
	var kind: FactorSourceKind { get }
	var common: FactorSource.Common { get set }
}

extension BaseFactorSourceProtocol {
	public typealias ID = FactorSourceID
	public var id: FactorSourceID {
		common.id
	}

	public var cryptoParameters: FactorSource.CryptoParameters {
		common.cryptoParameters
	}

	public var addedOn: Date {
		common.addedOn
	}

	public var lastUsedOn: Date {
		common.lastUsedOn
	}

	public var supportsOlympia: Bool {
		cryptoParameters.supportsOlympia
	}
}