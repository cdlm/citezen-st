Class {
	#name : #BibPhraseVisitor,
	#superclass : #Object,
	#instVars : [
		'library'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibPhraseVisitor class >> library: aPhraseLibrary [
	^ self new
		library: aPhraseLibrary;
		yourself
]

{ #category : #accessing }
BibPhraseVisitor >> library [
	^ library
]

{ #category : #accessing }
BibPhraseVisitor >> library: aPhraseLibrary [
	library := aPhraseLibrary
]

{ #category : #'as yet unclassified' }
BibPhraseVisitor >> phraseFor: anEntry [
	^ self library phraseFor: anEntry
]

{ #category : #visiting }
BibPhraseVisitor >> visit: anObject [
	^ anObject acceptVisitor: self
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitAlternativePhrase: aPhrase [ 
	"walk everywhere by default"
	^ aPhrase do: [:each | self visit: each]
]

{ #category : #'visiting-bibsets' }
BibPhraseVisitor >> visitBibSet: aBibSet [
	aBibSet do: [:each | self visit: each]
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitBlockPhrase: aBlockPhrase [
	^ self visit: aBlockPhrase subphrase

]

{ #category : #'visiting-bibsets' }
BibPhraseVisitor >> visitEntry: anEntry [
	self visit: (self phraseFor: anEntry)
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitFieldRef: aPhrase [
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitLiteralPhrase: aPhrase [
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitSequencePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each]
]
