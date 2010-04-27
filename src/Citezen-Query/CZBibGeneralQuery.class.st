Class {
	#name : #CZBibGeneralQuery,
	#superclass : #CZBibQuery,
	#instVars : [
		'block'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibGeneralQuery class >> checks: aBlock [
	^ self new block: aBlock 
]

{ #category : #'as yet unclassified' }
CZBibGeneralQuery >> block: aBlock [
	block := aBlock 
]

{ #category : #'as yet unclassified' }
CZBibGeneralQuery >> value: aValue [
	block isNil ifTrue: [ ^ true ].
	(aValue = '') ifTrue: [ ^ false ].
	^ block value: aValue 
]
