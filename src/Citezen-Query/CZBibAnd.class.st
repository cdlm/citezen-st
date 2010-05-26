"
Returns leftAnd value: and rightAnd value: on the value: call
"
Class {
	#name : #CZBibAnd,
	#superclass : #CZBibQuery,
	#instVars : [
		'leftAnd',
		'rightAnd'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibAnd >> field: aSymbol [
	leftAnd field: aSymbol.
	rightAnd field: aSymbol 
]

{ #category : #'accessing-private' }
CZBibAnd >> leftAnd [
	^ leftAnd
]

{ #category : #'accessing-private' }
CZBibAnd >> leftAnd: anObject [
	leftAnd := anObject
]

{ #category : #printing }
CZBibAnd >> queryString [
	^ '(' , self leftAnd printString , ' and ' , self rightAnd printString , ')'
]

{ #category : #'accessing-private' }
CZBibAnd >> rightAnd [
	^ rightAnd
]

{ #category : #'accessing-private' }
CZBibAnd >> rightAnd: anObject [
	rightAnd := anObject
]

{ #category : #public }
CZBibAnd >> value: aBibEntry [
	^ (leftAnd value: aBibEntry) and: [ rightAnd value: aBibEntry ]
]
