Class {
	#name : #CZSet,
	#superclass : #CZScoped,
	#instVars : [
		'macros',
		'entries'
	],
	#category : #'Citezen-Model'
}

{ #category : #'instance creation' }
CZSet class >> fromDeclarations: declarations [
	|instance|
	instance := self new.
	declarations do: [:each | each addToBibSet: instance].
	^ instance
]

{ #category : #'instance creation' }
CZSet class >> months [
	^ (self new)
		addMacro: (CZField key: 'jan' value: 'January');
		addMacro: (CZField key: 'feb' value: 'February');
		addMacro: (CZField key: 'mar' value: 'March');
		addMacro: (CZField key: 'apr' value: 'April');
		addMacro: (CZField key: 'may' value: 'May');
		addMacro: (CZField key: 'jun' value: 'June');
		addMacro: (CZField key: 'jul' value: 'July');
		addMacro: (CZField key: 'aug' value: 'August');
		addMacro: (CZField key: 'sep' value: 'September');
		addMacro: (CZField key: 'oct' value: 'October');
		addMacro: (CZField key: 'nov' value: 'November');
		addMacro: (CZField key: 'dec' value: 'December');
		yourself
]

{ #category : #'visitor-double dispatch' }
CZSet >> acceptVisitor: aVisitor [
	^ aVisitor visitBibSet: self
]

{ #category : #adding }
CZSet >> addEntry: anEntry [
	anEntry scope: self.
	entries add: anEntry
]

{ #category : #adding }
CZSet >> addMacro: aField [
	aField scope: self.
	macros add: aField
]

{ #category : #cleanup }
CZSet >> checkDuplicates [
	self notYetImplemented
]

{ #category : #enumerating }
CZSet >> do: aBlock [
	self entries do: aBlock
]

{ #category : #cleanup }
CZSet >> dropUnusedMacros [
	| toKeep |
	toKeep := self referencedMacros.
	macros := macros select: [:each | toKeep includes: each key]
]

{ #category : #accessing }
CZSet >> entries [
	^ entries
]

{ #category : #accessing }
CZSet >> entryAt: aKey [
	"Return the local entry definition, if known."
	^ self entryAt: aKey ifAbsent: [Error signal]
]

{ #category : #accessing }
CZSet >> entryAt: aKey ifAbsent: aBlock [
	| index |
	index := entries findFirst: [:each | each key = aKey].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [entries at: index]
]

{ #category : #'arranging - combining' }
CZSet >> groupedBy: aBlock [ 
	| result |
	result := Dictionary new.
	self 
		do: [:each | (result at: (aBlock value: each) ifAbsentPut: CZSet new) addEntry: each].
	^ result
]

{ #category : #'initialize-release' }
CZSet >> initialize [
	super initialize.
	macros := OrderedCollection new.
	entries := OrderedCollection new
]

{ #category : #accessing }
CZSet >> lookupEntryAt: aKey [
	"Return the entry named aKey, looking up the scope chain if necessary."
	^ self entryAt: aKey ifAbsent: [scope ifNotNil: [scope lookupEntryAt: aKey]]
]

{ #category : #accessing }
CZSet >> lookupMacroAt: aKey [
	"Return the value of macro named aKey, looking up the scope chain if necessary."
	^ self lookupMacroAt: aKey ifAbsent: [Error signal]
]

{ #category : #accessing }
CZSet >> lookupMacroAt: aKey ifAbsent: aBlock [
	"Return the value of macro named aKey, looking up the scope chain if necessary."
	^ self macroAt: aKey ifAbsent:
		[scope isNil
			ifTrue: [aBlock value]
			ifFalse: [scope lookupMacroAt: aKey ifAbsent: aBlock]]
]

{ #category : #accessing }
CZSet >> macroAt: aKey [
	"Return the local macro definition, if known."
	^ self macroAt: aKey ifAbsent: [Error signal.]
]

{ #category : #accessing }
CZSet >> macroAt: aKey ifAbsent: aBlock [
	| index |
	index := macros findFirst: [:each | each key = aKey].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [macros at: index]
]

{ #category : #accessing }
CZSet >> macros [
	^ macros
]

{ #category : #accessing }
CZSet >> referencedMacros [
	| usedMacros |
	usedMacros := Set new.
	self do: [ :eachEntry |
		usedMacros addAll: (eachEntry macroReferences collect: [:each | each value])
	].
	^ usedMacros
]

{ #category : #'arranging - combining' }
CZSet >> select: aPredicate [
	^ self class new
		setEntries: (self entries select: aPredicate)
]

{ #category : #'arranging - combining' }
CZSet >> sortBy: aSortBlock [
	entries := entries asSortedCollection: aSortBlock
]

{ #category : #'arranging - combining' }
CZSet >> sortByAuthor [
	self notYetImplemented
]

{ #category : #'arranging - combining' }
CZSet >> sortByDateReverse [
	self sortBy: [:x :y | (x at: #year) >= (y at: #year)]
]
