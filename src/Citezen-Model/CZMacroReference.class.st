Class {
	#name : #CZMacroReference,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZMacroReference >> do: aBlock [
	value do: aBlock 
]

{ #category : #'as yet unclassified' }
CZMacroReference >> expanded [
	"evaluation fixpoint"
	^ (self lookupMacroAt: value asLowercase asSymbol) value
]
