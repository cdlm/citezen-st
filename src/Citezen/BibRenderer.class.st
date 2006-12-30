Class {
	#name : #BibRenderer,
	#superclass : #BibPhraseVisitor,
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibRenderer >> render: aPhrase for: anEntry [
	|evaluatedPhrase|
	evaluatedPhrase := BibPhraseEvaluator evaluate: aPhrase for: anEntry.
	evaluatedPhrase ifNil: [^ self].
	self visit: evaluatedPhrase
]
