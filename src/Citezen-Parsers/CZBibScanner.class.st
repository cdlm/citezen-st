Class {
	#name : #CZBibScanner,
	#superclass : #CZDelimitedStringScanner,
	#category : 'Citezen-Parsers'
}

{ #category : #generated }
CZBibScanner >> bracedStringId [
	^ 12
]

{ #category : #generated }
CZBibScanner >> emptySymbolTokenId [
	^ 28
]

{ #category : #generated }
CZBibScanner >> errorTokenId [
	^ 29
]

{ #category : #generated }
CZBibScanner >> parenthesizedStringId [
	^ 13
]

{ #category : #generated }
CZBibScanner >> scan1 [
	(self scanForString: 'mment')
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZBibScanner >> scan2 [
	(self scanForString: 'ring')
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZBibScanner >> scanForToken [
	self recordMatch: #(5).
	self step.
	currentCharacter == $"
		ifTrue: [ [ self step.
			currentCharacter == $"
				ifTrue: [ ^ self recordAndReportMatch: #(9) ].
			true ] whileTrue ].
	currentCharacter == $#
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter == $%
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $@
		ifTrue:
			[ ^ self scanForTokenX2 ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	^ self scanForTokenX6
]

{ #category : #generated }
CZBibScanner >> scanForTokenX1 [
	[ self recordMatch: #(7 8).
	self step.
	currentCharacter between: $0 and: $9 ] whileTrue.
	(('!$&' includes: currentCharacter)
		or: [ (currentCharacter between: $* and: $+)
				or: [ (currentCharacter between: $- and: $/)
						or: [ (currentCharacter between: $: and: $<)
								or: [ (currentCharacter between: $> and: $?)
										or: [ (currentCharacter between: $A and: $[)
												or: [ (currentCharacter between: $] and: $z)
														or: [ currentCharacter == $| ] ] ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			('!$&' includes: currentCharacter)
				or: [ (currentCharacter between: $* and: $+)
						or: [ (currentCharacter between: $- and: $<)
								or: [ (currentCharacter between: $> and: $?)
										or: [ (currentCharacter between: $A and: $[)
												or: [ (currentCharacter between: $] and: $z)
														or: [ currentCharacter == $| ] ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
CZBibScanner >> scanForTokenX2 [
	self recordMatch: #(1).
	self step.
	currentCharacter == $C
		ifTrue: [ self step.
			currentCharacter == $O
				ifTrue: [ (self scanForString: 'MMENT')
						ifTrue: [ ^ self recordAndReportMatch: #(11) ].
					^ self reportLastMatch ].
			currentCharacter == $o
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	currentCharacter == $S
		ifTrue: [ self step.
			currentCharacter == $T
				ifTrue: [ (self scanForString: 'RING')
						ifTrue: [ ^ self recordAndReportMatch: #(10) ].
					^ self reportLastMatch ].
			currentCharacter == $t
				ifTrue: [ ^ self scan2 ].
			^ self reportLastMatch ].
	currentCharacter == $c
		ifTrue: [ self step.
			currentCharacter == $o
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	currentCharacter == $s
		ifTrue: [ self step.
			currentCharacter == $t
				ifTrue: [ ^ self scan2 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
CZBibScanner >> scanForTokenX3 [
	[ self recordMatch: #(8).
	self step.
	('!$&' includes: currentCharacter)
		or: [ (currentCharacter between: $* and: $+)
				or: [ (currentCharacter between: $- and: $<)
						or: [ (currentCharacter between: $> and: $?)
								or: [ (currentCharacter between: $A and: $[)
										or: [ (currentCharacter between: $] and: $z)
												or: [ currentCharacter == $| ] ] ] ] ] ] ] whileTrue
]

{ #category : #generated }
CZBibScanner >> scanForTokenX4 [
	[ self recordMatch: #(6).
	self step.
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
CZBibScanner >> scanForTokenX5 [
	[ self recordMatch: #(5).
	self step.
	(currentCharacter between: Character tab and: Character lf)
		or: [ currentCharacter == Character cr
				or: [ currentCharacter == Character space ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
CZBibScanner >> scanForTokenX6 [
	(currentCharacter between: $0 and: $9)
		ifTrue:
			[ ^ self scanForTokenX1 ].
	((currentCharacter between: Character tab and: Character lf)
		or: [ currentCharacter == Character cr
				or: [ currentCharacter == Character space ] ])
		ifTrue:
			[ ^ self scanForTokenX5 ].
	(('!$&' includes: currentCharacter)
		or: [ (currentCharacter between: $* and: $+)
				or: [ (currentCharacter between: $- and: $/)
						or: [ (currentCharacter between: $: and: $<)
								or: [ (currentCharacter between: $> and: $?)
										or: [ (currentCharacter between: $A and: $[)
												or: [ (currentCharacter between: $] and: $z)
														or: [ currentCharacter == $| ] ] ] ] ] ] ])
		ifTrue:
			[ self scanForTokenX3 ].
	^ self reportLastMatch
]

{ #category : #generated }
CZBibScanner >> tokenActions [
	^ #(nil nil nil nil #whitespace #comment nil nil nil nil nil #bracedString #parenthesizedString)
]
