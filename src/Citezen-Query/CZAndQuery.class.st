"
Returns leftAnd value: and rightAnd value: on the value: call
"
Class {
	#name : #CZAndQuery,
	#superclass : #CZQuery,
	#instVars : [
		'leftAnd',
		'rightAnd'
	],
	#category : 'Citezen-Query'
}

{ #category : #'accessing-private' }
CZAndQuery >> field: aSymbol [
	leftAnd field: aSymbol.
	rightAnd field: aSymbol 
]

{ #category : #'accessing-private' }
CZAndQuery >> leftAnd [
	^ leftAnd
]

{ #category : #'accessing-private' }
CZAndQuery >> leftAnd: anObject [
	leftAnd := anObject
]

{ #category : #printing }
CZAndQuery >> queryString [
	^ '(' , self leftAnd printString , ' and ' , self rightAnd printString , ')'
]

{ #category : #'accessing-private' }
CZAndQuery >> rightAnd [
	^ rightAnd
]

{ #category : #'accessing-private' }
CZAndQuery >> rightAnd: anObject [
	rightAnd := anObject
]

{ #category : #public }
CZAndQuery >> value: aBibEntry [
	^ (leftAnd value: aBibEntry) and: [ rightAnd value: aBibEntry ]
]
