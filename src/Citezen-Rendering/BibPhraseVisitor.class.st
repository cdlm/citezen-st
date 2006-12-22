Class {
	#name : #BibPhraseVisitor,
	#superclass : #Object,
	#category : #'Citezen-Rendering'
}

{ #category : #visiting }
BibPhraseVisitor >> visit: anObject [
	^ anObject acceptVisitor: self
]

{ #category : #'visitor-double dispatch' }
BibPhraseVisitor >> visitAlternativePhrase: aPhrase [
	"walk everywhere by default"
	^ aPhrase subPhrases do: [:each | self visit: each]
]

{ #category : #'visitor-double dispatch' }
BibPhraseVisitor >> visitFieldRef: aPhrase [
]

{ #category : #'visitor-double dispatch' }
BibPhraseVisitor >> visitLiteralPhrase: aPhrase [
]

{ #category : #'visitor-double dispatch' }
BibPhraseVisitor >> visitSequencePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each]
]
