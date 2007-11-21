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
CZField >> key [
	^ key
]

{ #category : #accessing }
CZField >> rawValue [
	^ value
]

{ #category : #'initialize-release' }
CZField >> setKey: aSymbol value: aValue [
	key := aSymbol.
	value := aValue.
	value scope: self
]

{ #category : #accessing }
CZField >> value [
	| expandedValue |
	expandedValue := value isSymbol
		ifTrue: [(self lookupMacroAt: value) value "evaluation fixpoint"]
		ifFalse: [value value "evaluate CZCompositeValues"].
	expandedValue isString
		ifTrue: [expandedValue := expandedValue reject: [:each | each = ${ or: [each = $}]]].
	^ expandedValue
]
