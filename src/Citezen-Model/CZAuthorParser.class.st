"
Parser for the author or editor field, returning an OrderedCollection of CZAuthor instances.
The parsed syntax is the one described in the BibTeX documentation, i.e. ""and""-separated names, each name being of the form ""First Middle von Last"" or ""von Last, First Middle""; the latter form being the canonic and unambiguous one.
"
Class {
	#name : #CZAuthorParser,
	#superclass : #SmaCCParser,
	#category : 'Citezen-Parsers'
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
	^ CZAuthorScanner
]

{ #category : #'generated-starting states' }
CZAuthorParser class >> startingStateForauthorList [
	^1
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
		addAll: ((nodes at: 2) collect: [:subcoll | subcoll at: 2]);
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
#(3 9 4 13 6 17 7 21 9)
#(2 26 1 3 4 12)
#(2 0 12)
#(3 6 3 25 5 6 12)
#(3 29 1 38 3 33 4 37 10 41 11 38 12)
#(3 45 3 49 8 14 12)
#(3 9 4 53 9)
#(2 30 1 3 4 12)
#(2 42 1 3 12)
#(3 29 1 38 3 37 10 57 11 38 12)
#(3 9 4 61 7 21 9)
#(2 10 3 12)
#(3 34 1 34 3 33 4 34 12)
#(2 18 3 12)
#(2 22 3 12)
)
]
