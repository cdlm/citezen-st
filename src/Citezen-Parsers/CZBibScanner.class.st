Class {
	#name : #CZBibScanner,
	#superclass : #CZDelimitedStringScanner,
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-comments' }
CZBibScanner class >> scannerDefinitionComment [

	"<whitespace>	:	[ \t\r\n]*	;
<comment>	:	\% [^\r\n]*	;
<number>	:	[0-9]+ ;
<name>		:	[A-Za-z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+	;
<quotedString>	:	\"" [^\""]* \""	;

<stringTag>	:	\@ ( string | String | STRING )	;
<commentTag>	:	\@ ( comment | Comment | COMMENT )	;

# tokens parsed by code
<bracedString>	:	\{	;
<parenthesizedString>	:	\(	;
"
]

{ #category : #'generated-tokens' }
CZBibScanner >> bracedStringId [
	^12
]

{ #category : #'generated-tokens' }
CZBibScanner >> emptySymbolTokenId [
	^28
]

{ #category : #'generated-tokens' }
CZBibScanner >> errorTokenId [
	^29
]

{ #category : #'generated-tokens' }
CZBibScanner >> parenthesizedStringId [
	^13
]

{ #category : #'generated-scanner' }
CZBibScanner >> scan1 [
	self recordMatch: #(1 ).
	self step.
	currentCharacter = $C 
		ifTrue: 
			[self step.
			currentCharacter = $O 
				ifTrue: 
					[self step.
					currentCharacter = $M 
						ifTrue: 
							[self step.
							currentCharacter = $M 
								ifTrue: 
									[self step.
									currentCharacter = $E 
										ifTrue: 
											[self step.
											currentCharacter = $N 
												ifTrue: 
													[self step.
													currentCharacter = $T ifTrue: [^ self recordAndReportMatch: #(11 )].
													^ self reportLastMatch].
											^ self reportLastMatch].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			currentCharacter = $o ifTrue: [^ self scan3].
			^ self reportLastMatch].
	currentCharacter = $S 
		ifTrue: 
			[self step.
			currentCharacter = $T 
				ifTrue: 
					[self step.
					currentCharacter = $R 
						ifTrue: 
							[self step.
							currentCharacter = $I 
								ifTrue: 
									[self step.
									currentCharacter = $N 
										ifTrue: 
											[self step.
											currentCharacter = $G ifTrue: [^ self recordAndReportMatch: #(10 )].
											^ self reportLastMatch].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			currentCharacter = $t ifTrue: [^ self scan2].
			^ self reportLastMatch].
	currentCharacter = $c 
		ifTrue: 
			[self step.
			currentCharacter = $o ifTrue: [^ self scan3].
			^ self reportLastMatch].
	currentCharacter = $s 
		ifTrue: 
			[self step.
			currentCharacter = $t ifTrue: [^ self scan2].
			^ self reportLastMatch].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
CZBibScanner >> scan2 [
	self step.
	currentCharacter = $r 
		ifTrue: 
			[self step.
			currentCharacter = $i 
				ifTrue: 
					[self step.
					currentCharacter = $n 
						ifTrue: 
							[self step.
							currentCharacter = $g ifTrue: [^ self recordAndReportMatch: #(10 )].
							^ self reportLastMatch].
					^ self reportLastMatch].
			^ self reportLastMatch].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
CZBibScanner >> scan3 [
	self step.
	currentCharacter = $m 
		ifTrue: 
			[self step.
			currentCharacter = $m 
				ifTrue: 
					[self step.
					currentCharacter = $e 
						ifTrue: 
							[self step.
							currentCharacter = $n 
								ifTrue: 
									[self step.
									currentCharacter = $t ifTrue: [^ self recordAndReportMatch: #(11 )].
									^ self reportLastMatch].
							^ self reportLastMatch].
					^ self reportLastMatch].
			^ self reportLastMatch].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
CZBibScanner >> scanForToken [
	self recordMatch: #whitespace.
	self step.
	(currentCharacter = $! or: 
			[currentCharacter = $$ or: 
					[currentCharacter = $& or: 
							[(currentCharacter between: $* and: $+) or: 
									[(currentCharacter between: $- and: $/) or: 
											[(currentCharacter between: $: and: $<) or: 
													[(currentCharacter between: $> and: $?) or: 
															[(currentCharacter between: $A and: $[) 
																or: [(currentCharacter between: $] and: $z) or: [currentCharacter = $|]]]]]]]]]) 
		ifTrue: 
			[
			[self recordMatch: #(8 ).
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
	(currentCharacter between: $0 and: $9) 
		ifTrue: 
			[
			[self recordMatch: #(7 8 ).
			self step.
			(currentCharacter = $! or: 
					[currentCharacter = $$ or: 
							[currentCharacter = $& or: 
									[(currentCharacter between: $* and: $+) or: 
											[(currentCharacter between: $- and: $/) or: 
													[(currentCharacter between: $: and: $<) or: 
															[(currentCharacter between: $> and: $?) or: 
																	[(currentCharacter between: $A and: $[) 
																		or: [(currentCharacter between: $] and: $z) or: [currentCharacter = $|]]]]]]]]]) 
				ifTrue: 
					[
					[self recordMatch: #(8 ).
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
			currentCharacter between: $0 and: $9] 
					whileTrue.
			^ self reportLastMatch].
	((currentCharacter between: Character tab and: Character lf) 
		or: [currentCharacter = Character cr or: [currentCharacter = Character space]]) 
			ifTrue: 
				[
				[self recordMatch: #whitespace.
				self step.
				(currentCharacter between: Character tab and: Character lf) 
					or: [currentCharacter = Character cr or: [currentCharacter = Character space]]] 
						whileTrue.
				^ self reportLastMatch].
	currentCharacter = $" 
		ifTrue: 
			[
			[self step.
			currentCharacter ~= $"] whileTrue.
			currentCharacter = $" ifTrue: [^ self recordAndReportMatch: #(9 )].
			^ self reportLastMatch].
	currentCharacter = $# ifTrue: [^ self recordAndReportMatch: #(3 )].
	currentCharacter = $% 
		ifTrue: 
			[
			[self recordMatch: #comment.
			self step.
			currentCharacter <= Character tab or: 
					[(currentCharacter between: (Character value: 11) and: Character newPage) 
						or: [currentCharacter >= (Character value: 14)]]] 
					whileTrue.
			^ self reportLastMatch].
	currentCharacter = $( 
		ifTrue: [^ self recordAndReportMatch: #parenthesizedString].
	currentCharacter = $, ifTrue: [^ self recordAndReportMatch: #(2 )].
	currentCharacter = $= ifTrue: [^ self recordAndReportMatch: #(4 )].
	currentCharacter = $@ ifTrue: [^ self scan1].
	currentCharacter = ${ ifTrue: [^ self recordAndReportMatch: #bracedString].
	^ self reportLastMatch
]
