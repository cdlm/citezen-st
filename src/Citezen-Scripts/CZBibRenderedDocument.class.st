Class {
	#name : #CZBibRenderedDocument,
	#superclass : #Object,
	#category : #'Citezen-Scripts'
}

{ #category : #'as yet unclassified' }
CZBibRenderedDocument >> acceptVisitor: aVisitor [

	^ aVisitor acceptDocument: self
]
