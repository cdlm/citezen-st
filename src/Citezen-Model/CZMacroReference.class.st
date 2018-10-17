"
A CZMacroReference represent a reference to a macro defined in the BibTeX file.
"
Class {
	#name : #CZMacroReference,
	#superclass : #CZValue,
	#category : 'Citezen-Model'
}

{ #category : #visitor }
CZMacroReference >> acceptVisitor: aVisitor [
	aVisitor visitMacroReference: self
]

{ #category : #enumerating }
CZMacroReference >> do: aBlock [
	value do: aBlock 
]

{ #category : #accessing }
CZMacroReference >> expanded [
	"evaluation fixpoint"
	^ (self lookupMacroAt: value asLowercase asSymbol) value
]
