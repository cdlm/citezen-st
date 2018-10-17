Class {
	#name : #CZAccentuateCharactersParser,
	#superclass : #SmaCCParser,
	#classInstVars : [
		'conversionTable'
	],
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-accessing' }
CZAccentuateCharactersParser class >> cacheId [
	^'2018-05-07T19:15:36.894319+02:00'
]

{ #category : #'as yet unclassified' }
CZAccentuateCharactersParser class >> conversionTable [
	^ (conversionTable isNil) 
		ifTrue: [conversionTable := self toHtmlTable]
		ifFalse: [conversionTable]
]

{ #category : #generated }
CZAccentuateCharactersParser class >> definitionComment [
"#Definition extracted from old style definition comments
<plainChar>					:	[a-zA-Z]						;
<openingBrace>				:	\{							;
<closingBrace>				:	\}							;
<noBackSlash>				:	[^a-zA-Z\\\~\}]					;
<doubleSlash>				:	\\ \\								;
<otherSlashedChar>			:	\\ [^'\`\^\""\~\=\.\v\u\H]		;
<dollar>						:	$							;
<endash>						:	\- \-							;
<emdash>					:	\- \- \-							;

#international characters
<acute>						:	\\ \' 							;	# \'{ }
<grave>						:	\\ \` 							;	# \`{ }
<circumflex>					:	\\ \^	 					;	# \^{ }
<umlaut>						:	\\ \""			 				;	# \""{ }
<tilde>							:	\\ \~			 			;	# \~{ }
<bar>							:	\\ \=	 					;	# \={ }
<dot>							:	\\ \.				 			;	# \.{ }
<invCircumflex>				:	\\ v 							;	# \v{ }
<arc>							:	\\ u		 					;	# \u{ }
<doubleQuote>				:	\\ H 						;	# \H{ }

#special characters
<ccedilla>						:	\\ c \{ c \} | \\ c \  c 			;	# \c{c}
<scedilla>						:	\\ c \{ s \} | \\ c \  s			;	# \c{s}
<tcedilla>						:	\\ c \{ t \} | \\ c \  t			;	# \c{t}
<inversedQuestionMark>		:	\? \'							;	# ?`
<oe>							:	\\ o e						;	# \oe
<ae>							:	\\ a e						;	# \ae
<ss>							:	\\ s s						;	# {\ss}
<smallRingedA>				:	\\ a a						;	# \aa
<capitalRingedA>				:	\\ A A						;	# \AA
<smallSlashedO>				:	\\ / o						;	# \/o
<capitalSlashedO>				:	\\ O							;	# \O
<barredL>						:	\\ l							;	# \l
<capitalBarredL>				:	\\ L							;	# \L
<iForm>						:	\\ i							;	# \i
<jForm>						:	\\ j							;	# \j
<nonBreakingSpace>			:	\~							;	# ~
<optionalHyphen>				:	\\ -							;	# \-
<ampersand>					:	\\ &							;	# \&
<percent>						:	\\ \%						;	# \%
<hash>							:	\\ \#						;

<circlea>						:	\\ o a						;	# \oa
<nu>							:	\\ n u						;	# \nu
<pi>							:	\\ p i						;	# \pi
<tau>							:	\\ t a u						;	# \tau
<omega>						:	\\ o m e g a					;	# \omega
<neq>							:	\\ n e q						;	# \neq
<wedge>						:	\\ w e d g e					;	# \wedge

#unclassified things
<underscoredChar>			:	\\ b \x20					;	# \b

TEXSTRING		:	TEXPIECE*		{ | str |		str := WriteStream on: String new.
											nodes first do: [:string | str nextPutAll: string].
											str contents }
;

TEXPIECE		:	accentableCHAR										{ '1' }
				|	other													{ '1' }
				|	special													{ '1' }
				|	<openingBrace> other								{ '2' }
				|	<openingBrace> accentableCHAR					{ '2' }
				|	<dollar>												{ '' } # ignore
;

other			:	<noBackSlash>										{ '1' value }
				|	<closingBrace>										{ '' }
				|	<otherSlashedChar>									{ '1' value }
				|	<underscoredChar> <plainChar>					{ self convert: '2' value as: #underscoredChar }
				|	<nonBreakingSpace>									{ self lookup: #nonBreakingSpace }
;

special			:	specialCHAR											{ '1' }
				|	<openingBrace> specialCHAR <closingBrace>		{ '2' }
;

specialCHAR	:	<acute> accentable									{ self convert: '2' as: #acute }
				|	<grave> accentable									{ self convert: '2' as: #grave }
				|	<circumflex> accentable								{ self convert: '2' as: #circumflex }
				|	<umlaut> accentable									{ self convert: '2' as: #umlaut }
				|	<tilde> accentable									{ self convert: '2' as: #tilde }
				|	<bar> accentable										{ self convert: '2' as: #bar }
				|	<dot> accentable										{ self convert: '2' as: #dot }
				|	<invCircumflex> accentable							{ self convert: '2' as: #invCircumflex }
				|	<arc> accentable										{ self convert: '2' as: #arc }
				|	<doubleQuote> accentable							{ self convert: '2' as: #doubleQuote }
				|	<ccedilla>												{ self lookup: #ccedilla }
				|	<scedilla>												{ self lookup: #scedilla }
				|	<tcedilla>												{ self lookup: #tcedilla }
				|	<inversedQuestionMark>								{ self lookup: #inversedQuestionMark }
				|	<doubleSlash>										{ self lookup: #doubleSlash }
				|	<smallRingedA>										{ self lookup: #smallRingedA }
				|	<capitalRingedA>										{ self lookup: #capitalRingedA }
				|	<optionalHyphen>									{ '' } # ignore
				|	<ampersand>											{ self lookup: #ampersand }
				|	<percent>												{ self lookup: #percent }
				|	<hash>												{ self lookup: #hash }
				|	<circlea>												{ self lookup: #circlea }
				|	<nu>													{ self lookup: #nu }
				|	<pi>													{ self lookup: #pi }
				|	<tau>													{ self lookup: #tau }
				|	<omega>												{ self lookup: #omega }
				|	<neq>													{ self lookup: #neq }
				|	<wedge>												{ self lookup: #wedge }
				|	<endash>												{ self lookup: #endash }
				|	<emdash>											{ self lookup: #emdash }
;

# Treat a char in curly braces like a regular char
accentable		:	accentableCHAR										{ '1' }
				|	<openingBrace> accentableCHAR <closingBrace>	{ '2' }
;

accentableCHAR	 :	<plainChar>										{ '1' value }
				|	<oe>													{ self lookup: #oe }
				|	<ae>													{ self lookup: #ae }
				|	<ss>													{ self lookup: #ss }
				|	<smallSlashedO>										{ self lookup: #smallSlashedO }
				|	<capitalSlashedO>									{ self lookup: #capitalSlashedO }
				|	<iForm>												{ self lookup: #iForm }
				|	<jForm>												{ self lookup: #jForm }
				|	<barredL>												{ self lookup: #barredL }
				|	<capitalBarredL>										{ self lookup: #capitalBarredL }
;"
]

{ #category : #'as yet unclassified' }
CZAccentuateCharactersParser class >> parseToAccentedChars: aString [
	"Needs to be rewritten to use an instance variable instead."

	| result |
	conversionTable := self toAccentedCharTable.
	result := ''.
	result := self parse: aString "valueNowOrOnUnwindDo: [self resetConversionTable]".
	^result
]

{ #category : #'as yet unclassified' }
CZAccentuateCharactersParser class >> resetConversionTable [
	"self resetConversionTable"

	^ conversionTable := nil
]

{ #category : #'generated-accessing' }
CZAccentuateCharactersParser class >> scannerClass [
	^CZAccentuateCharactersScanner
]

{ #category : #generated }
CZAccentuateCharactersParser class >> startingStateForTEXSTRING [
	^ 1
]

{ #category : #'as yet unclassified' }
CZAccentuateCharactersParser class >> toAccentedCharTable [
	| table |
	
	table := IdentityDictionary new.
	table
		at: #acute put: [:charString | String with: (charString first composeDiacritical: (Character diacriticalNamed: #acute)) ];
		at: #grave put: [:charString | String with: (charString first composeDiacritical: (Character diacriticalNamed: #grave)) ];
		at: #circumflex put: [:charString | String with: (charString first composeDiacritical: (Character diacriticalNamed: #circumflex))];
		at: #umlaut put: [:charString | String with: (charString first composeDiacritical: (Character diacriticalNamed: #diaresis))];
		at: #tilde put: [:charString | String with: (charString first composeDiacritical: (Character diacriticalNamed: #tilde))];

		at: #ccedilla put: (String with: ($c composeDiacritical: (Character diacriticalNamed: #cedilla))) ;
		at: #scedilla put: (String with: ($s composeDiacritical: (Character diacriticalNamed: #cedilla))) ;
		at: #tcedilla put: (String with: ($t composeDiacritical: (Character diacriticalNamed: #cedilla))) ;
		at: #oe put: (Character value: 339) ;
		at: #ae put: (Character value: 230) ;
		at: #ss put: 'ss' ;
		at: #smallRingedA put: (String with: ($a composeDiacritical: (Character diacriticalNamed: #ringAbove))) ;
		at: #capitalRingedA put: (String with: ($A composeDiacritical: (Character diacriticalNamed: #ringAbove))) ;
		at: #smallSlashedO put: '&oslash;' ;
		at: #capitalSlashedO put: '&Oslash;' ;
		at: #nonBreakingSpace put: ' ' ;
		at: #iForm put: 'i';
		at: #jForm put: 'j';
		at: #barredL put: 'l' ;

		at: #circlea put: 'a';
		at: #nu put: '&#957;';
		at: #omega put: '&#969;';
		at: #pi put: '&#960;';
		at: #tau put: '&#964;';
		at: #neq put: '&#8800;';
		at: #wedge put: '&#1783;' ;

		at: #capitalBarredL put: 'L';
		at: #doubleSlash put: '\';
		at: #ampersand put: '&';
		at: #percent put: '%';
		at: #hash put: '#'	;
		at: #endash put: '--'	"	;
		at: #emdash put: '&#8212'	"
	.
	^ table
]

{ #category : #'as yet unclassified' }
CZAccentuateCharactersParser class >> toHtmlTable [
	| table |
	
	table := IdentityDictionary new.
	table
		at: #acute put: [:charString | '&', charString,'acute;'];
		at: #grave put: [:charString | '&', charString,'grave;'];
		at: #circumflex put: [:charString | '&', charString, 'circ;'];
		at: #umlaut put: [:charString | '&', charString,'uml;'];
		at: #tilde put: [:charString | '&', charString,'tilde;'];

		at: #ccedilla put: '&ccedil;' ;
		at: #scedilla put: '&#351;' ;
		at: #tcedilla put: '&#355;' ;
		at: #inversedQuestionMark put: '&iquest;' ;
		at: #oe put: '&#339;' ;
		at: #ae put: '&aelig;' ;
		at: #ss put: '&szlig;' ;
		at: #smallRingedA put: '&aring;' ;
		at: #capitalRingedA put: '&Aring;' ;
		at: #smallSlashedO put: '&oslash;' ;
		at: #capitalSlashedO put: '&Oslash;' ;
		at: #nonBreakingSpace put: '&nbsp;' ;
		at: #iForm put: 'i';
		at: #jForm put: 'j';
		at: #barredL put: 'l';

		at: #circlea put: '&#229;';
		at: #nu put: '&#957;';
		at: #omega put: '&#969;';
		at: #pi put: '&#960;';
		at: #tau put: '&#964;';
		at: #neq put: '&#8800;';
		at: #wedge put: '&#1783;';

		at: #capitalBarredL put: 'L';
		at: #doubleSlash put: '\';
		at: #ampersand put: '&';
		at: #percent put: '%';
		at: #hash put: '#';
		at: #endash put: '&#8211;';
		at: #emdash put: '&#8212;'.
	^ table
]

{ #category : #accessing }
CZAccentuateCharactersParser >> conversionTable [
	^ self class conversionTable
]

{ #category : #accessing }
CZAccentuateCharactersParser >> convert: aCharString as: type [
	^ (self conversionTable at: type ifAbsent: [ ^ aCharString ]) value: aCharString
]

{ #category : #accessing }
CZAccentuateCharactersParser >> lookup: type [
	^ self conversionTable at: type ifAbsent: [ '' ]
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForTEXPIECE1: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForTEXPIECE_1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForTEXPIECE_2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForTEXSTRING1: nodes [
	| str |
	str := WriteStream on: String new.
	nodes first do: [ :string | str nextPutAll: string ].
	^ str contents
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR10: nodes [
	^ self lookup: #capitalBarredL
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR1: nodes [
	^ (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR2: nodes [
	^ self lookup: #oe
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR3: nodes [
	^ self lookup: #ae
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR4: nodes [
	^ self lookup: #ss
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR5: nodes [
	^ self lookup: #smallSlashedO
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR6: nodes [
	^ self lookup: #capitalSlashedO
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR7: nodes [
	^ self lookup: #iForm
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR8: nodes [
	^ self lookup: #jForm
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForaccentableCHAR9: nodes [
	^ self lookup: #barredL
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForother2: nodes [
	^ ''
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForother4: nodes [
	^ self convert: (nodes at: 2) value as: #underscoredChar
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForother5: nodes [
	^ self lookup: #nonBreakingSpace
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR10: nodes [
	^ self convert: (nodes at: 2) as: #doubleQuote
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR11: nodes [
	^ self lookup: #ccedilla
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR12: nodes [
	^ self lookup: #scedilla
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR13: nodes [
	^ self lookup: #tcedilla
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR14: nodes [
	^ self lookup: #inversedQuestionMark
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR15: nodes [
	^ self lookup: #doubleSlash
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR16: nodes [
	^ self lookup: #smallRingedA
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR17: nodes [
	^ self lookup: #capitalRingedA
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR19: nodes [
	^ self lookup: #ampersand
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR1: nodes [
	^ self convert: (nodes at: 2) as: #acute
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR20: nodes [
	^ self lookup: #percent
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR21: nodes [
	^ self lookup: #hash
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR22: nodes [
	^ self lookup: #circlea
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR23: nodes [
	^ self lookup: #nu
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR24: nodes [
	^ self lookup: #pi
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR25: nodes [
	^ self lookup: #tau
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR26: nodes [
	^ self lookup: #omega
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR27: nodes [
	^ self lookup: #neq
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR28: nodes [
	^ self lookup: #wedge
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR29: nodes [
	^ self lookup: #endash
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR2: nodes [
	^ self convert: (nodes at: 2) as: #grave
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR30: nodes [
	^ self lookup: #emdash
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR3: nodes [
	^ self convert: (nodes at: 2) as: #circumflex
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR4: nodes [
	^ self convert: (nodes at: 2) as: #umlaut
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR5: nodes [
	^ self convert: (nodes at: 2) as: #tilde
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR6: nodes [
	^ self convert: (nodes at: 2) as: #bar
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR7: nodes [
	^ self convert: (nodes at: 2) as: #dot
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR8: nodes [
	^ self convert: (nodes at: 2) as: #invCircumflex
]

{ #category : #'generated-reduction actions' }
CZAccentuateCharactersParser >> reduceActionForspecialCHAR9: nodes [
	^ self convert: (nodes at: 2) as: #arc
]

{ #category : #generated }
CZAccentuateCharactersParser >> reduceTable [
^#(
	#(48 0 #reduceActionForTEXPIECE_1:) 
	#(49 1 #reduceActionForTEXSTRING1:) 
	#(51 1 #reduceActionForaccentableCHAR1:) 
	#(52 1 #reduceActionForother2:) 
	#(52 1 #reduceActionForaccentableCHAR1:) 
	#(55 1 #reduceActionForspecialCHAR15:) 
	#(50 1 #reduceActionForother2:) 
	#(55 1 #reduceActionForspecialCHAR29:) 
	#(55 1 #reduceActionForspecialCHAR30:) 
	#(55 1 #reduceActionForspecialCHAR11:) 
	#(55 1 #reduceActionForspecialCHAR12:) 
	#(55 1 #reduceActionForspecialCHAR13:) 
	#(55 1 #reduceActionForspecialCHAR14:) 
	#(51 1 #reduceActionForaccentableCHAR2:) 
	#(51 1 #reduceActionForaccentableCHAR3:) 
	#(51 1 #reduceActionForaccentableCHAR4:) 
	#(55 1 #reduceActionForspecialCHAR16:) 
	#(55 1 #reduceActionForspecialCHAR17:) 
	#(51 1 #reduceActionForaccentableCHAR5:) 
	#(51 1 #reduceActionForaccentableCHAR6:) 
	#(51 1 #reduceActionForaccentableCHAR9:) 
	#(51 1 #reduceActionForaccentableCHAR10:) 
	#(51 1 #reduceActionForaccentableCHAR7:) 
	#(51 1 #reduceActionForaccentableCHAR8:) 
	#(52 1 #reduceActionForother5:) 
	#(55 1 #reduceActionForother2:) 
	#(55 1 #reduceActionForspecialCHAR19:) 
	#(55 1 #reduceActionForspecialCHAR20:) 
	#(55 1 #reduceActionForspecialCHAR21:) 
	#(55 1 #reduceActionForspecialCHAR22:) 
	#(55 1 #reduceActionForspecialCHAR23:) 
	#(55 1 #reduceActionForspecialCHAR24:) 
	#(55 1 #reduceActionForspecialCHAR25:) 
	#(55 1 #reduceActionForspecialCHAR26:) 
	#(55 1 #reduceActionForspecialCHAR27:) 
	#(55 1 #reduceActionForspecialCHAR28:) 
	#(48 2 #reduceActionForTEXPIECE_2:) 
	#(50 1 #reduceActionForTEXPIECE1:) 
	#(53 1 #reduceActionForTEXPIECE1:) 
	#(50 2 #liftSecondValue:) 
	#(56 1 #reduceActionForTEXPIECE1:) 
	#(55 2 #reduceActionForspecialCHAR1:) 
	#(55 2 #reduceActionForspecialCHAR2:) 
	#(55 2 #reduceActionForspecialCHAR3:) 
	#(55 2 #reduceActionForspecialCHAR4:) 
	#(55 2 #reduceActionForspecialCHAR5:) 
	#(55 2 #reduceActionForspecialCHAR6:) 
	#(55 2 #reduceActionForspecialCHAR7:) 
	#(55 2 #reduceActionForspecialCHAR8:) 
	#(55 2 #reduceActionForspecialCHAR9:) 
	#(55 2 #reduceActionForspecialCHAR10:) 
	#(52 2 #reduceActionForother4:) 
	#(53 3 #liftSecondValue:) 
	#(56 3 #liftSecondValue:)
	).
]

{ #category : #generated }
CZAccentuateCharactersParser >> symbolNames [
	^ #('<plainChar>' '<openingBrace>' '<closingBrace>' '<noBackSlash>' '<doubleSlash>' '<otherSlashedChar>' '<dollar>' '<endash>' '<emdash>' '<acute>' '<grave>' '<circumflex>' '<umlaut>' '<tilde>' '<bar>' '<dot>' '<invCircumflex>' '<arc>' '<doubleQuote>' '<ccedilla>' '<scedilla>' '<tcedilla>' '<inversedQuestionMark>' '<oe>' '<ae>' '<ss>' '<smallRingedA>' '<capitalRingedA>' '<smallSlashedO>' '<capitalSlashedO>' '<barredL>' '<capitalBarredL>' '<iForm>' '<jForm>' '<nonBreakingSpace>' '<optionalHyphen>' '<ampersand>' '<percent>' '<hash>' '<circlea>' '<nu>' '<pi>' '<tau>' '<omega>' '<neq>' '<wedge>' '<underscoredChar>' 'TEXPIECE*' 'TEXSTRING' 'TEXPIECE' 'accentableCHAR' 'other' 'special' 'B e g i n' 'specialCHAR' 'accentable' 'E O F' 'error')
]

{ #category : #generated }
CZAccentuateCharactersParser >> transitionTable [
^#(
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 5 0 6 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 0 6 0 31 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 0 6 0 37 0 6 0 38 0 6 0 39 0 6 0 40 0 6 0 41 0 6 0 42 0 6 0 43 0 6 0 44 0 6 0 45 0 6 0 46 0 6 0 47 0 9 0 48 0 13 0 49 0 6 0 57] 
#[1 0 17 0 1 0 21 0 2 0 25 0 3 0 29 0 4 0 33 0 5 0 37 0 6 0 41 0 7 0 45 0 8 0 49 0 9 0 53 0 10 0 57 0 11 0 61 0 12 0 65 0 13 0 69 0 14 0 73 0 15 0 77 0 16 0 81 0 17 0 85 0 18 0 89 0 19 0 93 0 20 0 97 0 21 0 101 0 22 0 105 0 23 0 109 0 24 0 113 0 25 0 117 0 26 0 121 0 27 0 125 0 28 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 153 0 35 0 157 0 36 0 161 0 37 0 165 0 38 0 169 0 39 0 173 0 40 0 177 0 41 0 181 0 42 0 185 0 43 0 189 0 44 0 193 0 45 0 197 0 46 0 201 0 47 0 205 0 50 0 209 0 51 0 213 0 52 0 217 0 53 0 221 0 55 0 10 0 57] 
#[0 0 0 0 57] 
#[0 0 14 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[1 0 17 0 1 0 25 0 3 0 29 0 4 0 33 0 5 0 37 0 6 0 45 0 8 0 49 0 9 0 53 0 10 0 57 0 11 0 61 0 12 0 65 0 13 0 69 0 14 0 73 0 15 0 77 0 16 0 81 0 17 0 85 0 18 0 89 0 19 0 93 0 20 0 97 0 21 0 101 0 22 0 105 0 23 0 109 0 24 0 113 0 25 0 117 0 26 0 121 0 27 0 125 0 28 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 153 0 35 0 157 0 36 0 161 0 37 0 165 0 38 0 169 0 39 0 173 0 40 0 177 0 41 0 181 0 42 0 185 0 43 0 189 0 44 0 193 0 45 0 197 0 46 0 201 0 47 0 225 0 51 0 229 0 52 0 233 0 55] 
#[0 0 18 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 22 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 22 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 34 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 38 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 0 245 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 0 249 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 0 253 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 1 1 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 1 5 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 1 9 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 1 13 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 1 17 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 1 21 0 56] 
#[1 0 17 0 1 0 237 0 2 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 0 241 0 51 1 25 0 56] 
#[0 0 42 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 46 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 54 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 58 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 62 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 66 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 70 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 74 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 78 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 82 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 86 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 90 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 94 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 98 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 102 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 106 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 110 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 114 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 118 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 122 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 126 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 130 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 134 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 138 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 142 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 146 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 1 29 0 1] 
#[0 0 150 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 154 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 154 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 154 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 158 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 162 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 162 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 1 33 0 3] 
#[1 0 17 0 1 0 109 0 24 0 113 0 25 0 117 0 26 0 129 0 29 0 133 0 30 0 137 0 31 0 141 0 32 0 145 0 33 0 149 0 34 1 37 0 51] 
#[0 0 166 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 170 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 174 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 178 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 182 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 186 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 190 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 194 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 198 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 202 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 206 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 210 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 0 214 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57] 
#[0 1 41 0 3] 
#[0 0 218 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 57]
	).
]
