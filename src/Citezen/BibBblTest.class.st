Class {
	#name : #BibBblTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibBblTest >> setUp [
	entry := (BibEntry type: #article)
		key: #foobar;
		at: #author put: 'A';
		at: #title put: 'T';
		at: #journal put: 'J';
		at: #year put: 'Y';
		yourself.
	phrase := BibPhraseLibrary article.
	renderer := (BibBblRenderer new)
]

{ #category : #testing }
BibBblTest >> testArticle [
	|result|
	renderer render: phrase for: entry.
	result := renderer contents.
	self assert: result = '\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, Y.

'
]

{ #category : #testing }
BibBblTest >> testSeveral [
	|result|
	renderer render: phrase for: entry.
	renderer render: phrase for: entry.
	result := renderer contents.
	self assert: result = '\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, Y.

\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, Y.

'
]
