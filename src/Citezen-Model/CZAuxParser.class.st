Class {
	#name : #CZAuxParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'citations',
		'style',
		'databases'
	],
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-comments' }
CZAuxParser class >> parserDefinitionComment [

	"%id <bracedString> <citation> <bibcite> <bibstyle> <bibdata> <any>;
%start AuxFile;

AuxFile :
	#nothing
	| AuxFile Line
	| AuxFile (<newline>|<junk>|<name>) ;
	
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
CZAuxParser class >> scannerClass [
	^ CZAuxScanner
]

{ #category : #'generated-starting states' }
CZAuxParser class >> startingStateForAuxFile [
	^1
]

{ #category : #'private-building' }
CZAuxParser >> addCitation: aString [
	citations add: aString
]

{ #category : #'private-building' }
CZAuxParser >> addDatabase: aString [
	databases add: aString
]

{ #category : #'private-building' }
CZAuxParser >> addDatabases: aCollection [
	aCollection do: [:each | self addDatabase: each]
]

{ #category : #accessing }
CZAuxParser >> citations [
	^ citations
]

{ #category : #accessing }
CZAuxParser >> databases [
	^ databases
]

{ #category : #'initialize-release' }
CZAuxParser >> initialize [
	super initialize.
	citations := Bag new.
	databases := OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForDatabaseDeclaration1: nodes [ 
	^ self
		addDatabase: (nodes at: 3) value;
		addDatabases: ((nodes at: 4) collect: [:each | each second])
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForGroupXXXXXXnewlineXXXXXjunkXXXXXnameX1: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForGroupXXXXXXnewlineXXXXXjunkXXXXXnameX2: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForGroupXXXXXXnewlineXXXXXjunkXXXXXnameX3: nodes [ 
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForReferenceCitation1: nodes [ 
	^ self addCitation: (nodes at: 3) value
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForRepeatXXGroupXXXXXXXXXXnameX1: nodes [ 
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForRepeatXXGroupXXXXXXXXXXnameX2: nodes [ 
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForStyleDeclaration1: nodes [ 
	^ self style: (nodes at: 3) value
]

{ #category : #'generated-tables' }
CZAuxParser >> reduceTable [
	^#(
#(12 1 #reduceFor:)
#(12 1 #reduceFor:)
#(12 1 #reduceFor:)
#(12 1 #reduceFor:)
#(14 0 #reduceFor:)
#(14 2 #reduceFor:)
#(14 2 #reduceFor:)
#(15 1 #reduceActionForGroupXXXXXXnewlineXXXXXjunkXXXXXnameX1:)
#(15 1 #reduceActionForGroupXXXXXXnewlineXXXXXjunkXXXXXnameX2:)
#(15 1 #reduceActionForGroupXXXXXXnewlineXXXXXjunkXXXXXnameX3:)
#(16 1 #reduceFor:)
#(17 4 #reduceActionForReferenceCitation1:)
#(18 5 #reduceFor:)
#(19 4 #reduceActionForStyleDeclaration1:)
#(20 5 #reduceActionForDatabaseDeclaration1:)
#(21 2 #reduceFor:)
#(22 0 #reduceActionForRepeatXXGroupXXXXXXXXXXnameX1:)
#(22 2 #reduceActionForRepeatXXGroupXXXXXXXXXXnameX2:)
)
]

{ #category : #accessing }
CZAuxParser >> style [
	^ style
]

{ #category : #'private-building' }
CZAuxParser >> style: aString [
	style := aString
]

{ #category : #'generated-tables' }
CZAuxParser >> transitionTable [
	^#(
#(3 22 4 22 5 22 6 22 7 22 8 22 9 22 11 13 14 22 23)
#(3 22 4 22 5 22 6 22 7 22 8 22 9 22 11 17 14 22 23)
#(3 21 4 25 5 29 6 33 7 37 8 41 9 45 11 49 12 53 15 57 17 61 18 65 19 69 20 0 23)
#(3 21 4 25 5 29 6 33 7 37 8 41 9 45 11 49 12 53 15 57 17 61 18 65 19 69 20 0 23)
#(2 34 4 5 6 7 8 9 11 23)
#(2 42 4 5 6 7 8 9 11 23)
#(2 73 1)
#(2 77 1)
#(2 81 1)
#(2 85 1)
#(2 38 4 5 6 7 8 9 11 23)
#(2 26 4 5 6 7 8 9 11 23)
#(2 30 4 5 6 7 8 9 11 23)
#(2 6 4 5 6 7 8 9 11 23)
#(2 10 4 5 6 7 8 9 11 23)
#(2 14 4 5 6 7 8 9 11 23)
#(2 18 4 5 6 7 8 9 11 23)
#(2 89 5)
#(2 93 5)
#(2 97 5)
#(2 101 5)
#(2 105 2)
#(2 109 2)
#(2 113 2)
#(3 70 2 70 3 117 22)
#(2 50 4 5 6 7 8 9 11 23)
#(2 121 10)
#(2 58 4 5 6 7 8 9 11 23)
#(3 125 2 129 3 133 21)
#(2 54 4 5 6 7 8 9 11 23)
#(2 62 4 5 6 7 8 9 11 23)
#(2 137 5)
#(2 74 2 3)
#(2 66 2 3)
)
]
