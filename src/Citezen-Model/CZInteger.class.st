Class {
	#name : #CZInteger,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZInteger class >> fieldsOfThisFormat [
	^ #(year number volume edition)
]

{ #category : #'as yet unclassified' }
CZInteger >> expanded [
	^ value asInteger
]
