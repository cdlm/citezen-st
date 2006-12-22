Class {
	#name : #BibPhraseTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibPhraseTest >> setUp [
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
	renderer := BibTextRenderer new
]

{ #category : #testing }
BibPhraseTest >> testPhrase [
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJY'
]

{ #category : #testing }
BibPhraseTest >> testPhraseWithDecorations [
	phrase initiatorText: '[42] ';
		 terminatorText: '.';
		 separatorText: '; ';
		 lastSeparatorText: ', '.
	"not really correct use of the last separator, should be a separate phrase"
	renderer render: phrase for: entry.
	self assert: renderer contents = '[42] A; T; J, Y.'
]
