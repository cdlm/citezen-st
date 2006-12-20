Class {
	#name : #BibPhrase,
	#superclass : #Object,
	#category : #'Citezen-Rendering'
}

{ #category : #templating }
BibPhrase >> renderEntry: anEntry using: aRenderer [
	self subclassResponsibility
]
