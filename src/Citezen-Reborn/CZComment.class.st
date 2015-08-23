"
A CZComment is simply to represent comments in documents
"
Class {
	#name : #CZComment,
	#superclass : #CZText,
	#category : #'Citezen-Reborn-DocModel'
}

{ #category : #visiting }
CZComment >> acceptVisitor: aVisitor [

	aVisitor visitComment: self
]
