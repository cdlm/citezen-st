Class {
	#name : #CZAuxScanner,
	#superclass : #CZDelimitedStringScanner,
	#category : 'Citezen-Parsers'
}

{ #category : #scanning }
CZAuxScanner >> any [
	| tokenId |
	self halt.
	outputStream contents = '\' ifTrue: [
		#('citation' 'bibcite' 'bibstyle' 'bibdata') do: [:keyword |
			(stream peekForAll: keyword)
				ifTrue: [
					tokenId := self perform: keyword , 'Id'.
					matchActions := Array with: tokenId.
					self createTokenFor: '\' , keyword.
					^ self]]].
	matchActions := Array with: self anyId.
	self createTokenFor: outputStream contents
]

{ #category : #generated }
CZAuxScanner >> anyId [
	^ 13
]

{ #category : #generated }
CZAuxScanner >> bibciteId [
	^ 7
]

{ #category : #generated }
CZAuxScanner >> bibdataId [
	^ 9
]

{ #category : #generated }
CZAuxScanner >> bibstyleId [
	^ 8
]

{ #category : #generated }
CZAuxScanner >> bracedStringId [
	^ 10
]

{ #category : #generated }
CZAuxScanner >> citationId [
	^ 6
]

{ #category : #generated }
CZAuxScanner >> emptySymbolTokenId [
	^ 23
]

{ #category : #generated }
CZAuxScanner >> errorTokenId [
	^ 24
]

{ #category : #generated }
CZAuxScanner >> scanForToken [
	self step.
	currentCharacter == Character lf
		ifTrue: [ ^ self recordAndReportMatch: #(4 11) ].
	currentCharacter == Character cr
		ifTrue: [ ^ self scanForTokenX3 ].
	^ self scanForTokenX4
]

{ #category : #generated }
CZAuxScanner >> scanForTokenX1 [
	self recordMatch: #(5 11).
	self step.
	(('!$&' includes: currentCharacter)
		or: [ (currentCharacter between: $* and: $+)
				or: [ (currentCharacter between: $- and: $<)
						or: [ (currentCharacter between: $> and: $?)
								or: [ (currentCharacter between: $A and: $[)
										or: [ (currentCharacter between: $] and: $z)
												or: [ currentCharacter == $| ] ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(5).
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
CZAuxScanner >> scanForTokenX2 [
	self recordMatch: #(11).
	self step.
	currentCharacter == $b
		ifTrue: [ (self scanForString: 'ib')
				ifTrue: [ self step.
					currentCharacter == $c
						ifTrue: [ (self scanForString: 'ite')
								ifTrue: [ ^ self recordAndReportMatch: #(7) ].
							^ self reportLastMatch ].
					currentCharacter == $d
						ifTrue: [ (self scanForString: 'ata')
								ifTrue: [ ^ self recordAndReportMatch: #(9) ].
							^ self reportLastMatch ].
					currentCharacter == $s
						ifTrue: [ (self scanForString: 'tyle')
								ifTrue: [ ^ self recordAndReportMatch: #(8) ] ] ].
			^ self reportLastMatch ].
	currentCharacter == $c
		ifTrue: [ (self scanForString: 'itation')
				ifTrue: [ ^ self recordAndReportMatch: #(6) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAuxScanner >> scanForTokenX3 [
	self recordMatch: #(4 11).
	self step.
	currentCharacter == Character lf
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	^ self reportLastMatch
]

{ #category : #generated }
CZAuxScanner >> scanForTokenX4 [
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(3 11) ].
	currentCharacter == $\
		ifTrue: [ ^ self scanForTokenX2 ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(1 10 11) ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(2 11) ].
	(('!$&' includes: currentCharacter)
		or: [ (currentCharacter between: $* and: $+)
				or: [ (currentCharacter between: $- and: $<)
						or: [ (currentCharacter between: $> and: $?)
								or: [ (currentCharacter between: $A and: $[)
										or: [ (currentCharacter between: $] and: $z)
												or: [ currentCharacter == $| ] ] ] ] ] ])
		ifTrue: [ ^ self scanForTokenX1 ].
	^ self recordAndReportMatch: #(11)
]

{ #category : #generated }
CZAuxScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil #bracedString nil nil #any)
]
