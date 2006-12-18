Class {
	#name : #BibScanner,
	#superclass : #SmaCCScanner,
	#category : #Citezen
}

{ #category : #'generated-comments' }
BibScanner class >> scannerDefinitionComment [

	"<whitespace>	:	[\s]*	;
<comment>	:	\% [^\r\n]*	;
<name>		:	[A-Za-z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+	;
<quotedString>	:	\"" [^\""]* \""	;

<stringTag>	:	\@ ( string | String | STRING )	;
<commentTag>	:	\@ ( comment | Comment | COMMENT )	;

# tokens parsed by code
<bracedString>	:	\{	;
<parenthesizedString>	:	\(	;
"
]

{ #category : #scanning }
BibScanner >> bracedString [
	self delimitedTokenId: self bracedStringId from: ${ to: $}

]

{ #category : #'generated-tokens' }
BibScanner >> bracedStringId [
	^11
]

{ #category : #scanning }
BibScanner >> delimitedTokenId: tokenId from: startChar to: stopChar [ 
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

{ #category : #'generated-tokens' }
BibScanner >> emptySymbolTokenId [
	^27
]

{ #category : #'generated-tokens' }
BibScanner >> errorTokenId [
	^28
]

{ #category : #scanning }
BibScanner >> parenthesizedString [
	self delimitedTokenId: self parenthesizedStringId from: $( to: $)

]

{ #category : #'generated-tokens' }
BibScanner >> parenthesizedStringId [
	^12
]

{ #category : #'generated-scanner' }
BibScanner >> scan1 [
	self step.
	currentCharacter == $r 
		ifTrue: 
			[self step.
			currentCharacter == $i 
				ifTrue: 
					[self step.
					currentCharacter == $n 
						ifTrue: 
							[self step.
							currentCharacter == $g ifTrue: [^ self recordAndReportMatch: #(9 )].
							^ self reportLastMatch].
					^ self reportLastMatch].
			^ self reportLastMatch].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
BibScanner >> scan2 [
	self step.
	currentCharacter == $m 
		ifTrue: 
			[self step.
			currentCharacter == $m 
				ifTrue: 
					[self step.
					currentCharacter == $e 
						ifTrue: 
							[self step.
							currentCharacter == $n 
								ifTrue: 
									[self step.
									currentCharacter == $t ifTrue: [^ self recordAndReportMatch: #(10 )].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			^ self reportLastMatch].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
BibScanner >> scan3 [
	self recordMatch: #(1 ).
	self step.
	currentCharacter == $C 
		ifTrue: 
			[self step.
			currentCharacter == $O 
				ifTrue: 
					[self step.
					currentCharacter == $M 
						ifTrue: 
							[self step.
							currentCharacter == $M 
								ifTrue: 
									[self step.
									currentCharacter == $E 
										ifTrue: 
											[self step.
											currentCharacter == $N 
												ifTrue: 
													[self step.
													currentCharacter == $T ifTrue: [^ self recordAndReportMatch: #(10 )].
													^ self reportLastMatch].
											^ self reportLastMatch].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			currentCharacter == $o ifTrue: [^ self scan2].
			^ self reportLastMatch].
	currentCharacter == $S 
		ifTrue: 
			[self step.
			currentCharacter == $T 
				ifTrue: 
					[self step.
					currentCharacter == $R 
						ifTrue: 
							[self step.
							currentCharacter == $I 
								ifTrue: 
									[self step.
									currentCharacter == $N 
										ifTrue: 
											[self step.
											currentCharacter == $G ifTrue: [^ self recordAndReportMatch: #(9 )].
											^ self reportLastMatch].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			currentCharacter == $t ifTrue: [^ self scan1].
			^ self reportLastMatch].
	currentCharacter == $c 
		ifTrue: 
			[self step.
			currentCharacter == $o ifTrue: [^ self scan2].
			^ self reportLastMatch].
	currentCharacter == $s 
		ifTrue: 
			[self step.
			currentCharacter == $t ifTrue: [^ self scan1].
			^ self reportLastMatch].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
BibScanner >> scanForToken [
	self recordMatch: #whitespace.
	self step.
	(currentCharacter == $! or: 
			[currentCharacter == $$ or: 
					[currentCharacter == $& or: 
							[(currentCharacter between: $* and: $+) or: 
									[(currentCharacter between: $- and: $<) or: 
											[(currentCharacter between: $> and: $?) or: 
													[(currentCharacter between: $A and: $[) 
														or: [(currentCharacter between: $] and: $z) or: [currentCharacter == $|]]]]]]]]) 
		ifTrue: 
			[
			[self recordMatch: #(7 ).
			self step.
			currentCharacter == $! or: 
					[currentCharacter == $$ or: 
							[currentCharacter == $& or: 
									[(currentCharacter between: $* and: $+) or: 
											[(currentCharacter between: $- and: $<) or: 
													[(currentCharacter between: $> and: $?) or: 
															[(currentCharacter between: $A and: $[) 
																or: [(currentCharacter between: $] and: $z) or: [currentCharacter == $|]]]]]]]]] 
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
	currentCharacter == $" 
		ifTrue: 
			[
			[self step.
			currentCharacter ~~ $"] whileTrue.
			^ self recordAndReportMatch: #(8 )].
	currentCharacter == $# ifTrue: [^ self recordAndReportMatch: #(3 )].
	currentCharacter == $% 
		ifTrue: 
			[
			[self recordMatch: #comment.
			self step.
			currentCharacter <= Character tab or: 
					[(currentCharacter between: (Character value: 11) and: Character newPage) 
						or: [currentCharacter >= (Character value: 14)]]] 
					whileTrue.
			^ self reportLastMatch].
	currentCharacter == $( 
		ifTrue: [^ self recordAndReportMatch: #parenthesizedString].
	currentCharacter == $, ifTrue: [^ self recordAndReportMatch: #(2 )].
	currentCharacter == $= ifTrue: [^ self recordAndReportMatch: #(4 )].
	currentCharacter == $@ ifTrue: [^ self scan3].
	currentCharacter == ${ 
		ifTrue: [^ self recordAndReportMatch: #bracedString].
	^ self reportLastMatch
]

{ #category : #scanning }
BibScanner >> scanUpTo: stopChar ignore: startChar [ 
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
