"
CZCommentElement represent a comment in the output file.
Its representation depends on the output you choose.

CZCommentElement newComment: 'Here is my comment'.
can be reprensented by: 
- xHTML -> '<!-- Here is my comment -->'
- BibTeX -> '@comment{Here is my comment}'
"
Class {
	#name : #CZCommentElement,
	#superclass : #Object,
	#instVars : [
		'comment'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZCommentElement class >> newComment: aString [
	^ self new comment: aString 
]

{ #category : #'as yet unclassified' }
CZCommentElement >> acceptVisitor: aVisitor [
	aVisitor visitComment: self
]

{ #category : #'as yet unclassified' }
CZCommentElement >> comment [
	^ comment
]

{ #category : #'as yet unclassified' }
CZCommentElement >> comment: aString [
	(aString isNil)
		ifFalse: [ comment := aString ]
		ifTrue: [ comment := self undefinedString ]
]

{ #category : #'as yet unclassified' }
CZCommentElement >> initialize [
	comment := self undefinedString
]

{ #category : #'as yet unclassified' }
CZCommentElement >> undefinedString [
	^ 'UNDEFINED COMMENT'
]
