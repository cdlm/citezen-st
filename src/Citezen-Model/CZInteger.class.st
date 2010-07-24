"
A CZString represents an integer value in a BibTeX field.
"
Class {
	#name : #CZInteger,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #default }
CZInteger class >> defaultValue [
	^ self with: 0
]

{ #category : #default }
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
