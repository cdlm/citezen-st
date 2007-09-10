Class {
	#name : #BibRendererTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'renderer',
		'result'
	],
	#category : 'Citezen-Tests'
}

{ #category : #testing }
BibRendererTest class >> isAbstract [
	^ self == BibRendererTest
]

{ #category : #setup }
BibRendererTest >> rendererClass [
	self shouldBeImplemented
]

{ #category : #setup }
BibRendererTest >> setUp [
	entry := (BibEntry type: #article)
		key: #foobar;
		at: #author put: 'A';
		at: #title put: 'T';
		at: #journal put: 'J';
		at: #year put: 'Y';
		yourself.
	renderer := self rendererClass library: BibPhraseLibrary default
]

{ #category : #testing }
BibRendererTest >> testArticle [
	renderer render: entry.
	result := renderer contents.
]

{ #category : #testing }
BibRendererTest >> testSeveral [
	renderer render: entry.
	renderer render: entry.
	result := renderer contents.
]
