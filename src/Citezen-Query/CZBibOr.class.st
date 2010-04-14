Class {
	#name : #CZBibOr,
	#superclass : #CZBibQuery,
	#instVars : [
		'leftOr',
		'rightOr'
	],
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibOr >> = aBibquery [
	^ self class = aBibquery class and: [ self leftOr = aBibquery leftOr and: [ self rightOr = aBibquery rightOr ] ]
]

{ #category : #accessing }
CZBibOr >> leftOr [
	^ leftOr
]

{ #category : #accessing }
CZBibOr >> leftOr: anObject [
	leftOr := anObject
]

{ #category : #printing }
CZBibOr >> queryString [
	^ '(' , self leftOr printString , ' or ' , self rightOr printString , ')'
]

{ #category : #accessing }
CZBibOr >> rightOr [
	^ rightOr
]

{ #category : #accessing }
CZBibOr >> rightOr: anObject [
	rightOr := anObject
]

{ #category : #public }
CZBibOr >> value: aBibEntry [
	^ (leftOr value: aBibEntry) or: [ rightOr value: aBibEntry ]
]
