Class {
	#name : #CZInteger,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZInteger class >> defaultValue [
	^ self with: 0
]

{ #category : #'as yet unclassified' }
CZInteger class >> fieldsOfThisFormat [
	^ #(year number volume edition)
]

{ #category : #'as yet unclassified' }
CZInteger >> acceptVisitor: aVisitor [
	aVisitor visitInteger: self
]

{ #category : #'as yet unclassified' }
CZInteger >> expanded [
	^ value asInteger
]
