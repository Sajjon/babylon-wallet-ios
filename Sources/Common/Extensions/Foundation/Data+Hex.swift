import Foundation
import Mnemonic

public extension FixedWidthInteger {
	var data: Data {
		let data = withUnsafeBytes(of: bigEndian) { Data($0) }
		return data
	}
}
