"
A bibliographic entry representing a single document or unit published work.
"
Class {
	#name : #CZEntry,
	#superclass : #CZScoped,
	#instVars : [
		'type',
		'key',
		'fields'
	],
	#category : 'Citezen-Model'
}

{ #category : #'instance creation' }
CZEntry class >> type: entryType [
	^ self new type: entryType; yourself
]

{ #category : #'visitor-double dispatch' }
CZEntry >> acceptVisitor: aVisitor [
	^ aVisitor visitEntry: self
]

{ #category : #accessing }
CZEntry >> addFields: aCollection [
	fields addAll: aCollection.
	aCollection do: [:each | each scope: self]

]

{ #category : #bibset }
CZEntry >> addToBibSet: aBibSet [
	aBibSet addEntry: self
]

{ #category : #accessing }
CZEntry >> at: fieldName [
	^ self at: fieldName ifAbsent: [nil]
]

{ #category : #accessing }
CZEntry >> at: fieldName ifAbsent: aBlock [
	| index |
	index := fields findFirst: [:each | each key = fieldName].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [fields at: index]
]

{ #category : #accessing }
CZEntry >> at: fieldName put: aValue [ 
	fields removeAllSuchThat: [:each | each key = fieldName].
	fields add: ((CZField key: fieldName value: aValue)
				scope: self;
				yourself)
]

{ #category : #enumerating }
CZEntry >> do: aBlock [
	fields do: aBlock
]

{ #category : #accessing }
CZEntry >> hasField: fieldName [
	^ fields anySatisfy: [:each | each key = fieldName]
]

{ #category : #'initialize-release' }
CZEntry >> initialize [
	fields := OrderedCollection new
]

{ #category : #accessing }
CZEntry >> key [
	^ key
]

{ #category : #accessing }
CZEntry >> key: aKey [
	key := aKey
]

{ #category : #accessing }
CZEntry >> macroReferences [
	"returns all fields of this entry that have a macro as value"
	^ fields select: [:each | each rawValue isSymbol]
]

{ #category : #accessing }
CZEntry >> size [
	^ fields size
]

{ #category : #accessing }
CZEntry >> type [
	^ type
]

{ #category : #'initialize-release' }
CZEntry >> type: aType [
	type := aType
]
