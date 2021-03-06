"
Parser for BibTeX's .bib database format. Parsing will return an instance of CZSet containing all macros and entries in the file.
"
Class {
	#name : #CZBibParser,
	#superclass : #SmaCCParser,
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-accessing' }
CZBibParser class >> cacheId [
	^'2018-05-07T19:54:46.516584+02:00'
]

{ #category : #generated }
CZBibParser class >> definitionComment [
"#Definition extracted from old style definition comments
<whitespace>	:	[ \t\r\n]*	;
<comment>	:	\% [^\r\n]*	;
<number>	:	[0-9]+ ;
<name>		:	[A-Za-z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+	;
<quotedString>	:	\"" [^\""]* \""	;

<stringTag>	:	\@ ( string | String | STRING )	;
<commentTag>	:	\@ ( comment | Comment | COMMENT )	;

# tokens parsed by code
<bracedString>	:	\{	;
<parenthesizedString>	:	\(	;

## See http://www.gerg.ca/software/btOOL/doc/bt_language.html

%id <bracedString> <parenthesizedString>;
%start Bibfile BodyContents Field;

## outer parser rules
Bibfile :
	(CommentDeclaration | MacroDeclaration | EntryDeclaration)*
		{ CZSet fromDeclarations: ('1' reject: [:it | it isNil]) };

EntryDeclaration :
	""@"" <name> (<parenthesizedString> | <bracedString>)
		{ #buildEntry: };

MacroDeclaration :
	<stringTag> (<parenthesizedString> | <bracedString>)
		{ #buildMacro: };

CommentDeclaration :
	<commentTag> (<parenthesizedString> | <bracedString>)
		{ nil };


## inner parser rules
BodyContents :
	<name> ("","" Field)* { '1' value asSymbol -> ('2' collect: [:each | each at: 2]) };

Field :
	<name> ""="" Value { ('3' isKindOf: CZValue)
		ifTrue: [ CZField key: '1' value asSymbol value: '3' ]
		ifFalse: [ CZField key: '1' value asSymbol rawValue: '3' ]};

Value :
	SimpleValue ( ""#"" SimpleValue )*
		{ '2' isEmpty
			ifTrue: [ ('1' isKindOf: String) ifTrue: [ '1' trimBoth ] ifFalse: [ '1' ]]
			ifFalse: [(CZCompositeValue with: '1')
				addAll: ('2' collect: [:subcoll | subcoll at: 2]);
				yourself] };

SimpleValue :
	<quotedString> { '1' value allButFirst allButLast }
	| <bracedString> { '1' value allButFirst allButLast }
	| <number> { '1' value asNumber }
	| <name> { CZMacroReference with: '1' value asSymbol };"
]

{ #category : #'generated-accessing' }
CZBibParser class >> scannerClass [
	^CZBibScanner
]

{ #category : #generated }
CZBibParser class >> startingStateForBibfile [
	^ 1
]

{ #category : #generated }
CZBibParser class >> startingStateForBodyContents [
	^ 2
]

{ #category : #generated }
CZBibParser class >> startingStateForField [
	^ 3
]

{ #category : #'private-building' }
CZBibParser >> buildEntry: tokens [ 
	| body |
	body := CZBibParser parse: (tokens at: 3) value allButFirst allButLast
				startingAt: self class startingStateForBodyContents.
	^ (CZEntry type: (tokens at: 2) value asSymbol)
		key: body key;
		addFields: body value
]

{ #category : #'private-building' }
CZBibParser >> buildMacro: tokens [ 
	^ CZBibParser parse: (tokens at: 2) value allButFirst allButLast
		startingAt: self class startingStateForField
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForBibfile1: nodes [
	^ CZSet fromDeclarations: ((nodes at: 1) reject: [ :it | it isNil ])
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForBodyContents1: nodes [
	^ (nodes at: 1) value asSymbol
		-> ((nodes at: 2) collect: [ :each | each at: 2 ])
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForField1: nodes [
	^ ((nodes at: 3) isKindOf: CZValue)
		ifTrue: [ CZField key: (nodes at: 1) value asSymbol value: (nodes at: 3) ]
		ifFalse: [ CZField key:
				(nodes at: 1) value asSymbol rawValue: (nodes at: 3) ]
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForSimpleValue1: nodes [
	^ (nodes at: 1) value allButFirst allButLast
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForSimpleValue3: nodes [
	^ (nodes at: 1) value asNumber
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForSimpleValue4: nodes [
	^ CZMacroReference with: (nodes at: 1) value asSymbol
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForValue1: nodes [
	^ (nodes at: 2) isEmpty
		ifTrue: [ ((nodes at: 1) isKindOf: String)
				ifTrue: [ (nodes at: 1) trimBoth ]
				ifFalse: [ nodes at: 1 ] ]
		ifFalse: [ (CZCompositeValue with: (nodes at: 1))
				addAll: ((nodes at: 2) collect: [ :subcoll | subcoll at: 2 ]);
				yourself ]
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration_2: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #generated }
CZBibParser >> reduceTable [
^#(
	#(16 0 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__1:) 
	#(31 1 #reduceActionForBibfile1:) 
	#(21 0 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__1:) 
	#(16 2 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__2:) 
	#(14 1 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration_2:) 
	#(27 2 #reduceActionForBodyContents1:) 
	#(17 1 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration_2:) 
	#(18 2 #buildMacro:) 
	#(19 2 #nil) 
	#(21 2 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__2:) 
	#(23 1 #reduceActionForSimpleValue3:) 
	#(23 1 #reduceActionForSimpleValue4:) 
	#(23 1 #reduceActionForSimpleValue1:) 
	#(26 3 #reduceActionForField1:) 
	#(25 0 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__1:) 
	#(30 3 #buildEntry:) 
	#(20 2 #reduceFor:) 
	#(22 2 #reduceActionForValue1:) 
	#(25 2 #reduceActionFor__CommentDeclaration_MacroDeclaration_EntryDeclaration__2:) 
	#(24 2 #reduceFor:)
	).
]

{ #category : #generated }
CZBibParser >> symbolNames [
	^ #('"@"' '","' '"#"' '"="' '<whitespace>' '<comment>' '<number>' '<name>' '<quotedString>' '<stringTag>' '<commentTag>' '<bracedString>' '<parenthesizedString>' '( CommentDeclaration MacroDeclaration EntryDeclaration)' 'B e g i n' '( CommentDeclaration MacroDeclaration EntryDeclaration)*' '( <parenthesizedString> <bracedString>)' 'MacroDeclaration' 'CommentDeclaration' '( "," Field)' '( "," Field)*' 'Value' 'SimpleValue' '( "#" SimpleValue)' '( "#" SimpleValue)*' 'Field' 'BodyContents' 'E O F' 'error' 'EntryDeclaration' 'Bibfile')
]

{ #category : #generated }
CZBibParser >> transitionTable [
^#(
#[1 0 6 0 1 0 6 0 10 0 6 0 11 0 17 0 16 0 6 0 28 0 21 0 31] 
#[1 0 25 0 8 0 29 0 27] 
#[1 0 33 0 8 0 37 0 26] 
#[1 0 41 0 1 0 45 0 10 0 49 0 11 0 53 0 14 0 57 0 18 0 61 0 19 0 10 0 28 0 65 0 30] 
#[0 0 0 0 28] 
#[1 0 14 0 2 0 69 0 21 0 14 0 28] 
#[0 0 0 0 28] 
#[0 0 73 0 4] 
#[0 0 0 0 28] 
#[0 0 77 0 8] 
#[1 0 81 0 12 0 85 0 13 0 89 0 17] 
#[1 0 81 0 12 0 85 0 13 0 93 0 17] 
#[0 0 18 0 1 0 10 0 11 0 28] 
#[0 0 22 0 1 0 10 0 11 0 28] 
#[0 0 22 0 1 0 10 0 11 0 28] 
#[0 0 22 0 1 0 10 0 11 0 28] 
#[1 0 97 0 2 0 101 0 20 0 26 0 28] 
#[1 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 12 0 121 0 22 0 125 0 23] 
#[1 0 81 0 12 0 85 0 13 0 129 0 17] 
#[0 0 30 0 1 0 10 0 11 0 28] 
#[0 0 30 0 1 0 10 0 11 0 28] 
#[0 0 34 0 1 0 10 0 11 0 28] 
#[0 0 38 0 1 0 10 0 11 0 28] 
#[1 0 33 0 8 0 133 0 26] 
#[0 0 42 0 2 0 28] 
#[0 0 46 0 2 0 3 0 28] 
#[0 0 50 0 2 0 3 0 28] 
#[0 0 54 0 2 0 3 0 28] 
#[0 0 54 0 2 0 3 0 28] 
#[0 0 58 0 2 0 28] 
#[1 0 62 0 2 0 62 0 3 0 137 0 25 0 62 0 28] 
#[0 0 66 0 1 0 10 0 11 0 28] 
#[0 0 70 0 2 0 28] 
#[1 0 74 0 2 0 141 0 3 0 145 0 24 0 74 0 28] 
#[1 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 12 0 149 0 23] 
#[0 0 78 0 2 0 3 0 28] 
#[0 0 82 0 2 0 3 0 28]
	).
]
