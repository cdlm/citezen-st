"
A CZComment is simply to represent comments in documents
"
Class {
	#name : #CZComment,
	#superclass : #CZText,
	#category : #'Citezen-Reborn'
}

{ #category : #visiting }
CZComment >> acceptVisitor: aVisitor [

	aVisitor visitComment: self
]
