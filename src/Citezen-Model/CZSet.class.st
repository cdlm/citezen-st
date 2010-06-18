"
A CZSet is a set of bibliographic entries and macro definitions, equivalent of a .bib BibTeX file.

Most useful messages: 
- addEntry: aCZEntry and addMacro: aCZField -> add the entry or the macro, and put self as its scope
- entries & entries: aCollection -> getter and setter for the entries collection
- entryAt: aSymbol & entryAt: aSymbol ifAbsent: aBlock -> returns the entry which has aSymbol as key
- entryAt: aSymbol put: anEntry -> put (or replace) the entry at the key aSymbol
- macroAt: aSymbol & macroAt: aSymbol ifAbsent: aBlock & macroAt: aSymbol put: aCZField -> same things than the three previous messages

CZSet has the withStandardDefinition constructor. It returns a CZSet with the definition of 12 macros for all the months (jan = january, ...).
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
CZSet >> addEntry: aCZEntry [
	aCZEntry scope: self.
	entries add: aCZEntry
]

{ #category : #adding }
CZSet >> addMacro: aCZField [
	aCZField scope: self.
	macros add: aCZField
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

{ #category : #'as yet unclassified' }
CZSet >> entries: aCollection [
	entries := aCollection 
]

{ #category : #accessing }
CZSet >> entryAt: aSymbol [
	"Return the local entry definition, if known."
	^ self entryAt: aSymbol ifAbsent: [Error signal]
]

{ #category : #accessing }
CZSet >> entryAt: aSymbol ifAbsent: aBlock [
	| index |
	index := entries findFirst: [:each | each key = aSymbol].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [entries at: index]
]

{ #category : #accessing }
CZSet >> entryAt: aSymbol put: anEntry [
	| index |
	index := entries findFirst: [:each | each key = aSymbol].
	^ index = 0
		ifTrue: [entries add: anEntry]
		ifFalse: [entries at: index put: anEntry]
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
CZSet >> lookupEntryAt: aSymbol [
	"Return the entry named aSymbol, looking up the scope chain if necessary."
	^ self entryAt: aSymbol ifAbsent: [scope ifNotNil: [scope lookupEntryAt: aSymbol]]
]

{ #category : #accessing }
CZSet >> lookupMacroAt: aSymbol ifAbsent: aBlock [
	"Return the local value of macro named aSymbol, or look it up."
	^ self macroAt: aSymbol ifAbsent:
		[super lookupMacroAt: aSymbol ifAbsent: aBlock]
]

{ #category : #accessing }
CZSet >> macroAt: aSymbol [
	"Return the local macro definition, if known."
	^ self macroAt: aSymbol ifAbsent: [Error signal.]
]

{ #category : #accessing }
CZSet >> macroAt: aSymbol ifAbsent: aBlock [
	| index |
	index := macros findFirst: [:each | each key = aSymbol].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [macros at: index]
]

{ #category : #accessing }
CZSet >> macroAt: aSymbol put: aCZField [
	| index |
	index := macros findFirst: [:each | each key = aSymbol].
	^ index = 0
		ifTrue: [macros add: aCZField]
		ifFalse: [macros at: index put: aCZField]
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
CZSet >> reject: aBlock [
	^ self class new
		setEntries: (self entries reject: aBlock)
]

{ #category : #adding }
CZSet >> removeEntry: aCZEntry [
	aCZEntry scope: nil.
	entries remove: aCZEntry
]

{ #category : #'arranging - combining' }
CZSet >> select: aBlock [
	^ self class new
		setEntries: (self entries select: aBlock)
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
