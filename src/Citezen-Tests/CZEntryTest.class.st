Class {
	#name : #CZEntryTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'duplicateEntry'
	],
	#category : #'Citezen-Tests'
}

{ #category : #running }
CZEntryTest >> setUp [

	entry := (CZBibParser parse: CZTestResource bibTest) entries at:1.
	duplicateEntry := (CZBibParser parse: CZTestResource bibTest) entries at:1

]

{ #category : #running }
CZEntryTest >> tearDown [
	entry := nil.
	duplicateEntry := nil
]

{ #category : #tests }
CZEntryTest >> testAddToBibSet [
	| bibset |
	
	bibset := CZSet new.
	bibset addEntry: entry.
	
	self assert: ((bibset entries at:1) == entry).
	self assert: (entry scope == bibset).
	
]

{ #category : #tests }
CZEntryTest >> testAt [
	self assert: ((entry at:#pages) class = CZField).
	self assert: ((entry at:#absent) class = CZUndefinedField).
	self assert: (entry at:#absent ifAbsent:'a pas' = 'a pas').
	
]

{ #category : #tests }
CZEntryTest >> testEqualsButDifferent [
	self assert: (entry equalsButDifferent: duplicateEntry).
	self deny: (entry equalsButDifferent: entry).
	
	duplicateEntry type: #changed.
	self deny: (entry equalsButDifferent: duplicateEntry).
	
	self setUp.
	duplicateEntry key: #changed.
	self deny: (entry equalsButDifferent: duplicateEntry).
	
	self setUp.
	duplicateEntry at:#add put:''.
	self deny: (entry equalsButDifferent: duplicateEntry)

]

{ #category : #tests }
CZEntryTest >> testHasField [
	self assert: (entry hasField: #author).
	self assert: (entry hasField: #title).
	self assert: (entry hasField: #pages).
	self deny: (entry hasField: #anotherField).
	self deny: (entry hasField: '').
]

{ #category : #tests }
CZEntryTest >> testKey [
	self assert: (entry key = #testUnpublished).
	entry key: #test.
	self assert: (entry key = #test)
]

{ #category : #tests }
CZEntryTest >> testMacroReferences [
	self assert: (entry macroReferences size = 1).
	entry at: #macro put:#MACRO.
	self assert: (entry macroReferences size = 2)
]

{ #category : #tests }
CZEntryTest >> testMoveToBibSet [
	| bibsetFrom bibsetTo |
	bibsetFrom := CZSet new.
	bibsetTo := CZSet new.
	
	entry addToBibSet: bibsetFrom.
	entry moveToBibSet: bibsetTo.
	
	self assert: (bibsetFrom entries size = 0).
	self assert: (bibsetTo entries size = 1).
	self assert: (entry scope == bibsetTo).
	
]

{ #category : #tests }
CZEntryTest >> testSize [
	| entrySize |
	entrySize := 0.
	entry do: [:each | entrySize := entrySize+1].
	
	self assert: (entry size = entrySize).
	entry at:#nonRenseigne put:'maintenant, si'.
	self assert: (entry size = (entrySize+1))
]

{ #category : #tests }
CZEntryTest >> testType [
	self assert: (entry type = #unpublished).
	entry type: #test.
	self assert: (entry type = #test)
]
