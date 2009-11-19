"
A CZBibSection is an element of the tree to be rendered. 
It can represent a latex Section or H1 Html section....


"
Class {
	#name : #CZBibRenderedSection,
	#superclass : #Object,
	#category : #'Citezen-Scripts'
}

{ #category : #'as yet unclassified' }
CZBibRenderedSection >> acceptVisitor: aVisitor [

	^ aVisitor acceptSection: self
]
