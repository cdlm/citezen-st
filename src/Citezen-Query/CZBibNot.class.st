"
Returns query value: not on the value: call
"
Class {
	#name : #CZBibNot,
	#superclass : #CZBibQuery,
	#instVars : [
		'query'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibNot >> field: aSymbol [
	query field: aSymbol 
]

{ #category : #accessing }
CZBibNot >> query [
	^ query
]

{ #category : #accessing }
CZBibNot >> query: aBlock [
	query := aBlock
]

{ #category : #printing }
CZBibNot >> queryString [
	^ 'not ' , self query printString
]

{ #category : #public }
CZBibNot >> value: aCZEntry [
	^ (self query value: aCZEntry) not
]
