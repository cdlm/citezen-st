Class {
	#name : #BibAlternativePhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'predicate',
		'subPhrases'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'visitor-double dispatch' }
BibAlternativePhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitAlternativePhrase: self
]
