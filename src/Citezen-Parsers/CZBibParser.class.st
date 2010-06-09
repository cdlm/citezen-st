"
Parser for BibTeX's .bib database format. Parsing will return an instance of CZSet containing all macros and entries in the file.
"
Class {
	#name : #CZBibParser,
	#superclass : #SmaCCParser,
	#category : #'Citezen-Parsers'
}

{ #category : #'generated-comments' }
CZBibParser class >> parserDefinitionComment [

	"## See http://www.gerg.ca/software/btOOL/doc/bt_language.html

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
			ifTrue: [ '1' trimBoth ]
			ifFalse: [(CZCompositeValue with: '1')
				addAll: ('2' collect: [:subcoll | subcoll at: 2]);
				yourself] };

SimpleValue :
	<quotedString> { '1' value allButFirst allButLast }
	| <bracedString> { '1' value allButFirst allButLast }
	| <number> { '1' value asNumber }
	| <name> { CZMacroReference with: '1' value asSymbol };
"
]

{ #category : #'generated-accessing' }
CZBibParser class >> scannerClass [
	^CZBibScanner
]

{ #category : #'generated-starting states' }
CZBibParser class >> startingStateForBibfile [
	^2
]

{ #category : #'generated-starting states' }
CZBibParser class >> startingStateForBodyContents [
	^3
]

{ #category : #'generated-starting states' }
CZBibParser class >> startingStateForField [
	^4
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
	^ (nodes at: 1) value asSymbol -> ((nodes at: 2) collect: [ :each | each at: 2 ])
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForCommentDeclaration1: nodes [
	^ nil
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForField1: nodes [
	^ ((nodes at: 3) isKindOf: CZValue)
		ifTrue: [ CZField key: (nodes at: 1) value asSymbol value: (nodes at: 3) ]
		ifFalse: [ CZField key: (nodes at: 1) value asSymbol rawValue: (nodes at: 3) ]
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration3: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX1: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX2: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForRepeatXXGroupXXXXXXXXXField1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForRepeatXXGroupXXXXXXXXXField2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForSimpleValue1: nodes [
	^ (nodes at: 1) value allButFirst allButLast
]

{ #category : #'generated-reduction actions' }
CZBibParser >> reduceActionForSimpleValue2: nodes [
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
		ifTrue: [ (nodes at: 1) trimBoth ]
		ifFalse: [ 
			(CZCompositeValue with: (nodes at: 1))
				addAll: ((nodes at: 2) collect: [ :subcoll | subcoll at: 2 ]);
				yourself ]
]

{ #category : #'generated-tables' }
CZBibParser >> reduceTable [
	^#(
#(14 0 #reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1:)
#(14 2 #reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2:)
#(15 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1:)
#(15 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2:)
#(15 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration3:)
#(16 3 #buildEntry:)
#(17 1 #reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX1:)
#(17 1 #reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX2:)
#(18 2 #reduceActionForCommentDeclaration1:)
#(19 1 #reduceFor:)
#(20 2 #reduceFor:)
#(21 0 #reduceActionForRepeatXXGroupXXXXXXXXXField1:)
#(21 2 #reduceActionForRepeatXXGroupXXXXXXXXXField2:)
#(22 2 #reduceActionForValue1:)
#(23 1 #reduceActionForSimpleValue1:)
#(23 1 #reduceActionForSimpleValue2:)
#(23 1 #reduceActionForSimpleValue3:)
#(23 1 #reduceActionForSimpleValue4:)
#(24 2 #reduceFor:)
#(25 0 #reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue1:)
#(25 2 #reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue2:)
#(26 3 #reduceActionForField1:)
#(27 2 #reduceActionForBodyContents1:)
#(30 1 #reduceActionForBibfile1:)
#(31 2 #buildMacro:)
)
]

{ #category : #'generated-tables' }
CZBibParser >> transitionTable [
	^#(
#[1 0 6 0 1 0 6 0 10 0 6 0 11 0 21 0 14 0 6 0 28 0 25 0 30]
#[1 0 6 0 1 0 6 0 10 0 6 0 11 0 21 0 14 0 6 0 28 0 29 0 30]
#[1 0 33 0 8 0 37 0 27]
#[1 0 41 0 8 0 45 0 26]
#[1 0 49 0 1 0 53 0 10 0 57 0 11 0 61 0 15 0 65 0 16 0 69 0 18 0 98 0 28 0 73 0 31]
#[0 0 0 0 28]
#[0 0 0 0 28]
#[1 0 50 0 2 0 77 0 21 0 50 0 28]
#[0 0 0 0 28]
#[0 0 81 0 4]
#[0 0 0 0 28]
#[0 0 85 0 8]
#[1 0 89 0 12 0 93 0 13 0 97 0 17]
#[1 0 89 0 12 0 93 0 13 0 101 0 17]
#[0 0 10 0 1 0 10 0 11 0 28]
#[0 0 22 0 1 0 10 0 11 0 28]
#[0 0 14 0 1 0 10 0 11 0 28]
#[0 0 18 0 1 0 10 0 11 0 28]
#[1 0 105 0 2 0 109 0 20 0 94 0 28]
#[1 0 113 0 7 0 117 0 8 0 121 0 9 0 125 0 12 0 129 0 22 0 133 0 23]
#[1 0 89 0 12 0 93 0 13 0 137 0 17]
#[0 0 34 0 1 0 10 0 11 0 28]
#[0 0 30 0 1 0 10 0 11 0 28]
#[0 0 102 0 1 0 10 0 11 0 28]
#[0 0 38 0 1 0 10 0 11 0 28]
#[1 0 141 0 8 0 145 0 26]
#[0 0 54 0 2 0 28]
#[0 0 70 0 3 0 28]
#[0 0 74 0 3 0 28]
#[0 0 62 0 3 0 28]
#[0 0 66 0 3 0 28]
#[0 0 90 0 28]
#[1 0 82 0 3 0 149 0 25 0 82 0 28]
#[0 0 26 0 1 0 10 0 11 0 28]
#[0 0 153 0 4]
#[0 0 46 0 2 0 28]
#[1 0 157 0 3 0 161 0 24 0 58 0 28]
#[1 0 165 0 7 0 169 0 8 0 173 0 9 0 177 0 12 0 181 0 22 0 185 0 23]
#[1 0 113 0 7 0 117 0 8 0 121 0 9 0 125 0 12 0 189 0 23]
#[0 0 86 0 3 0 28]
#[0 0 70 0 2 0 3 0 28]
#[0 0 74 0 2 0 3 0 28]
#[0 0 62 0 2 0 3 0 28]
#[0 0 66 0 2 0 3 0 28]
#[0 0 90 0 2 0 28]
#[1 0 82 0 2 0 82 0 3 0 193 0 25 0 82 0 28]
#[0 0 78 0 3 0 28]
#[1 0 58 0 2 0 197 0 3 0 201 0 24 0 58 0 28]
#[1 0 165 0 7 0 169 0 8 0 173 0 9 0 177 0 12 0 205 0 23]
#[0 0 86 0 2 0 3 0 28]
#[0 0 78 0 2 0 3 0 28]
)
]
