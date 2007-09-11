Class {
	#name : #BibEntry,
	#superclass : #BibStructure,
	#instVars : [
		'type',
		'key',
		'fields'
	],
	#category : 'Citezen-Model'
}

{ #category : #'instance creation' }
BibEntry class >> type: entryType [
	^ self new type: entryType; yourself
]

{ #category : #'visitor-double dispatch' }
BibEntry >> acceptVisitor: aVisitor [
	^ aVisitor visitEntry: self
]

{ #category : #accessing }
BibEntry >> addFields: aCollection [
	fields do: [:each | each scope: self].
	fields addAll: aCollection
]

{ #category : #bibset }
BibEntry >> addToBibSet: aBibSet [
	aBibSet addEntry: self
]

{ #category : #accessing }
BibEntry >> at: fieldName [
	^ self at: fieldName ifAbsent: [nil]
]

{ #category : #accessing }
BibEntry >> at: fieldName ifAbsent: aBlock [
	| index |
	index := fields findFirst: [:each | each key = fieldName].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [(fields at: index) value]
]

{ #category : #accessing }
BibEntry >> at: fieldName put: aValue [
	fields removeAllSuchThat: [:each | each key = fieldName].
	fields add: ((BibField key: fieldName value: aValue) scope: self; yourself)
]

{ #category : #enumerating }
BibEntry >> do: aBlock [
	fields do: aBlock
]

{ #category : #accessing }
BibEntry >> hasField: fieldName [
	^ fields anySatisfy: [:each | each key = fieldName]
]

{ #category : #'initialize-release' }
BibEntry >> initialize [
	fields := OrderedCollection new
]

{ #category : #accessing }
BibEntry >> key [
	^ key
]

{ #category : #accessing }
BibEntry >> key: aKey [
	key := aKey
]

{ #category : #accessing }
BibEntry >> macroReferences [
	"returns all fields of this entry that have a macro as value"
	^ fields select: [:each | each value isSymbol]
]

{ #category : #accessing }
BibEntry >> size [
	^ fields size
]

{ #category : #accessing }
BibEntry >> type [
	^ type
]

{ #category : #'initialize-release' }
BibEntry >> type: aType [
	type := aType
]
