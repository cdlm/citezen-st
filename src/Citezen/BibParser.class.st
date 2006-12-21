Class {
	#name : #BibParser,
	#superclass : #SmaCCParser,
	#category : #'Citezen-Parsers'
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
	<name> ("","" Field)* { '1' value -> ('2' collect: [:each | each at: 2]) };

Field :
	<name> ""="" Value { BibField key: '1' value value: '3' };

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
	| <name> { '1' value };
"
]

{ #category : #'generated-accessing' }
BibParser class >> scannerClass [
	^BibScanner
]

{ #category : #'generated-starting states' }
BibParser class >> startingStateForBibfile [
	^2
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
	^ (BibEntry type: (tokens at: 2) value)
		key: body key;
		setFields: body value
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
	^ (nodes at: 1) value -> ((nodes at: 2) collect: [:each | each at: 2])
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForCommentDeclaration1: nodes [ 
	^ nil
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForField1: nodes [ 
	^ BibField key: (nodes at: 1) value value: (nodes at: 3)
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
	^ (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
BibParser >> reduceActionForValue1: nodes [ 
	^ (nodes at: 2) isEmpty 
		ifTrue: [nodes at: 1]
		ifFalse: 
			[(BibCompositeValue with: (nodes at: '1'))
				addAll: ((nodes at: '2') collect: [:subcoll | subcoll at: 2]);
				yourself]
]

{ #category : #'generated-tables' }
BibParser >> reduceTable [
	^#(
#(13 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1:)
#(13 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2:)
#(13 1 #reduceActionForGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration3:)
#(14 0 #reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration1:)
#(14 2 #reduceActionForRepeatXXGroupXXXXXCommentDeclarationXXXMacroDeclarationXXXEntryDeclaration2:)
#(15 3 #buildEntry:)
#(16 2 #buildMacro:)
#(17 1 #reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX1:)
#(17 1 #reduceActionForGroupXXXXXXparenthesizedStringXXXXXbracedStringX2:)
#(18 2 #reduceActionForCommentDeclaration1:)
#(19 3 #reduceActionForField1:)
#(20 2 #reduceFor:)
#(21 0 #reduceActionForRepeatXXGroupXXXXXXXXXField1:)
#(21 2 #reduceActionForRepeatXXGroupXXXXXXXXXField2:)
#(22 2 #reduceActionForValue1:)
#(23 1 #reduceActionForSimpleValue1:)
#(23 1 #reduceActionForSimpleValue2:)
#(23 1 #reduceActionForSimpleValue3:)
#(24 2 #reduceFor:)
#(25 0 #reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue1:)
#(25 2 #reduceActionForRepeatXXGroupXXXXXXXXXSimpleValue2:)
#(26 2 #reduceActionForBodyContents1:)
#(29 1 #reduceActionForBibfile1:)
#(30 1 #reduceFor:)
)
]

{ #category : #'generated-tables' }
BibParser >> transitionTable [
	^#(
#(3 18 1 18 9 18 10 21 14 18 27 25 29)
#(3 18 1 18 9 18 10 21 14 18 27 29 29)
#(3 33 7 37 26)
#(3 41 7 45 19)
#(3 49 1 53 9 57 10 61 13 65 15 69 16 73 18 94 27)
#(2 0 27)
#(2 0 27)
#(3 54 2 77 21 54 27)
#(2 0 27)
#(2 81 4)
#(2 0 27)
#(2 85 7)
#(3 89 11 93 12 97 17)
#(3 89 11 93 12 101 17)
#(2 22 1 9 10 27)
#(2 14 1 9 10 27)
#(2 10 1 9 10 27)
#(2 6 1 9 10 27)
#(3 105 2 109 20 90 27)
#(3 113 7 117 8 121 11 125 22 129 23)
#(3 89 11 93 12 133 17)
#(2 38 1 9 10 27)
#(2 34 1 9 10 27)
#(2 30 1 9 10 27)
#(2 42 1 9 10 27)
#(3 41 7 137 19)
#(2 58 2 27)
#(2 74 2 3 27)
#(2 66 2 3 27)
#(2 70 2 3 27)
#(2 46 2 27)
#(3 82 2 82 3 141 25 82 27)
#(2 26 1 9 10 27)
#(2 50 2 27)
#(3 62 2 145 3 149 24 62 27)
#(3 113 7 117 8 121 11 153 23)
#(2 86 2 3 27)
#(2 78 2 3 27)
)
]
