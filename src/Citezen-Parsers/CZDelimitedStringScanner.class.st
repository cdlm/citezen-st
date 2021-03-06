Class {
	#name : #CZDelimitedStringScanner,
	#superclass : #SmaCCScanner,
	#category : 'Citezen-Parsers'
}

{ #category : #scanning }
CZDelimitedStringScanner >> bracedString [
	self delimitedTokenId: self bracedStringId from: ${ to: $}
]

{ #category : #scanning }
CZDelimitedStringScanner >> delimitedTokenId: tokenId from: startChar to: stopChar [ 
	"Scans stuff between delimiters, taking care of nested delimiters."

	| token |
	self scanUpTo: stopChar ignore: startChar.
	token := SmaCCToken 
				value: outputStream contents
				start: start
				id: (Array with: tokenId).
	matchActions := nil.
	returnMatchBlock value: token
]

{ #category : #scanning }
CZDelimitedStringScanner >> parenthesizedString [
	self delimitedTokenId: self parenthesizedStringId from: $( to: $)
]

{ #category : #scanning }
CZDelimitedStringScanner >> scanUpTo: stopChar ignore: startChar [ 
	| level |
	level := 0.
	self step.
	[currentCharacter = stopChar
		and: [level = 0]]
		whileFalse: [currentCharacter = startChar
				ifTrue: [level := level + 1].
			currentCharacter = stopChar
				ifTrue: [level := level - 1].
			self atEnd
				ifTrue: [SmaCCParserError signal: 'Unmatched '
							, (String with: startChar)]
				ifFalse: [self step]]
]
