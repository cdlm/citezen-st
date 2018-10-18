"
Parser for the author or editor field, returning an OrderedCollection of CZAuthor instances.
The parsed syntax is the one described in the BibTeX documentation, i.e. ""and""-separated names, each name being of the form ""First Middle von Last"" or ""von Last, First Middle""; the latter form being the canonic and unambiguous one.
"
Class {
	#name : #CZAuthorParser,
	#superclass : #SmaCCParser,
	#category : 'Citezen-Parsers'
}

{ #category : #'generated-accessing' }
CZAuthorParser class >> cacheId [
	^'2018-05-07T19:16:50.430012+02:00'
]

{ #category : #generated }
CZAuthorParser class >> definitionComment [
"#Definition extracted from old style definition comments
<whitespace>	:	[\s]*	;
<and>			:	a n d	;
<lump>			:	\{ [^}]* \}	;
<name>		:	(<lump> | [^\s,])+	;
	#[a-zA-Z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+ ;

authorList :
	author ( <and> author )*
		{ (OrderedCollection with: '1')
			addAll: ('2' collect: [:subcoll | subcoll at: 2]);
			yourself };

author :
	<name>+ ("","" <name>+  ("","" <name>+ )? )?
		{ #buildAuthor: };"
]

{ #category : #'generated-accessing' }
CZAuthorParser class >> scannerClass [
	^CZAuthorScanner
]

{ #category : #generated }
CZAuthorParser class >> startingStateForauthorList [
	^ 1
]

{ #category : #'private-building' }
CZAuthorParser >> buildAuthor: tokens [
	| names |
	names := tokens first collect: [ :each | each value ].
	^ tokens second
		ifNil: [ CZAuthor named: names ]
		ifNotNil: [ :second | 
			(ReadStream on: second) in: [ :input |
				| firstNames |
				input next.
				firstNames := OrderedCollection	streamContents: [ :s |
					| n |
					[ input atEnd
						or: [ (n := input next value) = ',' or: [ n isNil ] ] ]
						whileFalse: [ s nextPut: n ] ].
				input atEnd
					ifTrue: [ CZAuthor named: names firstNames: firstNames ]
					ifFalse: [ CZAuthor
						named: names
						firstNames: firstNames
						junior: (input upToEnd collect: [ :each | each value ]) ] ] ]
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionFor_______name__________name______2: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionFor___and__author__1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionFor_name__1: nodes [
	^ OrderedCollection with: (nodes at: 1)
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionFor_name__2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionForauthorList1: nodes [
	^ (OrderedCollection with: (nodes at: 1))
		addAll: ((nodes at: 2) collect: [ :subcoll | subcoll at: 2 ]);
		yourself
]

{ #category : #generated }
CZAuthorParser >> reduceTable [
^#(
	#(16 1 #reduceActionFor_name__1:) 
	#(5 0 #reduceActionFor___and__author__1:) 
	#(13 0 #nil) 
	#(6 2 #reduceActionForauthorList1:) 
	#(16 2 #reduceActionFor_name__2:) 
	#(13 1 #reduceActionFor_______name__________name______2:) 
	#(8 2 #buildAuthor:) 
	#(5 2 #reduceActionFor_name__2:) 
	#(11 0 #nil) 
	#(9 2 #reduceFor:) 
	#(11 1 #reduceActionFor_______name__________name______2:) 
	#(12 3 #reduceFor:) 
	#(10 2 #reduceFor:)
	).
]

{ #category : #generated }
CZAuthorParser >> symbolNames [
	^ #('","' '<whitespace>' '<and>' '<name>' '( <and> author)*' 'authorList' 'B e g i n' 'author' '( <and> author)' '( "," <name>+)' '( "," <name>+)?' '( "," <name>+ ( "," <name>+)?)' '( "," <name>+ ( "," <name>+)?)?' 'E O F' 'error' '<name>+')
]

{ #category : #generated }
CZAuthorParser >> transitionTable [
^#(
#[1 0 9 0 4 0 13 0 6 0 17 0 8 0 21 0 16] 
#[0 0 6 0 1 0 3 0 4 0 14] 
#[0 0 0 0 14] 
#[1 0 10 0 3 0 25 0 5 0 10 0 14] 
#[1 0 29 0 1 0 14 0 3 0 33 0 4 0 37 0 12 0 41 0 13 0 14 0 14] 
#[1 0 45 0 3 0 49 0 9 0 18 0 14] 
#[1 0 9 0 4 0 53 0 16] 
#[0 0 22 0 1 0 3 0 4 0 14] 
#[0 0 26 0 3 0 14] 
#[0 0 30 0 3 0 14] 
#[1 0 9 0 4 0 57 0 8 0 21 0 16] 
#[0 0 34 0 3 0 14] 
#[1 0 61 0 1 0 38 0 3 0 33 0 4 0 65 0 10 0 69 0 11 0 38 0 14] 
#[0 0 42 0 3 0 14] 
#[1 0 9 0 4 0 73 0 16] 
#[0 0 46 0 3 0 14] 
#[0 0 50 0 3 0 14] 
#[1 0 54 0 3 0 33 0 4 0 54 0 14]
	).
]
