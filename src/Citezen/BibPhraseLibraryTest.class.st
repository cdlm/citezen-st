Class {
	#name : #BibPhraseLibraryTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer',
		'rendererBib',
		'phraseBib'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibPhraseLibraryTest >> setUp [
	entry := (BibEntry type: #article)
		key: #foobar;
		at: #url put: 'U';
		at: #keywords put: 'K';
		at: #fire put: 'F';
		at: #water put: 'W';
		yourself.
	phrase := BibPhraseLibrary bibarticle.
	renderer := (BibBblRenderer new)
]

{ #category : #testing }
BibPhraseLibraryTest >> testNewBblPhrase [
	|result|
	renderer render: phrase for: entry.
	result := renderer contents.
	self assert: result = '\bibitem[displayKey]{foobar}
U!? 
\newblock K!? 
\newblock W| F...

'
]
