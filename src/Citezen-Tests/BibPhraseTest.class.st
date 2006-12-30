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
		BibFieldRef field: #author.
		BibFieldRef field: #title.
		BibFieldRef field: #journal.
		BibFieldRef field: #year.
	}.
	renderer := BibTextRenderer new
]

{ #category : #testing }
BibPhraseTest >> testAlternate [
	phrase add:
		(BibAlternativePhrase new
			add: (BibLiteralPhrase text: 'foo')
			condition: [:anEntry | anEntry hasField: #bar]).
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJY'.
	entry at: #bar put: #whatever.
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJYATJYfoo'
]

{ #category : #testing }
BibPhraseTest >> testEvaluation [
	| result |
	result := BibPhraseEvaluator evaluate: phrase for: entry.
	self assert: result subphrases size = 4.
	self assert: result subphrases first text = 'A'.
	self assert: result subphrases second text = 'T'.
	self assert: result subphrases third text = 'J'.
	self assert: result subphrases fourth text = 'Y'
]

{ #category : #testing }
BibPhraseTest >> testEvaluationWithMissingField [
	| result |
	phrase add: (BibFieldRef field: #month).
	result := BibPhraseEvaluator evaluate: phrase for: entry.
	self assert: result subphrases size = 4.
	self assert: result subphrases last text = 'Y'
]

{ #category : #testing }
BibPhraseTest >> testLibraryArticle [
	renderer render: BibPhraseLibrary article for: entry.
	self assert: renderer contents = 'A. T. In J, Y.'
]

{ #category : #testing }
BibPhraseTest >> testRender [
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJY'
]

{ #category : #testing }
BibPhraseTest >> testRenderWithDecorations [
	phrase
		initiatorText: '[42] ';
		terminatorText: '.';
		separatorText: '; ';
		lastSeparatorText: ', '.
	renderer render: phrase for: entry.
	self assert: renderer contents = '[42] A; T; J, Y.'
]

{ #category : #testing }
BibPhraseTest >> testRenderWithMissingField [
	phrase add: (BibFieldRef field: #month).
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJY'
]
