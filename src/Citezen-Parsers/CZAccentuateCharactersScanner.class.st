Class {
	#name : #CZAccentuateCharactersScanner,
	#superclass : #SmaCCScanner,
	#category : #'Citezen-Parsers'
}

{ #category : #'generated-initialization' }
CZAccentuateCharactersScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(6 '\#' 39) #(6 '\%' 38) #(6 '\&' 37) #(6 '\-' 36) #(6 '\L' 32) #(6 '\O' 30) #(6 '\\' 5) #(6 '\i' 33) #(6 '\j' 34) #(6 '\l' 31) #(6 '\v' 17))
		do: [ :each | (keywordMap at: each first ifAbsentPut: [ Dictionary new ]) at: (each at: 2) put: each last ].
	^ keywordMap
]

{ #category : #'generated-comments' }
CZAccentuateCharactersScanner class >> scannerDefinitionComment [

	"<plainChar>					:	[a-zA-Z]					;
<openingBrace>				:	\{							;
<closingBrace>				:	\}							;
<noBackSlash>				:	[^a-zA-Z\\\~\}]			;
<doubleSlash>				:	\\ \\							;
<otherSlashedChar>			:	\\ [^'\`\^\""\~\=\.\v\u\H]	;
<dollar>						:	$							;
<endash>						:	\- \-							;
<emdash>					:	\- \- \-						;

#international characters
<acute>						:	\\ \' 						;	# \'{ }
<grave>						:	\\ \` 						;	# \`{ }
<circumflex>					:	\\ \^	 					;	# \^{ }
<umlaut>						:	\\ \""			 				;	# \""{ }
<tilde>						:	\\ \~			 			;	# \~{ }
<bar>							:	\\ \=	 					;	# \={ }
<dot>							:	\\ \.				 			;	# \.{ }
<invCircumflex>				:	\\ v 						;	# \v{ }
<arc>							:	\\ u		 					;	# \u{ }
<doubleQuote>				:	\\ H 						;	# \H{ }

#special characters
<ccedilla>						:	\\ c \{ c \}					;	# \c{c}
<scedilla>						:	\\ c \{ s \}					;	# \c{s}
<tcedilla>						:	\\ c \{ t \}					;	# \c{t}
<inversedQuestionMark>		:	\? \'							;	# ?`
<oe>							:	\\ o e						;	# \oe
<ae>							:	\\ a e						;	# \ae
<ss>							:	\\ s s						;	# {\ss}
<smallRingedA>				:	\\ a a						;	# \aa
<capitalRingedA>				:	\\ A A						;	# \AA
<smallSlashedO>				:	\\ / o						;	# \/o
<capitalSlashedO>			:	\\ O							;	# \O
<barredL>						:	\\ l							;	# \l
<capitalBarredL>				:	\\ L							;	# \L
<iForm>						:	\\ i							;	# \i
<jForm>						:	\\ j							;	# \j
<nonBreakingSpace>			:	\~							;	# ~
<optionalHyphen>			:	\\ -							;	# \-
<ampersand>					:	\\ &							;	# \&
<percent>						:	\\ %						;	# \%
<hash>						:	\\ \#						;

<circlea>						:	\\ o a						;	# \oa
<nu>							:	\\ n u						;	# \nu
<pi>							:	\\ p i						;	# \pi
<tau>							:	\\ t a u						;	# \tau
<omega>						:	\\ o m e g a				;	# \omega
<neq>							:	\\ n e q						;	# \neq
<wedge>						:	\\ w e d g e				;	# \wedge

#unclassified things
<underscoredChar>			:	\\ b \x20					;	# \b"
]

{ #category : #'generated-tokens' }
CZAccentuateCharactersScanner >> emptySymbolTokenId [
	^57
]

{ #category : #'generated-tokens' }
CZAccentuateCharactersScanner >> errorTokenId [
	^58
]

{ #category : #'generated-scanner' }
CZAccentuateCharactersScanner >> scan1 [
	self step.
	(currentCharacter <= Character lf
		or: [ 
			(currentCharacter between: Character newPage and: $!)
				or: [ 
					(currentCharacter between: $# and: $&)
						or: [ 
							(currentCharacter between: $( and: $-)
								or: [ 
									(currentCharacter between: $0 and: $<)
										or: [ 
											(currentCharacter between: $> and: $@)
												or: [ 
													(currentCharacter between: $B and: $G)
														or: [ 
															(currentCharacter between: $I and: $])
																or: [ 
																	currentCharacter = $_
																		or: [ 
																			(currentCharacter between: $d and: $m)
																				or: [ 
																					(currentCharacter between: $q and: $r)
																						or: [ currentCharacter = $v or: [ (currentCharacter between: $x and: $}) or: [ currentCharacter >= $ ] ] ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter = $"
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter = $'
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter = $.
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter = $/
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $o
				ifTrue: [ ^ self recordAndReportMatch: #(29) ].
			^ self reportLastMatch ].
	currentCharacter = $=
		ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter = $A
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $A
				ifTrue: [ ^ self recordAndReportMatch: #(28) ].
			^ self reportLastMatch ].
	currentCharacter = $H
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter = $^
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter = $`
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter = $a
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $a
				ifTrue: [ ^ self recordAndReportMatch: #(27) ].
			currentCharacter = $e
				ifTrue: [ ^ self recordAndReportMatch: #(25) ].
			^ self reportLastMatch ].
	currentCharacter = $b
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = Character space
				ifTrue: [ ^ self recordAndReportMatch: #(47) ].
			^ self reportLastMatch ].
	currentCharacter = $c
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = ${
				ifTrue: [ 
					self step.
					currentCharacter = $c
						ifTrue: [ 
							self step.
							currentCharacter = $}
								ifTrue: [ ^ self recordAndReportMatch: #(20) ].
							^ self reportLastMatch ].
					currentCharacter = $s
						ifTrue: [ 
							self step.
							currentCharacter = $}
								ifTrue: [ ^ self recordAndReportMatch: #(21) ].
							^ self reportLastMatch ].
					currentCharacter = $t
						ifTrue: [ 
							self step.
							currentCharacter = $}
								ifTrue: [ ^ self recordAndReportMatch: #(22) ].
							^ self reportLastMatch ].
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $n
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $e
				ifTrue: [ 
					self step.
					currentCharacter = $q
						ifTrue: [ ^ self recordAndReportMatch: #(45) ].
					^ self reportLastMatch ].
			currentCharacter = $u
				ifTrue: [ ^ self recordAndReportMatch: #(41) ].
			^ self reportLastMatch ].
	currentCharacter = $o
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $a
				ifTrue: [ ^ self recordAndReportMatch: #(40) ].
			currentCharacter = $e
				ifTrue: [ ^ self recordAndReportMatch: #(24) ].
			currentCharacter = $m
				ifTrue: [ 
					self step.
					currentCharacter = $e
						ifTrue: [ 
							self step.
							currentCharacter = $g
								ifTrue: [ 
									self step.
									currentCharacter = $a
										ifTrue: [ ^ self recordAndReportMatch: #(44) ].
									^ self reportLastMatch ].
							^ self reportLastMatch ].
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $p
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $i
				ifTrue: [ ^ self recordAndReportMatch: #(42) ].
			^ self reportLastMatch ].
	currentCharacter = $s
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $s
				ifTrue: [ ^ self recordAndReportMatch: #(26) ].
			^ self reportLastMatch ].
	currentCharacter = $t
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $a
				ifTrue: [ 
					self step.
					currentCharacter = $u
						ifTrue: [ ^ self recordAndReportMatch: #(43) ].
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $u
		ifTrue: [ ^ self recordAndReportMatch: #(18) ].
	currentCharacter = $w
		ifTrue: [ 
			self recordMatch: #(6).
			self step.
			currentCharacter = $e
				ifTrue: [ 
					self step.
					currentCharacter = $d
						ifTrue: [ 
							self step.
							currentCharacter = $g
								ifTrue: [ 
									self step.
									currentCharacter = $e
										ifTrue: [ ^ self recordAndReportMatch: #(46) ].
									^ self reportLastMatch ].
							^ self reportLastMatch ].
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $~
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	^ self reportLastMatch
]

{ #category : #'generated-scanner' }
CZAccentuateCharactersScanner >> scanForToken [
	self step.
	(currentCharacter <= $#
		or: [ 
			(currentCharacter between: $% and: $,)
				or: [ 
					(currentCharacter between: $. and: $>)
						or: [ 
							currentCharacter = $@
								or: [ 
									currentCharacter = $[
										or: [ (currentCharacter between: $] and: $`) or: [ currentCharacter = $| or: [ currentCharacter >= $ ] ] ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	((currentCharacter between: $A and: $Z) or: [ currentCharacter between: $a and: $z ])
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter = $$
		ifTrue: [ ^ self recordAndReportMatch: #(4 7) ].
	currentCharacter = $-
		ifTrue: [ 
			self recordMatch: #(4).
			self step.
			currentCharacter = $-
				ifTrue: [ 
					self recordMatch: #(8).
					self step.
					currentCharacter = $-
						ifTrue: [ ^ self recordAndReportMatch: #(9) ].
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $?
		ifTrue: [ 
			self recordMatch: #(4).
			self step.
			currentCharacter = $'
				ifTrue: [ ^ self recordAndReportMatch: #(23) ].
			^ self reportLastMatch ].
	currentCharacter = $\
		ifTrue: [ ^ self scan1 ].
	currentCharacter = ${
		ifTrue: [ ^ self recordAndReportMatch: #(2 4) ].
	currentCharacter = $}
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter = $~
		ifTrue: [ ^ self recordAndReportMatch: #(35) ].
	^ self reportLastMatch
]
