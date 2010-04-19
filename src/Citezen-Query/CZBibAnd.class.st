Class {
	#name : #CZBibAnd,
	#superclass : #CZBibQuery,
	#instVars : [
		'leftAnd',
		'rightAnd'
	],
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibAnd >> = aBibquery [
	^ self class = aBibquery class and: [ self leftAnd = aBibquery leftAnd and: [ self rightAnd = aBibquery rightAnd ] ]
]

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
