"
The superclass for visitors of Citezen objects.
"
Class {
	#name : #BibPhraseVisitor,
	#superclass : #Object,
	#category : #'Citezen-Rendering'
}

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
BibPhraseVisitor >> visitDeferredPhrase: aBibDeferredPhrase [ 
]

{ #category : #'visiting-bibsets' }
BibPhraseVisitor >> visitEntry: anEntry [
	anEntry do: [:each | self visit: each]
]

{ #category : #'visiting-bibsets' }
BibPhraseVisitor >> visitField: aField [
	"do nothing"
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitFieldRef: aPhrase [
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitLiteralPhrase: aPhrase [
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitNamedPhrase: aPhrase [ 
	^ self visit: aPhrase subphrase
]

{ #category : #'visiting-phrases' }
BibPhraseVisitor >> visitSequencePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each]
]
