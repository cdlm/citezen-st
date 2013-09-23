"
A BibPhrasePrunableEvaluator will visit a (partial) phrase to determine if it is prunable or not for the given entry. ""Prunable"" means the phrase will be empty once evaluated with the data from this entry. 
"
Class {
	#name : #BibPhrasePrunableEvaluator,
	#superclass : #BibPhraseVisitor,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibPhrasePrunableEvaluator class >> evaluate: aPhrase for: anEntry [
	^ self new entry: anEntry; visit: aPhrase
]

{ #category : #accessing }
BibPhrasePrunableEvaluator >> entry: anEntry [
	entry := anEntry
]

{ #category : #'visitor-double dispatch' }
BibPhrasePrunableEvaluator >> visitAlternativePhrase: aPhrase [ 
	^ (aPhrase subPhraseFor: entry) ifNil: [true] ifNotNil: [false]
]

{ #category : #'visitor-double dispatch' }
BibPhrasePrunableEvaluator >> visitDeferredPhrase: aDeferredPhrase [
	^ aDeferredPhrase block isNil 
]

{ #category : #'visitor-double dispatch' }
BibPhrasePrunableEvaluator >> visitFieldRef: aFieldRef [
	^ (entry hasField: aFieldRef fieldName) not
]

{ #category : #'visitor-double dispatch' }
BibPhrasePrunableEvaluator >> visitLiteralPhrase: aPhrase [
	^ false
]

{ #category : #'visitor-double dispatch' }
BibPhrasePrunableEvaluator >> visitSequencePhrase: aPhrase [ 
	^ aPhrase subphrases allSatisfy: [:each | self visit: each]
]
