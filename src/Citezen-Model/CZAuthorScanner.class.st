Class {
	#name : #CZAuthorScanner,
	#superclass : #SmaCCScanner,
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-initialization' }
CZAuthorScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'and' 3 ) ) do: 
				[:each | 
				(keywordMap at: each first ifAbsentPut: [Dictionary new]) at: (each at: 2)
					put: each last].
	^ keywordMap
]

{ #category : #'generated-comments' }
CZAuthorScanner class >> scannerDefinitionComment [

	"<whitespace>	:	[\s]*	;
<and>			:	a n d	;
<name>		:	[^\s,]+	;
	#[a-zA-Z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+ ;
"
]

{ #category : #'generated-tokens' }
CZAuthorScanner >> emptySymbolTokenId [
	^12
]

{ #category : #'generated-tokens' }
CZAuthorScanner >> errorTokenId [
	^13
]

{ #category : #'generated-scanner' }
CZAuthorScanner >> scanForToken [
	self recordMatch: #whitespace.
	self step.
	(currentCharacter <= Character backspace or: 
			[(currentCharacter between: (Character value: 14) and: (Character value: 31)) 
				or: [(currentCharacter between: $! and: $+) or: [currentCharacter >= $-]]]) 
		ifTrue: 
			[
			[self recordMatch: #(4 ).
			self step.
			currentCharacter <= Character backspace or: 
					[(currentCharacter between: (Character value: 14) and: (Character value: 31)) 
						or: [(currentCharacter between: $! and: $+) or: [currentCharacter >= $-]]]] 
					whileTrue.
			^ self reportLastMatch].
	(currentCharacter isSeparator 
		or: [currentCharacter == (Character value: 11)]) 
			ifTrue: 
				[
				[self recordMatch: #whitespace.
				self step.
				currentCharacter isSeparator 
					or: [currentCharacter == (Character value: 11)]] 
						whileTrue.
				^ self reportLastMatch].
	currentCharacter == $, ifTrue: [^ self recordAndReportMatch: #(1 )].
	^ self reportLastMatch
]
