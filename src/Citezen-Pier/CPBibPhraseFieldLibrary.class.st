"
Unlike the BibPhraseLibrary class, I am an object that extracts a specific field from an entry.

The field to extract is an instance variable, so all my methods are on the instance side, not the class side.

"
Class {
	#name : #CPBibPhraseFieldLibrary,
	#superclass : #Object,
	#instVars : [
		'fieldSelector'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance creation' }
CPBibPhraseFieldLibrary class >> forField: aFieldSelector [
	^ self new initializeFieldSelector: aFieldSelector
]

{ #category : #querying }
CPBibPhraseFieldLibrary >> defaultLibrary [
	^ BibPhraseLibrary
]

{ #category : #querying }
CPBibPhraseFieldLibrary >> formatFor: aCZField [ 
	^ self defaultLibrary formatFor: aCZField 
]

{ #category : #initialization }
CPBibPhraseFieldLibrary >> initializeFieldSelector: aFieldSelector [
	fieldSelector := aFieldSelector

]

{ #category : #querying }
CPBibPhraseFieldLibrary >> phraseFor: aCZEntry [
	| selector |
	selector := aCZEntry type.
	^ self phraseForField named: selector
]

{ #category : #querying }
CPBibPhraseFieldLibrary >> phraseForField [
	^ (BibSequencePhrase new)
		addBlockWithField: fieldSelector
]
