Class {
	#name : #BibAuthorScanner,
	#superclass : #SmaCCScanner,
	#category : #'Citezen-Parsers'
}

{ #category : #'generated-initialization' }
BibAuthorScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'and' 3 ) ) do: 
				[:each | 
				(keywordMap at: each first ifAbsentPut: [Dictionary new]) at: (each at: 2)
					put: each last].
	^ keywordMap
]

{ #category : #'generated-comments' }
BibAuthorScanner class >> scannerDefinitionComment [

	"<whitespace>	:	[\s]*	;
<and>			:	a n d	;
<name>		:	[^\s,]+	;
	#[a-zA-Z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+ ;
"
]

{ #category : #'generated-tokens' }
BibAuthorScanner >> emptySymbolTokenId [
	^12
]

{ #category : #'generated-tokens' }
BibAuthorScanner >> errorTokenId [
	^13
]

{ #category : #'generated-scanner' }
BibAuthorScanner >> scanForToken [
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
