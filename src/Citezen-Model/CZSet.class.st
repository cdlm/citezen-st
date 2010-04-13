"
Set of bibliographic entries and macro definitions, equivalent of a .bib BibTeX file.
"
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

{ #category : #'standard definitions' }
CZSet class >> months [
	^ (self new)
		addMacro: (CZField key: 'jan' rawValue: 'January');
		addMacro: (CZField key: 'feb' rawValue: 'February');
		addMacro: (CZField key: 'mar' rawValue: 'March');
		addMacro: (CZField key: 'apr' rawValue: 'April');
		addMacro: (CZField key: 'may' rawValue: 'May');
		addMacro: (CZField key: 'jun' rawValue: 'June');
		addMacro: (CZField key: 'jul' rawValue: 'July');
		addMacro: (CZField key: 'aug' rawValue: 'August');
		addMacro: (CZField key: 'sep' rawValue: 'September');
		addMacro: (CZField key: 'oct' rawValue: 'October');
		addMacro: (CZField key: 'nov' rawValue: 'November');
		addMacro: (CZField key: 'dec' rawValue: 'December');
		yourself
]

{ #category : #'standard definitions' }
CZSet class >> standardDefinitions [
	^ self months
]

{ #category : #'instance creation' }
CZSet class >> withStandardDefinitions [
	^ self new
		scope: self standardDefinitions;
		yourself
]

{ #category : #'mathematical operations' }
CZSet >> \ aCZSet [
	"Answer the set difference A \ B between the receiver A and aSet B. The set
	difference is defined by A \ B = { x | x in A and x not in B }."

	^self select: [ :each | (aCZSet entries includes: each) not ]
]

{ #category : #'visitor-double dispatch' }
CZSet >> acceptVisitor: aVisitor [
	aVisitor visitBibSet: self
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
	| withoutDuplicates |
	
	entries := self checkDuplicatesFor: entries.
	macros := self checkDuplicatesFor: macros.
  	
]

{ #category : #cleanup }
CZSet >> checkDuplicatesFor: list [
	| withoutDuplicates |
	
	withoutDuplicates := OrderedCollection new.
	
	1 to:list size do: 
		[ :each | (self existsDuplicateFor: (list at:each) startingAt: each in: list) ifFalse:
			[ withoutDuplicates add:(list at:each) ]].
	
	^ withoutDuplicates.

  	
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

{ #category : #accessing }
CZSet >> entryAt: aKey put: anEntry [
	| index |
	index := entries findFirst: [:each | each key = aKey].
	^ index = 0
		ifTrue: [entries add: anEntry]
		ifFalse: [entries at: index put: anEntry]
]

{ #category : #'as yet unclassified' }
CZSet >> equalsButDifferent: aSet [
	(entries size = aSet entries size) ifFalse: [ ^ false ].
	(macros size = aSet macros size) ifFalse: [ ^ false ].
	
	1 to: entries size do: [ :cpt | 
		((entries at: cpt) equalsButDifferent: (aSet entries at: cpt)) 
			ifFalse: [ ^ false ]].
	
	1 to: macros size do: [ :cpt |
		((macros at: cpt) equalsButDifferent: (aSet macros at: cpt))
			ifFalse: [ ^ false ]].
	
	^ true
]

{ #category : #'as yet unclassified' }
CZSet >> existsDuplicateFor: entry startingAt: index in: list [
	"search a duplicate for entry from entries at: index to the end of entries"

	index to: list size do:
		[ :each | ((list at:each) equalsButDifferent: entry) ifTrue:
			[ ^ true ] ].
	^ false.
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
CZSet >> isEmpty [
	^self entries isEmpty
]

{ #category : #accessing }
CZSet >> lookupEntryAt: aKey [
	"Return the entry named aKey, looking up the scope chain if necessary."
	^ self entryAt: aKey ifAbsent: [scope ifNotNil: [scope lookupEntryAt: aKey]]
]

{ #category : #accessing }
CZSet >> lookupMacroAt: aKey ifAbsent: aBlock [
	"Return the local value of macro named aKey, or look it up."
	^ self macroAt: aKey ifAbsent:
		[super lookupMacroAt: aKey ifAbsent: aBlock]
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
CZSet >> macroAt: aKey put: aMacro [
	| index |
	index := macros findFirst: [:each | each key = aKey].
	^ index = 0
		ifTrue: [macros add: aMacro]
		ifFalse: [macros at: index put: aMacro]
]

{ #category : #accessing }
CZSet >> macros [
	^ macros
]

{ #category : #'arranging - combining' }
CZSet >> merge: aCZSet [
	"Merge aCZSet into the receiver, replacing macros or entries."
	aCZSet macros do: [:each | self macroAt: each key put: each].
	aCZSet entries do: [:each | self entryAt: each key put: each]
]

{ #category : #printing }
CZSet >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	entries size printOn: aStream.
	aStream nextPutAll: ' entries, '.
	macros size printOn: aStream.
	aStream nextPutAll: ' macros)'
]

{ #category : #accessing }
CZSet >> referencedMacros [
	| usedMacros |
	usedMacros := Set new.
	self do: [ :eachEntry |
		usedMacros addAll: (eachEntry macroReferences collect: [:each | each rawValue])
	].
	^ usedMacros
]

{ #category : #'arranging - combining' }
CZSet >> reject: aPredicate [
	^ self class new
		setEntries: (self entries reject: aPredicate)
]

{ #category : #adding }
CZSet >> removeEntry: anEntry [
	anEntry scope: nil.
	entries remove: anEntry
]

{ #category : #'arranging - combining' }
CZSet >> select: aPredicate [
	^ self class new
		setEntries: (self entries select: aPredicate)
]

{ #category : #accessing }
CZSet >> setEntries: aCollection [
	entries := aCollection
]

{ #category : #'arranging - combining' }
CZSet >> sortBy: aSortBlock [
	entries := entries asSortedCollection: aSortBlock
]

{ #category : #'arranging - combining' }
CZSet >> sortByAuthor [
	self sortBy: [:x :y | (x at: #author) rawValue <= (y at: #author) rawValue]
]

{ #category : #'arranging - combining' }
CZSet >> sortByDateReverse [
	self sortBy: [:x :y | (x at: #year) value >= (y at: #year) value]
]

{ #category : #'initialize-release' }
CZSet >> withStandardDefinitions [
	self scope: self class standardDefinitions.
	^ self
]
