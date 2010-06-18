"
Returns query value: not on the value: call
"
Class {
	#name : #CZNotQuery,
	#superclass : #CZQuery,
	#instVars : [
		'query'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZNotQuery >> field: aSymbol [
	query field: aSymbol 
]

{ #category : #accessing }
CZNotQuery >> query [
	^ query
]

{ #category : #accessing }
CZNotQuery >> query: aBlock [
	query := aBlock
]

{ #category : #printing }
CZNotQuery >> queryString [
	^ 'not ' , self query printString
]

{ #category : #public }
CZNotQuery >> value: aCZEntry [
	^ (self query value: aCZEntry) not
]
