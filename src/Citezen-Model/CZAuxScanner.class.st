Class {
	#name : #CZAuxScanner,
	#superclass : #CZDelimitedStringScanner,
	#category : #'Citezen-Parsers'
}

{ #category : #'generated-comments' }
CZAuxScanner class >> scannerDefinitionComment [

	"<newline>		:	\r \n | \n | \r	;
<name>			:	[A-Za-z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+	;

<citation>		:	\\ citation	;
<bibcite>			:	\\ bibcite	;
<bibstyle>		:	\\ bibstyle	;
<bibdata>		:	\\ bibdata	;

# tokens parsed by code
<bracedString>	:	\{	;
<junk>			:	.	;"
]

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

{ #category : #'generated-tokens' }
CZAuxScanner >> anyId [
	^13
]

{ #category : #'generated-tokens' }
CZAuxScanner >> bibciteId [
	^7
]

{ #category : #'generated-tokens' }
CZAuxScanner >> bibdataId [
	^9
]

{ #category : #'generated-tokens' }
CZAuxScanner >> bibstyleId [
	^8
]

{ #category : #'generated-tokens' }
CZAuxScanner >> bracedStringId [
	^10
]

{ #category : #'generated-tokens' }
CZAuxScanner >> citationId [
	^6
]

{ #category : #'generated-tokens' }
CZAuxScanner >> emptySymbolTokenId [
	^23
]

{ #category : #'generated-tokens' }
CZAuxScanner >> errorTokenId [
	^24
]

{ #category : #'generated-scanner' }
CZAuxScanner >> scan1 [
	self recordMatch: #(11 ).
	self step.
	currentCharacter = $b 
		ifTrue: 
			[self step.
			currentCharacter = $i 
				ifTrue: 
					[self step.
					currentCharacter = $b 
						ifTrue: 
							[self step.
							currentCharacter = $c 
								ifTrue: 
									[self step.
									currentCharacter = $i 
										ifTrue: 
											[self step.
											currentCharacter = $t 
												ifTrue: 
													[self step.
													currentCharacter = $e ifTrue: [^ self recordAndReportMatch: #(7 )].
													^ self reportLastMatch].
											^ self reportLastMatch].
									^ self reportLastMatch].
							currentCharacter = $d 
								ifTrue: 
									[self step.
									currentCharacter = $a 
										ifTrue: 
											[self step.
											currentCharacter = $t 
												ifTrue: 
													[self step.
													currentCharacter = $a ifTrue: [^ self recordAndReportMatch: #(9 )].
													^ self reportLastMatch].
											^ self reportLastMatch].
									^ self reportLastMatch].
							currentCharacter = $s 
								ifTrue: 
									[self step.
									currentCharacter = $t 
										ifTrue: 
											[self step.
											currentCharacter = $y 
												ifTrue: 
													[self step.
													currentCharacter = $l 
														ifTrue: 
															[self step.
															currentCharacter = $e ifTrue: [^ self recordAndReportMatch: #(8 )].
															^ self reportLastMatch].
													^ self reportLastMatch].
											^ self reportLastMatch].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			^ self reportLastMatch].
	currentCharacter = $c 
		ifTrue: 
			[self step.
			currentCharacter = $i 
				ifTrue: 
					[self step.
					currentCharacter = $t 
						ifTrue: 
							[self step.
							currentCharacter = $a 
								ifTrue: 
									[self step.
									currentCharacter = $t 
										ifTrue: 
											[self step.
											currentCharacter = $i 
												ifTrue: 
													[self step.
													currentCharacter = $o 
														ifTrue: 
															[self step.
															currentCharacter = $n ifTrue: [^ self recordAndReportMatch: #(6 )].
															^ self reportLastMatch].
													^ self reportLastMatch].
											^ self reportLastMatch].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			^ self reportLastMatch].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
CZAuxScanner >> scanForToken [
	self step.
	(currentCharacter <= Character tab or: 
			[(currentCharacter between: (Character value: 11) and: Character newPage) 
				or: 
					[(currentCharacter between: (Character value: 14) and: Character space) 
						or: 
							[(currentCharacter between: $" and: $#) or: 
									[currentCharacter = $% or: 
											[(currentCharacter between: $' and: $)) or: 
													[currentCharacter = $= 
														or: [currentCharacter = $@ or: [currentCharacter >= $~]]]]]]]]) 
		ifTrue: [^ self recordAndReportMatch: #(11 )].
	(currentCharacter = $! or: 
			[currentCharacter = $$ or: 
					[currentCharacter = $& or: 
							[(currentCharacter between: $* and: $+) or: 
									[(currentCharacter between: $- and: $<) or: 
											[(currentCharacter between: $> and: $?) or: 
													[(currentCharacter between: $A and: $[) 
														or: [(currentCharacter between: $] and: $z) or: [currentCharacter = $|]]]]]]]]) 
		ifTrue: 
			[self recordMatch: #(5 11 ).
			self step.
			(currentCharacter = $! or: 
					[currentCharacter = $$ or: 
							[currentCharacter = $& or: 
									[(currentCharacter between: $* and: $+) or: 
											[(currentCharacter between: $- and: $<) or: 
													[(currentCharacter between: $> and: $?) or: 
															[(currentCharacter between: $A and: $[) 
																or: [(currentCharacter between: $] and: $z) or: [currentCharacter = $|]]]]]]]]) 
				ifTrue: 
					[
					[self recordMatch: #(5 ).
					self step.
					currentCharacter = $! or: 
							[currentCharacter = $$ or: 
									[currentCharacter = $& or: 
											[(currentCharacter between: $* and: $+) or: 
													[(currentCharacter between: $- and: $<) or: 
															[(currentCharacter between: $> and: $?) or: 
																	[(currentCharacter between: $A and: $[) 
																		or: [(currentCharacter between: $] and: $z) or: [currentCharacter = $|]]]]]]]]] 
							whileTrue.
					^ self reportLastMatch].
			^ self reportLastMatch].
	currentCharacter = Character lf 
		ifTrue: [^ self recordAndReportMatch: #(4 11 )].
	currentCharacter = Character cr 
		ifTrue: 
			[self recordMatch: #(4 11 ).
			self step.
			currentCharacter = Character lf 
				ifTrue: [^ self recordAndReportMatch: #(4 )].
			^ self reportLastMatch].
	currentCharacter = $, ifTrue: [^ self recordAndReportMatch: #(3 11 )].
	currentCharacter = $\ ifTrue: [^ self scan1].
	currentCharacter = ${ ifTrue: [^ self recordAndReportMatch: #(1 10 11 )].
	currentCharacter = $} ifTrue: [^ self recordAndReportMatch: #(2 11 )].
	^ self reportLastMatch
]
