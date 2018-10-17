"
Returns leftAnd value: or rightAnd value: on the value: call
"
Class {
	#name : #CZOrQuery,
	#superclass : #CZQuery,
	#instVars : [
		'leftOr',
		'rightOr'
	],
	#category : 'Citezen-Query'
}

{ #category : #accessing }
CZOrQuery >> field: aSymbol [
	leftOr field: aSymbol.
	rightOr field: aSymbol 
]

{ #category : #accessing }
CZOrQuery >> leftOr [
	^ leftOr
]

{ #category : #accessing }
CZOrQuery >> leftOr: anObject [
	leftOr := anObject
]

{ #category : #printing }
CZOrQuery >> queryString [
	^ '(' , self leftOr printString , ' or ' , self rightOr printString , ')'
]

{ #category : #accessing }
CZOrQuery >> rightOr [
	^ rightOr
]

{ #category : #accessing }
CZOrQuery >> rightOr: anObject [
	rightOr := anObject
]

{ #category : #public }
CZOrQuery >> value: aBibEntry [
	^ (leftOr value: aBibEntry) or: [ rightOr value: aBibEntry ]
]
