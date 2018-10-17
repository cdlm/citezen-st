"
May be not needed
"
Class {
	#name : #CZFooter,
	#superclass : #CZText,
	#category : 'Citezen-Reborn-DocModel'
}

{ #category : #visiting }
CZFooter >> acceptVisitor: aVisitor [

	aVisitor visitFooter: self
]
