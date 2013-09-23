"
May be not needed
"
Class {
	#name : #CZHeader,
	#superclass : #CZText,
	#category : #'Citezen-Reborn'
}

{ #category : #visiting }
CZHeader >> acceptVisitor: aVisitor [

	aVisitor visitHeader: self
]
