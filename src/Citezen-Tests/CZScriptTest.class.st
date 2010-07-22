Class {
	#name : #CZScriptTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset',
		'script',
		'document'
	],
	#category : #'Citezen-Tests'
}

{ #category : #running }
CZScriptTest >> setUp [
	bibset := CZBibParser parse: '
	@article{key1,
		author = {Barreau, Adrien},
		annote = {a},
		title = {article / key 1},
		year = 2000
	}
	
	@article{key2,
		author = {Barreau, Adrien},
		annote = {b},
		title = {article / key 2},
		year = 2002
	}
	
	@misc{key3,
		author = {Barreau, Adrien and Marcel, Robert},
		annote = {c},
		title = {misc / key 3},
		year = 2001
	}
	
	@misc{key4,
		author = {Barreau, Adrien and Marcel, Robert},
		annote = {d},
		title = {article},
		year = 2001
	}
	
	@misc{key5,
		author = {Chat, Le},
		annote = {choucroute},
		title = {Le chat aime la choucroute},
		year = 2001,
		note = {note}
	}
	'.
	
	document := CZDocument new bibsetInput: bibset; exportAsText 
]

{ #category : #RemoveTests }
CZScriptTest >> testBlackList [
	| generation |
	
	document addElement: (CZScript new blackList: #(key2 key3 key4 key5)).
	generation := document generate.
	
	self assert: generation = '- Adrien Barreau a article / key 1 2000'
]

{ #category : #SortTests }
CZScriptTest >> testDoubleSort [
	| generation |
	
	document addElement: (CZScript new sortByField: #year; sortByField: #title).
	generation := document generate.
	
	self assert: generation = 
'- Adrien Barreau a article / key 1 2000 

- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau and Robert Marcel d article 2001 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau b article / key 2 2002'

"sort is case-sensitive"
]

{ #category : #RemoveFieldsTests }
CZScriptTest >> testRemoveFields [
	| generation |
	
	document addElement: (CZScript new fieldsToRemove: #(author title)).
	generation := document generate.

	self assert: generation = 
'- a 2000 

- b 2002 

- c 2001 

- d 2001 

- choucroute 2001 note'
]

{ #category : #RemoveFieldsTests }
CZScriptTest >> testRemoveFieldsBadFields [
	| generation |
	
	document addElement: (CZScript new fieldsToRemove: #(BADFIELD author BADFIELD2)).
	generation := document generate.
	
	self assert: generation = 
'- a article / key 1 2000 

- b article / key 2 2002 

- c misc / key 3 2001 

- d article 2001 

- choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #SortTests }
CZScriptTest >> testReversedSortByField [
	| generation |
	
	document addElement: (CZScript new reversedSortByField: #year).
	generation := document generate.
	
	self assert: generation = 
'- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau a article / key 1 2000'

]

{ #category : #SortTests }
CZScriptTest >> testReversedSortByKey [
	| generation |
	
	document addElement: (CZScript new reversedSortByKey).
	generation := document generate.
	
	self assert: generation = 
'- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau and Robert Marcel d article 2001 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau a article / key 1 2000'
]

{ #category : #SortTests }
CZScriptTest >> testReversedSortByType [
	| generation |
	
	document addElement: (CZScript new reversedSortByType).
	generation := document generate.
	
	self assert: generation = 
'- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002'
]

{ #category : #SortTests }
CZScriptTest >> testSortByBadField [
	| generation |
	
	document addElement: (CZScript new sortByField: #BADFIELD).
	generation := document generate.
	
	self assert: generation = 
''

]

{ #category : #SortTests }
CZScriptTest >> testSortByField [
	| generation |
	
	document addElement: (CZScript new sortByField: #year).
	generation := document generate.
	
	self assert: generation = 
'- Adrien Barreau a article / key 1 2000 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau b article / key 2 2002'

]

{ #category : #SortTests }
CZScriptTest >> testSortByFieldNotContainedByAllEntries [
	| generation |
	
	document addElement: (CZScript new sortByField: #note).
	generation := document generate.
	
	self assert: generation = 
'- Le Chat choucroute Le chat aime la choucroute 2001 note'

]

{ #category : #SortTests }
CZScriptTest >> testSortByKey [
	| generation |
	
	document addElement: (CZScript new sortByKey).
	generation := document generate.
	
	self assert: generation = 
'- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #SortTests }
CZScriptTest >> testSortByType [
	| generation |
	
	document addElement: (CZScript new sortByType).
	generation := document generate.
	
	self assert: generation = 
'- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #DisplayOrderTests }
CZScriptTest >> testTypeOrderDisplayingBadOrder [
	| generation |
	
	document addElement: (CZScript new displayOrder: #(BADTYPE misc BADTYPE2)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #DisplayOrderTests }
CZScriptTest >> testTypeOrderDisplayingWithWildcard [
	| generation |
	
	document addElement: (CZScript new displayOrder: #(misc *)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002'
]

{ #category : #DisplayOrderTests }
CZScriptTest >> testTypeOrderDisplayingWithoutWildcard [
	| generation |
	
	document addElement: (CZScript new displayOrder: #(article)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002'
]

{ #category : #RemoveTests }
CZScriptTest >> testWithDisplayPattern [
	| generation |
	
	document addElement: (CZScript new displayPattern: (CZDisplayPattern new defaultSeparator: ', ')).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau, a, article / key 1, 2000 

- Adrien Barreau, b, article / key 2, 2002 

- Adrien Barreau and Robert Marcel, c, misc / key 3, 2001 

- Adrien Barreau and Robert Marcel, d, article, 2001 

- Le Chat, choucroute, Le chat aime la choucroute, 2001, note'

"More display pattern tests in CZDisplayPatternTest"
]

{ #category : #RemoveTests }
CZScriptTest >> testWithQuery [
	| generation |
	
	document addElement: (CZScript new query: (CZFieldQuery named: #year checks: [ :each | each = 2001])).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'

"More query tests in CZQueryTest"
]
