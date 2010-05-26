Class {
	#name : #CZString,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZString class >> defaultValue [
	^ self with: ''
]

{ #category : #'as yet unclassified' }
CZString >> acceptVisitor: aVisitor [
	aVisitor visitString: self
]

{ #category : #'as yet unclassified' }
CZString >> expanded [
	^ value asString reject: [ :each | each = ${ or: [ each = $} ] ]
]
