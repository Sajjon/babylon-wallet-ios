import Prelude

private extension BIP39 {
	static var cachedWordLists: [Language: WordList] = [:]

	static func words(for language: Language) -> [String] {
		switch language {
		case .english:
			return WordList.english
		case .japanese:
			return WordList.japanese
		case .korean:
			return WordList.korean
		case .spanish:
			return WordList.spanish
		case .chineseSimplified:
			return WordList.chineseSimplified
		case .chineseTraditional:
			return WordList.chineseTraditional
		case .french:
			return WordList.french
		case .italian:
			return WordList.italian
		}
	}

	static func makeWordList(for language: Language) -> WordList {
		let words = Self.words(for: language)
		return try! WordList(words: words, language: language)
	}
}

public extension BIP39 {
	static func wordList(for language: Language) -> WordList {
		if let list = cachedWordLists[language] {
			return list
		}
		let newList = makeWordList(for: language)
		cachedWordLists[language] = newList
		return newList
	}
}