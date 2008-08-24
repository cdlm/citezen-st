Class {
	#name : #CZRendererTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'renderer',
		'result'
	],
	#category : #'Citezen-Tests'
}

{ #category : #testing }
CZRendererTest class >> isAbstract [
	^ self == CZRendererTest
]

{ #category : #setup }
CZRendererTest >> rendererClass [
	self shouldBeImplemented
]

{ #category : #setup }
CZRendererTest >> setUp [
	entry := (CZEntry type: #article)
				key: #foobar;
				at: #author put: 'A';
				at: #title put: 'T';
				at: #journal put: 'J';
				at: #year put: 'Y';
				yourself.
	renderer := self rendererClass library: BibPhraseLibrary default
]

{ #category : #testing }
CZRendererTest >> testArticle [
	renderer render: entry.
	result := renderer contents.
]

{ #category : #testing }
CZRendererTest >> testSeveral [
	renderer render: entry.
	renderer render: entry.
	result := renderer contents.
]
