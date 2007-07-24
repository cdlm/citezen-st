Class {
	#name : #BibEntry,
	#superclass : #Object,
	#instVars : [
		'type',
		'key',
		'fields'
	],
	#category : #'Citezen-Model'
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
	aCollection do: [:each |
		self
			at: each key asLowercase asSymbol
			put: each value]
]

{ #category : #bibset }
BibEntry >> addToBibSet: aBibSet [
	aBibSet addEntry: self ifDuplicate: [Error signal]

]

{ #category : #accessing }
BibEntry >> at: fieldName [
	^ fields at: fieldName
]

{ #category : #accessing }
BibEntry >> at: fieldName ifAbsent: aBlock [
	^ fields at: fieldName ifAbsent: aBlock
]

{ #category : #accessing }
BibEntry >> at: fieldName put: aValue [
	^ fields at: fieldName put: aValue
]

{ #category : #accessing }
BibEntry >> hasField: fieldName [
	^ fields includesKey: fieldName
]

{ #category : #'initialize-release' }
BibEntry >> initialize [
	fields := Dictionary new
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
