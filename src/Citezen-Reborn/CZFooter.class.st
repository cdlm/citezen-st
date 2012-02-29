"
May be not needed
"
Class {
	#name : #CZFooter,
	#superclass : #CZText,
	#category : #'Citezen-Reborn'
}

{ #category : #visiting }
CZFooter >> acceptVisitor: aVisitor [

	aVisitor visitFooter: self
]
