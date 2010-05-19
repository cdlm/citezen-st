Class {
	#name : #CZCommentElement,
	#superclass : #Object,
	#instVars : [
		'comment'
	],
	#category : #'Citezen-Script'
}

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
