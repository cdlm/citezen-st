Class {
	#name : #CZAuthorScanner,
	#superclass : #SmaCCScanner,
	#category : #'Citezen-Parsers'
}

{ #category : #'generated-initialization' }
CZAuthorScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'and' 3))
		do: [ :each | (keywordMap at: each first ifAbsentPut: [ Dictionary new ]) at: (each at: 2) put: each last ].
	^ keywordMap
]

{ #category : #'generated-comments' }
CZAuthorScanner class >> scannerDefinitionComment [

	"<whitespace>	:	[\s]*	;
<and>			:	a n d	;
<lump>			:	\{ [^}]* \}	;
<name>		:	(<lump> | [^\s,])+	;
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
CZAuthorScanner >> scan1 [
	[ 
	self recordMatch: #(4).
	self step.
	currentCharacter <= Character backspace
		or: [ 
			(currentCharacter between: (Character value: 14) and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $+) or: [ (currentCharacter between: $- and: $z) or: [ currentCharacter >= $| ] ] ] ] ]
		whileTrue.
	currentCharacter = ${
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
CZAuthorScanner >> scan2 [
	[ 
	self recordMatch: #(4).
	self step.
	currentCharacter <= Character backspace
		or: [ 
			(currentCharacter between: (Character value: 14) and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $+) or: [ (currentCharacter between: $- and: $|) or: [ currentCharacter >= $~ ] ] ] ] ]
		whileTrue.
	((currentCharacter between: Character tab and: Character cr)
		or: [ currentCharacter = Character space or: [ currentCharacter = $, ] ])
		ifTrue: [ 
			[ 
			self step.
			currentCharacter ~= $} ] whileTrue.
			currentCharacter = $}
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	currentCharacter = $}
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
CZAuthorScanner >> scanForToken [
	self recordMatch: #whitespace.
	self step.
	(currentCharacter <= Character backspace
		or: [ 
			(currentCharacter between: (Character value: 14) and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $+) or: [ (currentCharacter between: $- and: $z) or: [ currentCharacter >= $| ] ] ] ])
		ifTrue: [ ^ self scan1 ].
	((currentCharacter between: Character tab and: Character cr) or: [ currentCharacter = Character space ])
		ifTrue: [ 
			[ 
			self recordMatch: #whitespace.
			self step.
			(currentCharacter between: Character tab and: Character cr) or: [ currentCharacter = Character space ] ] whileTrue.
			^ self reportLastMatch ].
	currentCharacter = $,
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter = ${
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]
