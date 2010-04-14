Class {
	#name : #CZBibHasField,
	#superclass : #CZBibQuery,
	#instVars : [
		'field'
	],
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibHasField >> = aBibquery [
	^ self class = aBibquery class and: [ self field = aBibquery field ]
]

{ #category : #'accessing-private' }
CZBibHasField >> field [
	^ field
]

{ #category : #'accessing-private' }
CZBibHasField >> field: anObject [
	field := anObject
]

{ #category : #printing }
CZBibHasField >> queryString [
	^ '(has field ' , self field , ')'
]

{ #category : #public }
CZBibHasField >> value: aBibEntry [
	^ aBibEntry hasField: self field
]
