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
BibPhraseTest >> testEvaluation [
	| result |
	result := BibPhraseEvaluator evaluate: phrase for: entry.
	self assert: result subPhrases size = 4.
	self assert: result subPhrases first text = 'A'.
	self assert: result subPhrases second text = 'T'.
	self assert: result subPhrases third text = 'J'.
	self assert: result subPhrases fourth text = 'Y'
]

{ #category : #testing }
BibPhraseTest >> testEvaluationWithMissingField [
	|result|
	phrase add: (BibFieldRef name: #month). "fifth field"
	result := BibPhraseEvaluator evaluate: phrase for: entry.
	self assert: result subPhrases size = 4.
	self assert: result subPhrases last text = 'Y'
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
	phrase add: (BibFieldRef name: #month).
	renderer render: phrase for: entry.
	self assert: renderer contents = 'ATJY'
]
