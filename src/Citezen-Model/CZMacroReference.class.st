Class {
	#name : #CZMacroReference,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZMacroReference >> expanded [
	"evaluation fixpoint"
	^ (self lookupMacroAt: value asSymbol) value
]
