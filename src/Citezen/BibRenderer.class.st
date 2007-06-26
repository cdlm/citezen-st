Class {
	#name : #BibRenderer,
	#superclass : #BibPhraseVisitor,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibRenderer >> render: aPhrase for: anEntry [
	entry := anEntry.
	self visit: aPhrase
]

{ #category : #'visitor-double dispatch' }
BibRenderer >> visitAlternativePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each] for: entry
]

{ #category : #'visitor-double dispatch' }
BibRenderer >> visitSequencePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each] for: entry
]
