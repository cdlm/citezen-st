Class {
	#name : #CZDisplayPatternTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset',
		'document'
	],
	#category : #'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> setUp [
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

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testBeginsWith [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new
				beginsWith: ' --> ')).
	generation := document generate.

	self assert: generation = 
'- --> Adrien Barreau a article / key 1 2000 

- --> Adrien Barreau b article / key 2 2002 

- --> Adrien Barreau and Robert Marcel c misc / key 3 2001 

- --> Adrien Barreau and Robert Marcel d article 2001 

- --> Le Chat choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testBeginsWithAndEndsWith [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				beginsWith: ' --> '; 
				endsWith: ' <--')).
	generation := document generate.

	self assert: generation = 
'- --> Adrien Barreau a article / key 1 2000 <--

- --> Adrien Barreau b article / key 2 2002 <--

- --> Adrien Barreau and Robert Marcel c misc / key 3 2001 <--

- --> Adrien Barreau and Robert Marcel d article 2001 <--

- --> Le Chat choucroute Le chat aime la choucroute 2001 note <--'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testCompletePattern [
	| generation |
		document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new
				beginsWith: ' --> author: ';
				field: #author;
				separator: '; annote: ';
				field: #annote;
				separator: '; title: ';
				field: #title;
				separator: '; year: ';
				field: #year;
				separator: '; note: ';
				field: #note;
				endsWith: ' <--')).
	generation := document generate.

	self assert: generation = 
'- --> author: Adrien Barreau; annote: a; title: article / key 1; year: 2000 <--

- --> author: Adrien Barreau; annote: b; title: article / key 2; year: 2002 <--

- --> author: Adrien Barreau and Robert Marcel; annote: c; title: misc / key 3; year: 2001 <--

- --> author: Adrien Barreau and Robert Marcel; annote: d; title: article; year: 2001 <--

- --> author: Le Chat; annote: choucroute; title: Le chat aime la choucroute; year: 2001; note: note <--'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testDefaultSeparator [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				defaultSeparator: '; ')).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau; a; article / key 1; 2000 

- Adrien Barreau; b; article / key 2; 2002 

- Adrien Barreau and Robert Marcel; c; misc / key 3; 2001 

- Adrien Barreau and Robert Marcel; d; article; 2001 

- Le Chat; choucroute; Le chat aime la choucroute; 2001; note'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testDoubleDefaultSeparator [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
			defaultSeparator: '*^^*'; 
			field: #year; 
			field: #note;
			defaultSeparator: '^**^'; 
			field: #*)).
	generation := document generate.

	self assert: generation = 
'- 2000*^^*Adrien Barreau^**^a^**^article / key 1 

- 2002*^^*Adrien Barreau^**^b^**^article / key 2 

- 2001*^^*Adrien Barreau and Robert Marcel^**^c^**^misc / key 3 

- 2001*^^*Adrien Barreau and Robert Marcel^**^d^**^article 

- 2001*^^*note^**^Le Chat^**^choucroute^**^Le chat aime la choucroute'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testDoubleSeparator [
	| generation |
		document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new
				field: #author;
				separator: ' ***';
				separator: '*** ';
				field: #*)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau ****** a article / key 1 2000 

- Adrien Barreau ****** b article / key 2 2002 

- Adrien Barreau and Robert Marcel ****** c misc / key 3 2001 

- Adrien Barreau and Robert Marcel ****** d article 2001 

- Le Chat ****** choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testEndsWith [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				endsWith: ' <--')).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau a article / key 1 2000 <--

- Adrien Barreau b article / key 2 2002 <--

- Adrien Barreau and Robert Marcel c misc / key 3 2001 <--

- Adrien Barreau and Robert Marcel d article 2001 <--

- Le Chat choucroute Le chat aime la choucroute 2001 note <--'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testField [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				field: #author)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau 

- Adrien Barreau 

- Adrien Barreau and Robert Marcel 

- Adrien Barreau and Robert Marcel 

- Le Chat'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testFieldWildcard [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				field: #year; 
				field: #*)).
	generation := document generate.

	self assert: generation = 
'- 2000 Adrien Barreau a article / key 1 

- 2002 Adrien Barreau b article / key 2 

- 2001 Adrien Barreau and Robert Marcel c misc / key 3 

- 2001 Adrien Barreau and Robert Marcel d article 

- 2001 Le Chat choucroute Le chat aime la choucroute note'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testFields [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				field: #author; 
				field: #year)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau 2000 

- Adrien Barreau 2002 

- Adrien Barreau and Robert Marcel 2001 

- Adrien Barreau and Robert Marcel 2001 

- Le Chat 2001'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testFieldsWildcard [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				field: #note; 
				field: #year; 
				field: #*)).
	generation := document generate.

	self assert: generation = 
'- 2000 Adrien Barreau a article / key 1 

- 2002 Adrien Barreau b article / key 2 

- 2001 Adrien Barreau and Robert Marcel c misc / key 3 

- 2001 Adrien Barreau and Robert Marcel d article 

- note 2001 Le Chat choucroute Le chat aime la choucroute'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testSeparator [
	| generation |
		document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new
				field: #author;
				separator: ' *** ';
				field: #*)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau *** a article / key 1 2000 

- Adrien Barreau *** b article / key 2 2002 

- Adrien Barreau and Robert Marcel *** c misc / key 3 2001 

- Adrien Barreau and Robert Marcel *** d article 2001 

- Le Chat *** choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testSeparators [
	| generation |
		document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new
				field: #author;
				separator: ' *** ';
				field: #year;
				separator: ' *^* ';
				field: #*)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau *** 2000 *^* a article / key 1 

- Adrien Barreau *** 2002 *^* b article / key 2 

- Adrien Barreau and Robert Marcel *** 2001 *^* c misc / key 3 

- Adrien Barreau and Robert Marcel *** 2001 *^* d article 

- Le Chat *** 2001 *^* choucroute Le chat aime la choucroute note'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testWildcard [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				field: #*)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testWildcardField [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				field: #*; 
				field: #annote)).
	generation := document generate.

	self assert: generation = 
'- Adrien Barreau article / key 1 2000 a 

- Adrien Barreau article / key 2 2002 b 

- Adrien Barreau and Robert Marcel misc / key 3 2001 c 

- Adrien Barreau and Robert Marcel article 2001 d 

- Le Chat Le chat aime la choucroute 2001 note choucroute'
]

{ #category : #'as yet unclassified' }
CZDisplayPatternTest >> testWildcardFields [
	| generation |
	
	document addElement: (
		CZScript new displayPattern: (
			CZDisplayPattern new 
				field: #*; 
				field: #annote; 
				field: #author)).
	generation := document generate.

	self assert: generation = 
'- article / key 1 2000 a Adrien Barreau 

- article / key 2 2002 b Adrien Barreau 

- misc / key 3 2001 c Adrien Barreau and Robert Marcel 

- article 2001 d Adrien Barreau and Robert Marcel 

- Le chat aime la choucroute 2001 note choucroute Le Chat'
]