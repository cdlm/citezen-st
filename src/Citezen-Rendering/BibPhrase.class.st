"
BibPhrase and subclasses specify how to present bibliography objects, independently from the actual output format, while adapting to missing data.

Presentation handled by phrases includes selection and order of data, plus human-centered decorations like punctuation.
"
Class {
	#name : #BibPhrase,
	#superclass : #Object,
	#category : #'Citezen-Rendering'
}

{ #category : #'visitor-double dispatch' }
BibPhrase >> acceptVisitor: aVisitor [
	^ self subclassResponsibility
]

{ #category : #convenience }
BibPhrase >> blockNamed: aString [ 
	^ BibNamedPhrase blockNamed: aString with: self
]

{ #category : #convenience }
BibPhrase >> named: aString [ 
	^ BibNamedPhrase named: aString with: self
]
