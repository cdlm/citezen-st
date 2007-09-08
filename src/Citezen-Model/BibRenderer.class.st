"
Quick test:

	Transcript show: ((BibHtmlRenderer library: BibPhraseLibrary default)
		render: (BibParser parse: BibTestResource myBibFile)) contents.

"
Class {
	#name : #BibRenderer,
	#superclass : #BibVisitor,
	#instVars : [
		'library',
		'currentEntry'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibRenderer class >> library: aPhraseLibrary [
	^ self new
		library: aPhraseLibrary;
		yourself
]

{ #category : #accessing }
BibRenderer >> library [
	^ library
]

{ #category : #accessing }
BibRenderer >> library: aPhraseLibrary [
	library := aPhraseLibrary
]

{ #category : #accessing }
BibRenderer >> phraseFor: anEntry [
	^ self library phraseFor: anEntry
]

{ #category : #rendering }
BibRenderer >> render: anObject [
	self visit: anObject
]

{ #category : #rendering }
BibRenderer >> render: aPhrase for: anEntry [
	currentEntry := anEntry.
	self visit: aPhrase
]

{ #category : #'visiting-phrases' }
BibRenderer >> visitAlternativePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each] for: currentEntry
]

{ #category : #'visiting-bibsets' }
BibRenderer >> visitEntry: anEntry [
	self render: (self phraseFor: anEntry) for: anEntry
]

{ #category : #'visiting-phrases' }
BibRenderer >> visitSequencePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each] for: currentEntry
]
