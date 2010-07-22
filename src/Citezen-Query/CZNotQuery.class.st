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

{ #category : #accessing }
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
