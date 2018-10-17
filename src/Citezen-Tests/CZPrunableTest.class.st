Class {
	#name : #CZPrunableTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer',
		'visitor'
	],
	#category : 'Citezen-Tests'
}

{ #category : #setup }
CZPrunableTest >> setUp [
	entry := (CZEntry type: CZEntry article)
				key: #foobar;
				at: #author put: 'A';
				at: #title put: 'T';
				at: #journal put: 'J';
				at: #year put: 'Y';
				yourself.
	visitor := BibPhrasePrunableEvaluator new entry: entry
]

{ #category : #testing }
CZPrunableTest >> testAlternative [
	|result|
	phrase := BibAlternativePhrase new add: (BibLiteralPhrase text: 'foo')
			condition: [:anEntry | anEntry hasField: #author] .
	result := visitor visit: phrase.
	self deny: result. "not prunable"
	
	phrase := BibAlternativePhrase new add: (BibLiteralPhrase text: 'foo')
			condition: [:anEntry | anEntry hasField: #notexist] .
	result := visitor visit: phrase.
	self assert: result "not prunable"
]

{ #category : #testing }
CZPrunableTest >> testFieldRef [
	|result|
	phrase := BibFieldRef field: #author.
	result := visitor visit: phrase.
	self deny: result. "not prunable"
	
	phrase := BibFieldRef field: #notexisting.
	result := visitor visit: phrase.
	self assert: result "prunable"
]

{ #category : #testing }
CZPrunableTest >> testLiteral [
	|result|
	phrase := BibLiteralPhrase text: 'ABCD'.
	result := visitor visit: phrase.
	self deny: result. "not prunable"
]

{ #category : #testing }
CZPrunableTest >> testSequence [
	|result|
	phrase := BibSequencePhrase new addFields: #(year author).
	result := visitor visit: phrase.
	self deny: result. "not prunable"
	
	phrase := BibSequencePhrase new addFields: #(volume number month).
	result := visitor visit: phrase.
	self assert: result "prunable"

]
