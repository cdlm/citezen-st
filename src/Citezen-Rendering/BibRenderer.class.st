Class {
	#name : #BibRenderer,
	#superclass : #BibPhraseVisitor,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibRenderer >> render: anObject [
	self visit: anObject
]

{ #category : #rendering }
BibRenderer >> render: aPhrase for: anEntry [
	entry := anEntry.
	self visit: aPhrase
]

{ #category : #'visiting-phrases' }
BibRenderer >> visitAlternativePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each] for: entry
]

{ #category : #'visiting-bibsets' }
BibRenderer >> visitEntry: anEntry [
	self render: (self phraseFor: anEntry) for: anEntry
]

{ #category : #'visiting-phrases' }
BibRenderer >> visitSequencePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each] for: entry
]
