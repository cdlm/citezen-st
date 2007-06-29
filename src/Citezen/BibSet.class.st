Class {
	#name : #BibSet,
	#superclass : #Object,
	#instVars : [
		'macros',
		'entries'
	],
	#category : #Citezen
}

{ #category : #'instance creation' }
BibSet class >> fromDeclarations: declarations [
	|instance|
	instance := self new.
	declarations do: [:each | each addToBibSet: instance].
	^ instance
]

{ #category : #'visitor-double dispatch' }
BibSet >> acceptVisitor: aVisitor [
	^ aVisitor visitBibSet: self
]

{ #category : #adding }
BibSet >> addEntry: anEntry [
	entries at: anEntry key put: anEntry
]

{ #category : #adding }
BibSet >> addEntry: anEntry ifDuplicate: aBlock [
	entries at: anEntry key ifAbsent: [^ self addEntry: anEntry].
	^ aBlock value
]

{ #category : #adding }
BibSet >> addMacro: anAssociation [
	macros add: anAssociation
]

{ #category : #adding }
BibSet >> addMacro: aMacro ifDuplicate: aBlock [
	macros at: aMacro key ifAbsent: [^ self addMacro: aMacro].
	^ aBlock value
]

{ #category : #enumerating }
BibSet >> do: aBlock [
	self entries do: aBlock
]

{ #category : #cleanup }
BibSet >> dropUnusedMacros [
	| toKeep |
	toKeep := self referencedMacros.
	macros := macros associationsSelect: [:each | toKeep includes: each key]
]

{ #category : #accessing }
BibSet >> entries [
	^ entries
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
	macros := Dictionary new. "name -> value"
	entries := Dictionary new "entry key -> entry"
]

{ #category : #accessing }
BibSet >> macroAt: aKey [
	^ macros at: aKey
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
