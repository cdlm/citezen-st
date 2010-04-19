Class {
	#name : #CZBibField,
	#superclass : #CZBibQueryFactory,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibField class >> initialize [ 
	uniqueInstance := self new.
]

{ #category : #'as yet unclassified' }
CZBibField class >> uniqueInstance [ 
	^ uniqueInstance
]

{ #category : #'as yet unclassified' }
CZBibField >> < aValue [
	^ CZBibFieldCompare new comparingBlock: [ :field :entry | ((entry at: field) value) < aValue ]
]

{ #category : #'as yet unclassified' }
CZBibField >> <= aValue [
	^ CZBibFieldCompare new comparingBlock: [ :field :entry | ((entry at: field) value) <= aValue ]
]

{ #category : #'as yet unclassified' }
CZBibField >> = aValue [
	^ CZBibFieldCompare new comparingBlock: [ :field :entry | ((entry at: field) value) = aValue ]
]

{ #category : #'as yet unclassified' }
CZBibField >> > aValue [
	^ CZBibFieldCompare new comparingBlock: [ :field :entry | ((entry at: field) value) > aValue ]
]

{ #category : #'as yet unclassified' }
CZBibField >> >= aValue [
	^ CZBibFieldCompare new comparingBlock: [ :field :entry | ((entry at: field) value) >= aValue ]
]

{ #category : #'as yet unclassified' }
CZBibField >> named: aSymbol checks: aQuery [
	^ aQuery field: aSymbol 
]
