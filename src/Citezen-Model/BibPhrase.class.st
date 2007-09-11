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
BibPhrase >> named: aString [
	^ BibBlockPhrase named: aString with: self
]
