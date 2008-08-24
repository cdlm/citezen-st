Class {
	#name : #CZString,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZString >> expanded [
	^ value asString reject: [ :each | each = ${ or: [ each = $} ] ]
]
