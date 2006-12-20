Class {
	#name : #PhraseTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
PhraseTest >> setUp [
	entry := (BibEntry type: #article)
		key: #foobar;
		at: #author put: 'A';
		at: #title put: 'T';
		at: #journal put: 'J';
		at: #year put: 'Y';
		yourself.
	phrase := BibSequencePhrase with: {
		BibFieldRef name: #author.
		BibFieldRef name: #title.
		BibFieldRef name: #journal.
		BibFieldRef name: #year.
	}.
	renderer := TextRenderer new
]

{ #category : #testing }
PhraseTest >> testPhrase [
	phrase renderEntry: entry using: renderer.
	self assert: renderer contents = 'ATJY'
]

{ #category : #testing }
PhraseTest >> testPhraseWithDecorations [
	phrase initiator: '[42] ';
		 terminator: '.';
		 separator: '; ';
		 lastSeparator: ', '.
	"not really correct use of the last separator, should be a separate phrase"
	phrase renderEntry: entry using: renderer.
	self assert: renderer contents = '[42] A; T; J, Y.'
]
