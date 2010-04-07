Class {
	#name : #CZSetTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Tests'
}

{ #category : #accessing }
CZSetTest class >> resources [
	^ Array with: CZTestResource
]

{ #category : #running }
CZSetTest >> setUp [
	bibset := CZTestResource current bibset
]

{ #category : #'as yet unclassified' }
CZSetTest >> testCheckDuplicates [
	| duplicateSet sizeEntries sizeMacros |
	duplicateSet := CZBibParser parse: 
		CZTestResource myBibFile, CZTestResource myBibFile.
		
	sizeEntries := duplicateSet entries size.
	sizeMacros := duplicateSet macros size.
	
	duplicateSet checkDuplicates.
	
	self assert: (duplicateSet entries size = (sizeEntries / 2)).
	self assert: (duplicateSet macros size = (sizeMacros / 2)).
	
	sizeEntries := duplicateSet entries size.
	sizeMacros := duplicateSet macros size.
	
	duplicateSet checkDuplicates.
	
	self assert: (duplicateSet entries size = sizeEntries).
	self assert: (duplicateSet macros size = sizeMacros).
]

{ #category : #running }
CZSetTest >> testEntryAtKey [
	"self debug: #testEntryAtKey"
	
	self assert: (bibset entryAt: #meuh) class = CZEntry.
	self assert: (bibset entryAt: #inexistant ifAbsent:'pas là') = 'pas là'.
]

{ #category : #testing }
CZSetTest >> testGroupedBy [
	| groups groupedItemCount |
	groups := bibset groupedBy: [:each | each type].
	groupedItemCount := groups inject: 0 into: [:sum :each | sum + each entries size].
	
	self assert: groupedItemCount = bibset entries size.
	self assert: (groups at: #article) entries size = 2.
	self assert: (groups at: #inproceedings) entries size = 1.
	self assert: (groups at: #misc) entries size = 1.
]

{ #category : #testing }
CZSetTest >> testReferencedMacros [
	self assert: bibset referencedMacros size = 2
]

{ #category : #testing }
CZSetTest >> testRemoveUpdatesScope [
	| otherSet entry |
	otherSet := CZSet new.
	entry := (CZEntry type: #article) key: #toBeMovedToOtherSet.
	bibset addEntry: entry.
	entry moveToBibSet: otherSet.
	self deny: (bibset entries includes: entry).
	self assert: (otherSet entries includes: entry).
	self assert: entry scope = otherSet
]

{ #category : #testing }
CZSetTest >> testScope [
	self should: [bibset macroAt: 'feb'] raise: Error.
	self assert: (bibset lookupMacroAt: 'feb') isUndefined.
	bibset scope: CZSet months.
	self should: [bibset macroAt: 'feb'] raise: Error.
	self shouldnt: [bibset lookupMacroAt: 'feb'] raise: Error.
	self assert: (bibset lookupMacroAt: 'feb') value 
				= (CZSet months macroAt: 'feb') value
]

{ #category : #testing }
CZSetTest >> testSortedBy [
	bibset sortByDateReverse.
	bibset entries overlappingPairsDo: [:x :y | self assert: (x at: #year) value >= (y at: #year) value].
	self assert: bibset entries last key = #meuh
]

{ #category : #testing }
CZSetTest >> testUnusedMacros [
	self assert: bibset macros size = 2.

	bibset dropUnusedMacros.
	self assert: bibset macros size = 1.
	self shouldnt: [bibset macroAt: #used] raise: Error.
	self should: [bibset macroAt: #unused] raise: Error
]
