Class {
	#name : #BibSetTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Tests'
}

{ #category : #accessing }
BibSetTest class >> resources [
	^ Array with: BibTestResource
]

{ #category : #running }
BibSetTest >> setUp [
	bibset := BibTestResource current bibset
]

{ #category : #testing }
BibSetTest >> testGroupedBy [
	| groups groupedItemCount |
	groups := bibset groupedBy: [:each | each type].
	groupedItemCount := groups inject: 0 into: [:sum :each | sum + each entries size].
	self assert: groupedItemCount = bibset entries size.
	self assert: (groups at: #article) entries size = 2.
	self assert: (groups at: #inproceedings) entries size = 1.
	self assert: (groups at: #misc) entries size = 1.
]

{ #category : #testing }
BibSetTest >> testReferencedMacros [
	self assert: bibset referencedMacros size = 2
]

{ #category : #testing }
BibSetTest >> testScope [
	self should: [bibset macroAt: 'feb'] raise: Error.
	self should: [bibset lookupMacroAt: 'feb'] raise: Error.
	
	bibset scope: BibSet months.

	self should: [bibset macroAt: 'feb'] raise: Error.
	self shouldnt: [bibset lookupMacroAt: 'feb'] raise: Error.
	self assert: (bibset lookupMacroAt: 'feb') value = (BibSet months macroAt: 'feb') value
]

{ #category : #testing }
BibSetTest >> testSortedBy [
	bibset sortByDateReverse.
	bibset entries overlappingPairsDo: [:x :y | self assert: (x at: #year) >= (y at: #year)].
	self assert: bibset entries last key = #meuh
]

{ #category : #testing }
BibSetTest >> testUnusedMacros [
	bibset macros size = 2.

	bibset dropUnusedMacros.
	self assert: bibset macros size = 1.
	self shouldnt: [bibset macroAt: #used] raise: Error.
	self should: [bibset macroAt: #unused] raise: Error
]
