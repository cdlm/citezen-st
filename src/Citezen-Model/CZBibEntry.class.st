Class {
	#name : #CZBibEntry,
	#superclass : #PRStructure,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'as yet unclassified' }
CZBibEntry class >> canBeChildOf: aStructureClass [
	^ aStructureClass includesBehavior: CZBibList
]

{ #category : #'as yet unclassified' }
CZBibEntry class >> isAbstract [
	^false
]

{ #category : #visiting }
CZBibEntry >> accept: aVisitor [
	aVisitor visitBibEntry: self
]

{ #category : #accessing }
CZBibEntry >> entry [
	^entry
]

{ #category : #accessing }
CZBibEntry >> entry: aBibEntry [
	entry := aBibEntry 
]

{ #category : #rendering }
CZBibEntry >> viewComponentClass [
	^ CZBibEntryHtmlView
]
