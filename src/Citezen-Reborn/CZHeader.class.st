"
May be not needed
"
Class {
	#name : #CZHeader,
	#superclass : #CZText,
	#category : #'Citezen-Reborn'
}

{ #category : #'as yet unclassified' }
CZHeader >> acceptVisitor: aVisitor [

	aVisitor visitHeader: self
]
