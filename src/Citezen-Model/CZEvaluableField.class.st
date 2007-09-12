Class {
	#name : #CZEvaluableField,
	#superclass : #CZField,
	#category : #'Citezen-Model'
}

{ #category : #accessing }
CZEvaluableField >> displayValue [
	^ value isSymbol "else it's a BibCompositeValue"
		ifTrue: [(self lookupMacroAt: value) value "evaluation fixpoint"]
		ifFalse: [self notYetImplemented]
]
