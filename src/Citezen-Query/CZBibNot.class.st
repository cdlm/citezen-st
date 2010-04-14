Class {
	#name : #CZBibNot,
	#superclass : #CZBibQuery,
	#instVars : [
		'query'
	],
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibNot >> = aBibquery [
	^ self class = aBibquery class and: [ self query = aBibquery query ]
]

{ #category : #accessing }
CZBibNot >> query [
	^ query
]

{ #category : #accessing }
CZBibNot >> query: anObject [
	query := anObject
]

{ #category : #printing }
CZBibNot >> queryString [
	^ 'not ' , self query printString
]

{ #category : #public }
CZBibNot >> value: aBibEntry [
	^ (self query value: aBibEntry) not
]
