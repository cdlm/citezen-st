Class {
	#name : #BibPhraseEvaluator,
	#superclass : #BibPhraseVisitor,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibPhraseEvaluator class >> evaluate: aPhrase for: anEntry [
	^ self new entry: anEntry; visit: aPhrase
]

{ #category : #accessing }
BibPhraseEvaluator >> entry: anEntry [
	entry := anEntry
]

{ #category : #'visitor-double dispatch' }
BibPhraseEvaluator >> visitFieldRef: aFieldRef [
	|value|
	value := entry at: aFieldRef fieldName ifAbsent: [^ nil].
	^ BibLiteralPhrase text: value
]

{ #category : #'visitor-double dispatch' }
BibPhraseEvaluator >> visitLiteralPhrase: aPhrase [
	^ aPhrase
]

{ #category : #'visitor-double dispatch' }
BibPhraseEvaluator >> visitSequencePhrase: aPhrase [
	|subPhrases|
	subPhrases := OrderedCollection new.
	aPhrase subPhrases do: [:each |
		(self visit: each) ifNotNilDo: [:it | subPhrases add: it]].
	subPhrases ifEmpty: [^ nil].
	^ (BibSequencePhrase with: subPhrases)
		initiator: (aPhrase initiatorDo: [:it | self visit: it]);
		separator: (aPhrase separatorDo: [:it | self visit: it]);
		lastSeparator: (aPhrase internalLastSeparator ifNotNilDo: [:it | self visit: it]);
		terminator: (aPhrase terminatorDo: [:it | self visit: it])
]
