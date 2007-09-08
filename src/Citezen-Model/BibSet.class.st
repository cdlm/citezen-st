Class {
	#name : #BibSet,
	#superclass : #BibStructure,
	#instVars : [
		'macros',
		'entries'
	],
	#category : #'Citezen-Model'
}

{ #category : #'instance creation' }
BibSet class >> fromDeclarations: declarations [
	|instance|
	instance := self new.
	declarations do: [:each | each addToBibSet: instance].
	^ instance
]

{ #category : #'instance creation' }
BibSet class >> months [
	^ self new
		addMacro: (BibField key: 'jan' value: 'January');
		addMacro: (BibField key: 'feb' value: 'February');
		addMacro: (BibField key: 'mar' value: 'March');
		addMacro: (BibField key: 'apr' value: 'April');
		addMacro: (BibField key: 'may' value: 'May');
		addMacro: (BibField key: 'jun' value: 'June');
		addMacro: (BibField key: 'jul' value: 'July');
		addMacro: (BibField key: 'aug' value: 'August');
		addMacro: (BibField key: 'sep' value: 'September');
		addMacro: (BibField key: 'oct' value: 'October');
		addMacro: (BibField key: 'nov' value: 'November');
		addMacro: (BibField key: 'dec' value: 'December');
		yourself
]

{ #category : #'visitor-double dispatch' }
BibSet >> acceptVisitor: aVisitor [
	^ aVisitor visitBibSet: self
]

{ #category : #adding }
BibSet >> addEntry: anEntry [
	anEntry scope: self.
	entries add: anEntry
]

{ #category : #adding }
BibSet >> addMacro: aField [
	aField scope: self.
	macros add: aField
]

{ #category : #cleanup }
BibSet >> checkDuplicates [
	self notYetImplemented
]

{ #category : #enumerating }
BibSet >> do: aBlock [
	self entries do: aBlock
]

{ #category : #cleanup }
BibSet >> dropUnusedMacros [
	| toKeep |
	toKeep := self referencedMacros.
	macros := macros select: [:each | toKeep includes: each key]
]

{ #category : #accessing }
BibSet >> entries [
	^ entries
]

{ #category : #accessing }
BibSet >> entryAt: aKey [
	"Return the local entry definition, if known."
	^ self entryAt: aKey ifAbsent: [Error signal]
]

{ #category : #accessing }
BibSet >> entryAt: aKey ifAbsent: aBlock [
	| index |
	index := entries findFirst: [:each | each key = aKey].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [entries at: index]
]

{ #category : #'arranging - combining' }
BibSet >> groupedBy: aBlock [
	| result |
	result := Dictionary new.
	self do: [ :each |
		(result at: (aBlock value: each) ifAbsentPut: BibSet new)
			addEntry: each
	].
	^ result
]

{ #category : #'initialize-release' }
BibSet >> initialize [
	super initialize.
	macros := OrderedCollection new.
	entries := OrderedCollection new
]

{ #category : #accessing }
BibSet >> lookupEntryAt: aKey [
	"Return the entry named aKey, looking up the scope chain if necessary."
	^ self entryAt: aKey ifAbsent: [scope ifNotNil: [scope lookupEntryAt: aKey]]
]

{ #category : #accessing }
BibSet >> lookupMacroAt: aKey [
	"Return the value of macro named aKey, looking up the scope chain if necessary."
	^ self macroAt: aKey ifAbsent: [
		scope isNil
			ifTrue: [Error signal]
			ifFalse: [scope lookupMacroAt: aKey]]
]

{ #category : #accessing }
BibSet >> macroAt: aKey [
	"Return the local macro definition, if known."
	^ self macroAt: aKey ifAbsent: [Error signal.]
]

{ #category : #accessing }
BibSet >> macroAt: aKey ifAbsent: aBlock [
	| index |
	index := macros findFirst: [:each | each key = aKey].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [macros at: index]
]

{ #category : #accessing }
BibSet >> macros [
	^ macros
]

{ #category : #accessing }
BibSet >> referencedMacros [
	| usedMacros |
	usedMacros := Set new.
	self do: [ :eachEntry |
		usedMacros addAll: (eachEntry macroReferences collect: [:each | each value])
	].
	^ usedMacros
]

{ #category : #'arranging - combining' }
BibSet >> select: aPredicate [
	^ self class new
		setEntries: (self entries select: aPredicate)
]

{ #category : #'arranging - combining' }
BibSet >> sortBy: aSortBlock [
	entries := entries asSortedCollection: aSortBlock
]

{ #category : #'arranging - combining' }
BibSet >> sortByAuthor [
	self notYetImplemented
]

{ #category : #'arranging - combining' }
BibSet >> sortByDateReverse [
	self sortBy: [:x :y | (x at: #year) >= (y at: #year)]
]
