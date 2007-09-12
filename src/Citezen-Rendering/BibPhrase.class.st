Class {
	#name : #BibPhrase,
	#superclass : #Object,
	#category : 'Citezen-Rendering'
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
