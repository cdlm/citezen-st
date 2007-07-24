Class {
	#name : #BibField,
	#superclass : #Association,
	#category : #'Citezen-Model'
}

{ #category : #bibset }
BibField >> addToBibSet: aBibSet [
	aBibSet addMacro: self ifDuplicate: [Error signal]
]
