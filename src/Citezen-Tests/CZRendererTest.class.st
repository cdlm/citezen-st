Class {
	#name : #CZRendererTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'renderer',
		'result',
		'entry2'
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
				key: #Duca10a;
				at: #author put: 'St\''ephane Ducasse and Damien Pollet';
				at: #title put: 'Fingerprints';
				at: #journal put: 'Journal of Information System';
				at: #year put: '2010';
				yourself.
	entry2 := (CZEntry type: #article)
				key: #Duca10a;
				at: #author put: 'Ducasse, St\''ephane  and Pollet, Damien';
				at: #title put: 'Fingerprints';
				at: #journal put: 'Journal of Information System';
				at: #year put: '2010';
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
	renderer render: entry2.
	result := renderer contents.
]
