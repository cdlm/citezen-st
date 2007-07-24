Class {
	#name : #BibField,
	#superclass : #Object,
	#instVars : [
		'key',
		'value'
	],
	#category : #'Citezen-Model'
}

{ #category : #'instance creation' }
BibField class >> key: aSymbol value: aValue [
	^ self new setKey: aSymbol asLowercase asSymbol value: aValue
]

{ #category : #bibset }
BibField >> addToBibSet: aBibSet [
	aBibSet addMacro: self
]

{ #category : #accessing }
BibField >> key [
	^ key
]

{ #category : #'initialize-release' }
BibField >> setKey: aSymbol value: aValue [
	key := aSymbol.
	value := aValue
]

{ #category : #accessing }
BibField >> value [
	^ value
]
