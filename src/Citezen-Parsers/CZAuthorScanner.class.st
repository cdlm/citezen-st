Class {
	#name : #CZAuthorScanner,
	#superclass : #SmaCCScanner,
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-initialization' }
CZAuthorScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'and' 3))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
CZAuthorScanner >> emptySymbolTokenId [
	^ 14
]

{ #category : #generated }
CZAuthorScanner >> errorTokenId [
	^ 15
]

{ #category : #generated }
CZAuthorScanner >> scan1 [
	[ self recordMatch: #(4).
	self step.
	currentCharacter == ${
		ifTrue: [ ^ self scan2 ].
	currentCharacter <= Character backspace
		or: [ (currentCharacter
				between: (Character value: 14)
				and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $+)
						or: [ (currentCharacter between: $- and: $z)
								or: [ currentCharacter >= $| ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
CZAuthorScanner >> scan2 [
	[ self recordMatch: #(4).
	self step.
	currentCharacter == $}
		ifTrue: [ ^ self scan1 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp or: [ currentCharacter == $, ] ])
		ifTrue: [ [ self step.
			currentCharacter == $}
				ifTrue: [ ^ self scan1 ].
			true ] whileTrue ].
	true ] whileTrue
]

{ #category : #generated }
CZAuthorScanner >> scanForToken [
	self recordMatch: #(2).
	self step.
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == ${
		ifTrue: [ ^ self scan2 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(2).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ] ] whileTrue.
			^ self reportLastMatch ].
	^ self scan1
]

{ #category : #generated }
CZAuthorScanner >> tokenActions [
	^ #(nil #whitespace)
]
