Class {
	#name : #CZPhraseTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
CZPhraseTest >> setUp [
	entry := (CZEntry type: #article)
				key: #foobar;
				at: #author put: 'A';
				at: #title put: 'T';
				at: #journal put: 'J';
				at: #year put: '4';
				yourself.
	phrase := BibSequencePhrase with: { 
						(BibFieldRef field: #author).
						(BibFieldRef field: #title).
						(BibFieldRef field: #journal).
						(BibFieldRef field: #year)}.
	renderer := BibTextRenderer new
]

{ #category : #testing }
CZPhraseTest >> testAlternate [
	phrase add:
		(BibAlternativePhrase new
			add: (BibLiteralPhrase text: 'foo')
			condition: [:anEntry | anEntry hasField: #bar]).
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJ4'.
	entry at: #bar put: #whatever.
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJ4ATJ4foo'
]

{ #category : #testing }
CZPhraseTest >> testLibraryArticle [
	renderer render: BibPhraseLibrary article for: entry.
	self assert: renderer contents = 'A. T. In J, 4.'
]

{ #category : #testing }
CZPhraseTest >> testRender [
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJ4'
]

{ #category : #testing }
CZPhraseTest >> testRenderWithDecorations [
	phrase
		initiatorText: '[42] ';
		terminatorText: '.';
		separatorText: '; ';
		lastSeparatorText: ', '.
	renderer render: phrase for: entry.
	self assert: renderer contents = '[42] A; T; J, 4.'
]

{ #category : #testing }
CZPhraseTest >> testRenderWithMissingField [
	phrase add: (BibFieldRef field: #month).
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJ4'
]
