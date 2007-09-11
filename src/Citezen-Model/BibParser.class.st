Class {
	#name : #BibParser,
	#superclass : #SmaCCParser,
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-comments' }
BibParser class >> parserDefinitionComment [

	"## See http://www.gerg.ca/software/btOOL/doc/bt_language.html

%id <bracedString> <parenthesizedString>;
%start Bibfile BodyContents Field;

## outer parser rules
Bibfile :
	(CommentDeclaration | MacroDeclaration | EntryDeclaration)*
		{ BibSet fromDeclarations: ('1' reject: [:it | it isNil]) };

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
	<name> ""="" Value { BibField key: '1' value asSymbol value: '3' };

Value :
	SimpleValue ( ""#"" SimpleValue )*
		{ '2' isEmpty
			ifTrue: [ '1' ]
			ifFalse: [(BibCompositeValue with: '1')
				addAll: ('2' collect: [:subcoll | subcoll at: 2]);
				yourself] };

SimpleValue :
	<quotedString> { '1' value allButFirst allButLast }
	| <bracedString> { '1' value allButFirst allButLast }
	| <number> { '1' value asNumber }
	| <name> { '1' value asSymbol };
"
]

{ #category : #'generated-accessing' }
BibParser class >> scannerClass [
	^BibScanner
]

{ #category : #'generated-starting states' }
BibParser class >> startingStateForBibfile [
	^1
]

{ #category : #'generated-starting states' }
BibParser class >> startingStateForBodyContents [
	^3
]

{ #category : #'generated-starting states' }
BibParser class >> startingStateForField [
	^4
]

{ #category : #'private-building' }
BibParser >> buildEntry: tokens [
	| body |
	body := BibParser
		parse: (tokens at: 3) value allButFirst allButLast
		startingAt: (self class startingStateForBodyContents).
	^ (BibEntry type: (tokens at: 2) value asSymbol)
		key: body key;
		addFields: body value
]

{ #category : #'private-building' }
BibParser >> buildMacro: tokens [
	^ BibParser
		parse: (tokens at: 2) value allButFirst allButLast
		startingAt: (self class startingStateForField)

]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForBibfile1: nodes [ 
	^ BibSet fromDeclarations: ((nodes at: 1) reject: [:it | it isNil])
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForBodyContents1: nodes [ 
	^ (nodes at: 1) value asSymbol 
		-> ((nodes at: 2) collect: [:each | each at: 2])
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForCommentDeclaration1: nodes [ 
	^ nil
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForField1: nodes [ 
	^ BibField key: (nodes at: 1) value asSymbol value: (nodes at: 3)
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration3: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX1: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX2: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1: nodes [ 
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2: nodes [ 
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForRepeatXXGroupXXXXXXXXXField1: nodes [ 
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForRepeatXXGroupXXXXXXXXXField2: nodes [ 
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue1: nodes [ 
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue2: nodes [ 
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForSimpleValue1: nodes [ 
	^ (nodes at: 1) value allButFirst allButLast
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForSimpleValue2: nodes [ 
	^ (nodes at: 1) value allButFirst allButLast
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForSimpleValue3: nodes [ 
	^ (nodes at: 1) value asNumber
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForSimpleValue4: nodes [ 
	^ (nodes at: 1) value asSymbol
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForValue1: nodes [ 
	^ (nodes at: 2) isEmpty 
		ifTrue: [nodes at: 1]
		ifFalse: 
			[(BibCompositeValue with: (nodes at: 1))
				addAll: ((nodes at: 2) collect: [:subcoll | subcoll at: 2]);
				yourself]
]

{ #category : #'generated-tables' }
BibParser >> reduceTable [
	^#(
#(14 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1:)
#(14 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2:)
#(14 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration3:)
#(15 1 #reduceFor:)
#(16 0 #reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1:)
#(16 2 #reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2:)
#(17 1 #reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX1:)
#(17 1 #reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX2:)
#(18 2 #buildMacro:)
#(19 2 #reduceActionForCommentDeclaration1:)
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
#(30 3 #buildEntry:)
#(31 1 #reduceActionForBibfile1:)
)
]

{ #category : #'generated-tables' }
BibParser >> transitionTable [
	^#(
#(3 22 1 22 10 22 11 21 16 22 28 25 31)
#(3 22 1 22 10 22 11 21 16 22 28 29 31)
#(3 33 8 37 27)
#(3 41 8 45 26)
#(3 49 1 53 10 57 11 61 14 65 18 69 19 102 28 73 30)
#(2 0 28)
#(2 0 28)
#(3 50 2 77 21 50 28)
#(2 0 28)
#(2 81 4)
#(2 0 28)
#(2 85 8)
#(3 89 12 93 13 97 17)
#(3 89 12 93 13 101 17)
#(2 26 1 10 11 28)
#(2 10 1 10 11 28)
#(2 6 1 10 11 28)
#(2 14 1 10 11 28)
#(3 105 2 109 20 94 28)
#(3 113 7 117 8 121 9 125 12 129 22 133 23)
#(3 89 12 93 13 137 17)
#(2 34 1 10 11 28)
#(2 30 1 10 11 28)
#(2 38 1 10 11 28)
#(2 42 1 10 11 28)
#(3 41 8 141 26)
#(2 54 2 28)
#(2 70 2 3 28)
#(2 74 2 3 28)
#(2 62 2 3 28)
#(2 66 2 3 28)
#(2 90 2 28)
#(3 82 2 82 3 145 25 82 28)
#(2 98 1 10 11 28)
#(2 46 2 28)
#(3 58 2 149 3 153 24 58 28)
#(3 113 7 117 8 121 9 125 12 157 23)
#(2 86 2 3 28)
#(2 78 2 3 28)
)
]
