Class {
	#name : #CZField,
	#superclass : #CZScoped,
	#instVars : [
		'key',
		'value'
	],
	#category : #'Citezen-Model'
}

{ #category : #'instance creation' }
CZField class >> key: aSymbol value: aValue [
	^ self new setKey: aSymbol asLowercase asSymbol value: aValue
]

{ #category : #bibset }
CZField >> addToBibSet: aBibSet [
	aBibSet addMacro: self
]

{ #category : #accessing }
CZField >> displayValue [
	self flag: 'maybe expand curlies and TeX accents here'.
	^ self value
]

{ #category : #accessing }
CZField >> key [
	^ key
]

{ #category : #'initialize-release' }
CZField >> setKey: aSymbol value: aValue [
	key := aSymbol.
	value := aValue
]

{ #category : #accessing }
CZField >> value [
	^ value
]
