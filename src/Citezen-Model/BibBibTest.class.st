Class {
	#name : #BibBibTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibBibTest >> setUp [
	entry := (BibEntry type: #article)
		key: #foobar;
		at: #author put: 'A';
		at: #title put: 'T';
		at: #journal put: 'J';
		at: #year put: 'Y';
		yourself.
	phrase := BibPhraseLibrary phraseFor: entry.
	renderer := (BibBibRenderer new)
]

{ #category : #testing }
BibBibTest >> testArticle [
	|result|
	renderer render: phrase for: entry.
	result := renderer contents.
	self assert: result = '@article(foobar,
author = {A},
title = {T},
journal = {J},
year = Y
)

'
]

{ #category : #testing }
BibBibTest >> testSeveral [
	|result|
	renderer render: phrase for: entry.
	renderer render: phrase for: entry.
	result := renderer contents.
	self assert: result = '@article(foobar,
author = {A},
title = {T},
journal = {J},
year = Y
)

@article(foobar,
author = {A},
title = {T},
journal = {J},
year = Y
)

'
]
