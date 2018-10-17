Class {
	#name : #CZAccentuateCharactersScanner,
	#superclass : #SmaCCScanner,
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-initialization' }
CZAccentuateCharactersScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(6 '\#' 39) #(6 '\%' 38) #(6 '\&' 37) #(6 '\-' 36) #(6 '\L' 32) #(6 '\O' 30) #(6 '\\' 5) #(6 '\i' 33) #(6 '\j' 34) #(6 '\l' 31) #(6 '\v' 17))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
CZAccentuateCharactersScanner >> emptySymbolTokenId [
	^ 57
]

{ #category : #generated }
CZAccentuateCharactersScanner >> errorTokenId [
	^ 58
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $'
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == $/
		ifTrue:
			[ ^ self scan1X11 ].
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter == $A
		ifTrue:
			[ ^ self scan1X10 ].
	currentCharacter == $H
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	^ self scan1X13
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X1 [
	self recordMatch: #(6).
	self step.
	currentCharacter == Character space
		ifTrue: [ self step.
			currentCharacter == $c
				ifTrue: [ ^ self recordAndReportMatch: #(20) ].
			currentCharacter == $s
				ifTrue: [ ^ self recordAndReportMatch: #(21) ].
			currentCharacter == $t
				ifTrue: [ ^ self recordAndReportMatch: #(22) ].
			^ self reportLastMatch ].
	currentCharacter == ${
		ifTrue: [ self step.
			currentCharacter == $c
				ifTrue: [ self step.
					currentCharacter == $}
						ifTrue: [ ^ self recordAndReportMatch: #(20) ].
					^ self reportLastMatch ].
			currentCharacter == $s
				ifTrue: [ self step.
					currentCharacter == $}
						ifTrue: [ ^ self recordAndReportMatch: #(21) ].
					^ self reportLastMatch ].
			currentCharacter == $t
				ifTrue: [ self step.
					currentCharacter == $}
						ifTrue: [ ^ self recordAndReportMatch: #(22) ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X10 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $A
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X11 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $o
		ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X12 [
	currentCharacter == $~
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	(currentCharacter isSafeForHTTP
		or: [ currentCharacter isSpecial
				or: [ currentCharacter isSeparator
						or: [ currentCharacter isArrow
								or: [ currentCharacter <= Character backspace
										or: [ (currentCharacter
												between: (Character value: 14)
												and: Character escape)
												or: [ (currentCharacter between: $# and: $$)
														or: [ (currentCharacter between: $( and: $))
																or: [ (currentCharacter between: $: and: $;)
																		or: [ ('[]{}' includes: currentCharacter)
																				or: [ currentCharacter >= (Character value: 127) ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X13 [
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter == $`
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter == $a
		ifTrue:
			[ ^ self scan1X5 ].
	currentCharacter == $b
		ifTrue:
			[ ^ self scan1X9 ].
	currentCharacter == $c
		ifTrue:
			[ ^ self scan1X1 ].
	currentCharacter == $n
		ifTrue:
			[ ^ self scan1X3 ].
	currentCharacter == $o
		ifTrue:
			[ ^ self scan1X2 ].
	currentCharacter == $p
		ifTrue:
			[ ^ self scan1X8 ].
	currentCharacter == $s
		ifTrue:
			[ ^ self scan1X7 ].
	currentCharacter == $t
		ifTrue:
			[ ^ self scan1X6 ].
	currentCharacter == $u
		ifTrue: [ ^ self recordAndReportMatch: #(18) ].
	currentCharacter == $w
		ifTrue:
			[ ^ self scan1X4 ].
	^ self scan1X12
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X2 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $a
		ifTrue: [ ^ self recordAndReportMatch: #(40) ].
	currentCharacter == $e
		ifTrue: [ ^ self recordAndReportMatch: #(24) ].
	currentCharacter == $m
		ifTrue: [ (self scanForString: 'ega')
				ifTrue: [ ^ self recordAndReportMatch: #(44) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X3 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $e
		ifTrue: [ self step.
			currentCharacter == $q
				ifTrue: [ ^ self recordAndReportMatch: #(45) ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ ^ self recordAndReportMatch: #(41) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X4 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $e
		ifTrue: [ (self scanForString: 'dge')
				ifTrue: [ ^ self recordAndReportMatch: #(46) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X5 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $a
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $e
		ifTrue: [ ^ self recordAndReportMatch: #(25) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X6 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $a
		ifTrue: [ self step.
			currentCharacter == $u
				ifTrue: [ ^ self recordAndReportMatch: #(43) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X7 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $s
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X8 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $i
		ifTrue: [ ^ self recordAndReportMatch: #(42) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scan1X9 [
	self recordMatch: #(6).
	self step.
	currentCharacter == Character space
		ifTrue: [ ^ self recordAndReportMatch: #(47) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAccentuateCharactersScanner >> scanForToken [
	self step.
	currentCharacter == $$
		ifTrue: [ ^ self recordAndReportMatch: #(4 7) ].
	currentCharacter == $-
		ifTrue: [ self recordMatch: #(4).
			self step.
			currentCharacter == $-
				ifTrue: [ self recordMatch: #(8).
					self step.
					currentCharacter == $-
						ifTrue: [ ^ self recordAndReportMatch: #(9) ] ].
			^ self reportLastMatch ].
	currentCharacter == $?
		ifTrue: [ self recordMatch: #(4).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self recordAndReportMatch: #(23) ].
			^ self reportLastMatch ].
	currentCharacter == $\
		ifTrue: [ ^ self scan1 ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(2 4) ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter == $~
		ifTrue: [ ^ self recordAndReportMatch: #(35) ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter between: $a and: $z ])
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	^ self recordAndReportMatch: #(4)
]
