Class {
	#name : #CZBibFieldCompare,
	#superclass : #CZBibQuery,
	#instVars : [
		'comparingBlock',
		'field'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibFieldCompare >> comparingBlock: aBlock [
	comparingBlock := aBlock 
]

{ #category : #'as yet unclassified' }
CZBibFieldCompare >> field: aSymbol [
	field := aSymbol 
]

{ #category : #'as yet unclassified' }
CZBibFieldCompare >> value: aBibEntry [
	^ comparingBlock value: field value: aBibEntry 
]
