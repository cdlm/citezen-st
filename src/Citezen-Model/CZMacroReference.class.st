"
A CZMacroReference represent a reference to a macro defined in the BibTeX file.
"
Class {
	#name : #CZMacroReference,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZMacroReference >> acceptVisitor: aVisitor [
	aVisitor visitMacroReference: self
]

{ #category : #'as yet unclassified' }
CZMacroReference >> do: aBlock [
	value do: aBlock 
]

{ #category : #'as yet unclassified' }
CZMacroReference >> expanded [
	"evaluation fixpoint"
	^ (self lookupMacroAt: value asLowercase asSymbol) value
]
