Class {
	#name : #CZBibFieldQuery,
	#superclass : #CZBibGeneralQuery,
	#instVars : [
		'field'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibFieldQuery class >> named: aSymbol checks: aBlock [
	^ self new field: aSymbol; block: aBlock 
]

{ #category : #'as yet unclassified' }
CZBibFieldQuery >> field: aSymbol [
	field := aSymbol 
]

{ #category : #'as yet unclassified' }
CZBibFieldQuery >> value: aCZEntry [
	^ super value: (aCZEntry at: field) value
]
