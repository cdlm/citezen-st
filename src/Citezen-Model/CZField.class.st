"
Name / Value pair used as a single field of a bibliographic entry, or as the declaration of a macro.
"
Class {
	#name : #CZField,
	#superclass : #CZScoped,
	#instVars : [
		'key',
		'value'
	],
	#classInstVars : [
		'valueClasses'
	],
	#category : #'Citezen-Model'
}

{ #category : #'instance creation' }
CZField class >> initializeValueClasses [
	valueClasses := Dictionary new.
	CZValue withAllSubclassesDo:
		[:each | each fieldsOfThisFormat do:
			[:field | valueClasses at: field put: each ]].
	^ valueClasses
]

{ #category : #'instance creation' }
CZField class >> key: aSymbol rawValue: valueFromParser [
	"have to test it, because there is no syntax to detect an author (example :)
		@type{key,
			author = {Barreau, Adrien}, -> should be CZPeople
			title = {Acomma, astring}   -> should be CZString}"

	(#(author editor) includes: aSymbol asLowercase) 
		ifTrue: [
			^ self 
				key: aSymbol 
				value: ((CZPeople new) setValue: valueFromParser )].
	
	^ self new
		setKey: aSymbol asLowercase asSymbol
		rawValue: valueFromParser
]

{ #category : #'instance creation' }
CZField class >> key: aSymbol value: aValue [
	^ self new
		setKey: aSymbol asLowercase asSymbol
		value: aValue
]

{ #category : #'instance creation' }
CZField class >> undefined: aSymbol [
	^ CZUndefinedField
		key: aSymbol
		value: ("valueClasses at: aSymbol ifAbsent: ["CZValue) defaultValue
]

{ #category : #'instance creation' }
CZField class >> valueClasses [
	^ valueClasses ifNil: [self initializeValueClasses]
]

{ #category : #'as yet unclassified' }
CZField >> acceptVisitor: aVisitor [
	aVisitor visitField: self
]

{ #category : #bibset }
CZField >> addToBibSet: aBibSet [
	aBibSet addMacro: self
]

{ #category : #'as yet unclassified' }
CZField >> dispatchVisitor: aVisitor [
	value acceptVisitor: aVisitor 
]

{ #category : #'as yet unclassified' }
CZField >> equalsButDifferent: aField [
	(self == aField) ifTrue: [ ^ false ].
	^ (self key = aField key) & (self rawValue = aField rawValue)
]

{ #category : #accessing }
CZField >> isUndefined [
	^ false
]

{ #category : #accessing }
CZField >> key [
	^ key
]

{ #category : #printing }
CZField >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self key;
		nextPut: $=.
	self rawValue printOn: aStream.
	aStream nextPut: $)
]

{ #category : #accessing }
CZField >> rawValue [
	^ value notExpanded
]

{ #category : #'initialize-release' }
CZField >> setKey: aSymbol rawValue: valueFromParser [
	key := aSymbol.
"	value := self valueClass with: valueFromParser. "
	value := ((valueFromParser isKindOf: Number) 
			ifTrue: [CZInteger] 
			ifFalse: [CZString]) 
		with: valueFromParser.
	value scope: self
]

{ #category : #'initialize-release' }
CZField >> setKey: aSymbol value: czValue [
	key := aSymbol.
	value := czValue.
	value scope: self
]

{ #category : #accessing }
CZField >> value [
	"evaluate macros and composite values, and cleanup strings"
	^ value expanded
]

{ #category : #accessing }
CZField >> valueClass [
	^ self class valueClasses
		at: self key
		ifAbsent: [CZString]
]
