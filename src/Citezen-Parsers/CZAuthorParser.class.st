"
Parser for the author or editor field, returning an OrderedCollection of CZAuthor instances.
The parsed syntax is the one described in the BibTeX documentation, i.e. ""and""-separated names, each name being of the form ""First Middle von Last"" or ""von Last, First Middle""; the latter form being the canonic and unambiguous one.
"
Class {
	#name : #CZAuthorParser,
	#superclass : #SmaCCParser,
	#category : #'Citezen-Parsers'
}

{ #category : #'generated-comments' }
CZAuthorParser class >> parserDefinitionComment [

	"authorList :
	author ( <and> author )*
		{ (OrderedCollection with: '1')
			addAll: ('2' collect: [:subcoll | subcoll at: 2]);
			yourself };

author :
	<name>+ ("","" <name>+ )? ("","" <name>+ )?
		{ #buildAuthor: };
"
]

{ #category : #'generated-accessing' }
CZAuthorParser class >> scannerClass [
	^CZAuthorScanner
]

{ #category : #'generated-starting states' }
CZAuthorParser class >> startingStateForauthorList [
	^1
]

{ #category : #'generated-comments' }
CZAuthorParser class >> symbolComment [

	"
1. "",""
2. <whitespace>
3. <and>
4. <name>
5. Repeat: Group:  | <and> author
6. authorList
7. author
8. Group:  | <and> author
9. Repeat Multiple: <name>
10. Group:  | "","" Repeat Multiple: <name>
11. Optional: Group:  | "","" Repeat Multiple: <name>
12. E O F
13. error
14. B e g i n
"
]

{ #category : #'private-building' }
CZAuthorParser >> buildAuthor: tokens [ 
	tokens second 
		ifNil: [^ CZAuthor named: (tokens first collect: [:each | each value])].
	tokens third ifNil: 
			[^ CZAuthor named: (tokens first collect: [:each | each value])
				firstNames: ((tokens second allButFirst: 1) collect: [:each | each value])].
	^ CZAuthor 
		named: (tokens first collect: [:each | each value])
		firstNames: ((tokens third allButFirst: 1) collect: [:each | each value])
		junior: ((tokens second allButFirst: 1) collect: [:each | each value])
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionForOptionalXXGroupXXXXXXXXXRepeatXMultipleXXXnameX1: nodes [
	^ nil
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionForOptionalXXGroupXXXXXXXXXRepeatXMultipleXXXnameX2: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionForRepeatXMultipleXXXnameX1: nodes [
	^ OrderedCollection with: (nodes at: 1)
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionForRepeatXMultipleXXXnameX2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionForRepeatXXGroupXXXXXXandXXauthor1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
CZAuthorParser >> reduceActionForRepeatXXGroupXXXXXXandXXauthor2: nodes [
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

{ #category : #'generated-tables' }
CZAuthorParser >> reduceTable [
	^#(
#(5 0 #reduceActionForRepeatXXGroupXXXXXXandXXauthor1:)
#(5 2 #reduceActionForRepeatXXGroupXXXXXXandXXauthor2:)
#(6 2 #reduceActionForauthorList1:)
#(7 3 #buildAuthor:)
#(8 2 #reduceFor:)
#(9 1 #reduceActionForRepeatXMultipleXXXnameX1:)
#(9 2 #reduceActionForRepeatXMultipleXXXnameX2:)
#(10 2 #reduceFor:)
#(11 0 #reduceActionForOptionalXXGroupXXXXXXXXXRepeatXMultipleXXXnameX1:)
#(11 1 #reduceActionForOptionalXXGroupXXXXXXXXXRepeatXMultipleXXXnameX2:)
#(14 1 #reduceFor:)
)
]

{ #category : #'generated-tables' }
CZAuthorParser >> transitionTable [
	^#(
#[1 0 9 0 4 0 13 0 6 0 17 0 7 0 21 0 9]
#[0 0 26 0 1 0 3 0 4 0 12]
#[0 0 0 0 12]
#[1 0 6 0 3 0 25 0 5 0 6 0 12]
#[1 0 29 0 1 0 38 0 3 0 33 0 4 0 37 0 10 0 41 0 11 0 38 0 12]
#[1 0 45 0 3 0 49 0 8 0 14 0 12]
#[1 0 9 0 4 0 53 0 9]
#[0 0 30 0 1 0 3 0 4 0 12]
#[0 0 42 0 1 0 3 0 12]
#[1 0 57 0 1 0 38 0 3 0 61 0 10 0 65 0 11 0 38 0 12]
#[1 0 9 0 4 0 69 0 7 0 21 0 9]
#[0 0 10 0 3 0 12]
#[1 0 34 0 1 0 34 0 3 0 33 0 4 0 34 0 12]
#[1 0 73 0 4 0 77 0 9]
#[0 0 42 0 3 0 12]
#[0 0 18 0 3 0 12]
#[0 0 22 0 3 0 12]
#[0 0 26 0 3 0 4 0 12]
#[1 0 34 0 3 0 81 0 4 0 34 0 12]
#[0 0 30 0 3 0 4 0 12]
)
]
