Class {
	#name : #BibEvaluableField,
	#superclass : #BibField,
	#category : 'Citezen-Model'
}

{ #category : #accessing }
BibEvaluableField >> displayValue [
	^ value isSymbol "else it's a BibCompositeValue"
		ifTrue: [(self lookupMacroAt: value) value "evaluation fixpoint"]
		ifFalse: [self notYetImplemented]
]
