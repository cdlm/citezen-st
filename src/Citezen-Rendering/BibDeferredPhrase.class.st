"
A Phrase which uses a block to control what is rendered. This is useful when the phrase depends on multiple parts of an entry.
"
Class {
	#name : #BibDeferredPhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'aBlock'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibDeferredPhrase class >> block: aBlock [
	^ self new
		block: aBlock;
		yourself
]

{ #category : #'visitor-double dispatch' }
BibDeferredPhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitDeferredPhrase: self
]

{ #category : #accessing }
BibDeferredPhrase >> block [
	^ aBlock
]

{ #category : #accessing }
BibDeferredPhrase >> block: anObject [
	aBlock := anObject
]
