Class {
	#name : #BibAuxParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'citations',
		'style',
		'databases'
	],
	#category : #'Citezen-Parsers'
}

{ #category : #'generated-comments' }
BibAuxParser class >> parserDefinitionComment [

	"%id <bracedString> <citation> <bibcite> <bibstyle> <bibdata> <any>;
%start AuxFile;

AuxFile :
	#nothing
	| Line
	| AuxFile <newline> Line
	| AuxFile <newline> <junk>+ ;
	
Line :
	ReferenceCitation
	| ReferenceDefinition
	| StyleDeclaration
	| DatabaseDeclaration ;

ReferenceCitation :
	<citation> ""{"" <name> 'key' ""}"" { self addCitation: key value };

ReferenceDefinition : # not sure we care about this one
	<bibcite> ""{"" <name> ""}"" <bracedString> ;

StyleDeclaration :
	<bibstyle> ""{"" <name> 'style' ""}"" { self style: style value };

DatabaseDeclaration :
	<bibdata> ""{"" <name> 'name' ( "","" <name> )* 'names' ""}""
		{ self addDatabase: name value;
			addDatabases: (names collect: [:each | each second]) };
"
]

{ #category : #'generated-accessing' }
BibAuxParser class >> scannerClass [
	^BibAuxScanner
]

{ #category : #'generated-starting states' }
BibAuxParser class >> startingStateForAuxFile [
	^2
]

{ #category : #'private-building' }
BibAuxParser >> addCitation: aString [
	citations add: aString
]

{ #category : #'private-building' }
BibAuxParser >> addDatabase: aString [
	databases add: aString
]

{ #category : #'private-building' }
BibAuxParser >> addDatabases: aCollection [
	aCollection do: [:each | self addDatabase: each]
]

{ #category : #'initialize-release' }
BibAuxParser >> initialize [
	super initialize.
	citations := Bag new.
	databases := OrderedCollection new
]

{ #category : #'generated-reduction actions' }
BibAuxParser >> reduceActionForDatabaseDeclaration1: nodes [ 
	^ self
		addDatabase: (nodes at: 3) value;
		addDatabases: ((nodes at: 4) collect: [:each | each second])
]

{ #category : #'generated-reduction actions' }
BibAuxParser >> reduceActionForReferenceCitation1: nodes [ 
	^ self addCitation: (nodes at: 3) value
]

{ #category : #'generated-reduction actions' }
BibAuxParser >> reduceActionForRepeatXMultipleXXXjunkX1: nodes [ 
	^ OrderedCollection with: (nodes at: 1)
]

{ #category : #'generated-reduction actions' }
BibAuxParser >> reduceActionForRepeatXMultipleXXXjunkX2: nodes [ 
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
BibAuxParser >> reduceActionForRepeatXXGroupXXXXXXXXXXnameX1: nodes [ 
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
BibAuxParser >> reduceActionForRepeatXXGroupXXXXXXXXXXnameX2: nodes [ 
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
BibAuxParser >> reduceActionForStyleDeclaration1: nodes [ 
	^ self style: (nodes at: 3) value
]

{ #category : #'generated-tables' }
BibAuxParser >> reduceTable [
	^#(
#(12 0 #reduceFor:)
#(12 1 #reduceFor:)
#(12 3 #reduceFor:)
#(12 3 #reduceFor:)
#(14 1 #reduceActionForRepeatXMultipleXXXjunkX1:)
#(14 2 #reduceActionForRepeatXMultipleXXXjunkX2:)
#(15 1 #reduceFor:)
#(16 4 #reduceActionForReferenceCitation1:)
#(17 5 #reduceFor:)
#(18 4 #reduceActionForStyleDeclaration1:)
#(19 5 #reduceActionForDatabaseDeclaration1:)
#(20 1 #reduceFor:)
#(20 1 #reduceFor:)
#(20 1 #reduceFor:)
#(20 1 #reduceFor:)
#(21 2 #reduceFor:)
#(22 0 #reduceActionForRepeatXXGroupXXXXXXXXXXnameX1:)
#(22 2 #reduceActionForRepeatXXGroupXXXXXXXXXXnameX2:)
)
]

{ #category : #'private-building' }
BibAuxParser >> style: aString [
	style := aString
]

{ #category : #'generated-tables' }
BibAuxParser >> transitionTable [
	^#(
#(3 6 4 13 6 17 7 21 8 25 9 29 12 33 16 37 17 41 18 45 19 49 20 6 23)
#(3 6 4 13 6 17 7 21 8 25 9 53 12 33 16 37 17 41 18 45 19 49 20 6 23)
#(2 57 1)
#(2 61 1)
#(2 65 1)
#(2 69 1)
#(3 73 4 0 23)
#(2 50 4 23)
#(2 54 4 23)
#(2 58 4 23)
#(2 62 4 23)
#(2 10 4 23)
#(3 73 4 0 23)
#(2 77 5)
#(2 81 5)
#(2 85 5)
#(2 89 5)
#(3 13 6 17 7 21 8 25 9 93 11 97 14 33 16 37 17 41 18 45 19 101 20)
#(2 105 2)
#(2 109 2)
#(2 113 2)
#(3 70 2 70 3 117 22)
#(2 22 4 11 23)
#(3 18 4 121 11 18 23)
#(2 14 4 23)
#(2 34 4 23)
#(2 125 10)
#(2 42 4 23)
#(3 129 2 133 3 137 21)
#(2 26 4 11 23)
#(2 38 4 23)
#(2 46 4 23)
#(2 141 5)
#(2 74 2 3)
#(2 66 2 3)
)
]
