Class {
	#name : #BibField,
	#superclass : #Association,
	#category : #Citezen
}

{ #category : #bibset }
BibField >> addToBibSet: aBibSet [
	aBibSet addMacro: self ifDuplicate: [Error signal]
]
