"
Parser for LaTeX's .aux files, collecting citations marks, as well as the used databases and style. The parser stores a Bag of cited entry keys, an OrderedCollection of databases names and a single style; ask for those after parsing.

Limitations:
 - Some LaTeX classes or packages redefine the format of citations in the .aux file so this will probably break for such files;
 - this parser relies on side effects during the (linear) parsing to collect data in its own instance variables, which is probably not very robust if the grammar needs backtracks (compared to functional aggregation like proper attributed grammars).
"
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

{ #category : #'generated-accessing' }
CZAuxParser class >> cacheId [
	^'2018-05-07T19:12:13.269248+02:00'
]

{ #category : #generated }
CZAuxParser class >> definitionComment [
"#Definition extracted from old style definition comments
<newline>		:	\r \n | \n | \r	;
<name>			:	[A-Za-z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+	;

<citation>		:	\\ citation	;
<bibcite>			:	\\ bibcite	;
<bibstyle>		:	\\ bibstyle	;
<bibdata>		:	\\ bibdata	;

# tokens parsed by code
<bracedString>	:	\{	;
<junk>			:	.	;
%id <bracedString> <citation> <bibcite> <bibstyle> <bibdata> <any>;
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
			addDatabases: (names collect: [:each | each second]) };"
]

{ #category : #'generated-accessing' }
CZAuxParser class >> scannerClass [
	^CZAuxScanner
]

{ #category : #generated }
CZAuxParser class >> startingStateForAuxFile [
	^ 1
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
		addDatabases: ((nodes at: 4) collect: [ :each | each second ])
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForReferenceCitation1: nodes [
	^ self addCitation: (nodes at: 3) value
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionForStyleDeclaration1: nodes [
	^ self style: (nodes at: 3) value
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionFor_______name___1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionFor_______name___2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZAuxParser >> reduceActionFor___newline___junk___name__1: nodes [
	^ nodes at: 1
]

{ #category : #generated }
CZAuxParser >> reduceTable [
^#(
	#(14 0 #reduceFor:) 
	#(15 1 #reduceActionFor___newline___junk___name__1:) 
	#(14 2 #reduceFor:) 
	#(12 1 #reduceFor:) 
	#(22 0 #reduceActionFor_______name___1:) 
	#(17 4 #reduceActionForReferenceCitation1:) 
	#(19 4 #reduceActionForStyleDeclaration1:) 
	#(18 5 #reduceFor:) 
	#(20 5 #reduceActionForDatabaseDeclaration1:) 
	#(22 2 #reduceActionFor_______name___2:) 
	#(21 2 #reduceFor:)
	).
]

{ #category : #accessing }
CZAuxParser >> style [
	^ style
]

{ #category : #'private-building' }
CZAuxParser >> style: aString [
	style := aString
]

{ #category : #generated }
CZAuxParser >> symbolNames [
	^ #('"{"' '"}"' '","' '<newline>' '<name>' '<citation>' '<bibcite>' '<bibstyle>' '<bibdata>' '<bracedString>' '<junk>' 'Line' '<any>' 'AuxFile' '( <newline> <junk> <name>)' 'B e g i n' 'ReferenceCitation' 'ReferenceDefinition' 'StyleDeclaration' 'DatabaseDeclaration' '( "," <name>)' '( "," <name>)*' 'E O F' 'error')
]

{ #category : #generated }
CZAuxParser >> transitionTable [
^#(
#[1 0 6 0 4 0 6 0 5 0 6 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 11 0 9 0 14 0 6 0 23] 
#[1 0 13 0 4 0 17 0 5 0 21 0 6 0 25 0 7 0 29 0 8 0 33 0 9 0 37 0 11 0 41 0 12 0 45 0 15 0 49 0 17 0 53 0 18 0 57 0 19 0 61 0 20 0 0 0 23] 
#[0 0 10 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 10 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 65 0 1] 
#[0 0 69 0 1] 
#[0 0 73 0 1] 
#[0 0 77 0 1] 
#[0 0 10 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 14 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 14 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 18 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 18 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 18 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 18 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 81 0 5] 
#[0 0 85 0 5] 
#[0 0 89 0 5] 
#[0 0 93 0 5] 
#[0 0 97 0 2] 
#[0 0 101 0 2] 
#[0 0 105 0 2] 
#[1 0 22 0 2 0 22 0 3 0 109 0 22] 
#[0 0 26 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 113 0 10] 
#[0 0 30 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[1 0 117 0 2 0 121 0 3 0 125 0 21] 
#[0 0 34 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 38 0 4 0 5 0 6 0 7 0 8 0 9 0 11 0 23] 
#[0 0 129 0 5] 
#[0 0 42 0 2 0 3] 
#[0 0 46 0 2 0 3]
	).
]
