"
CZQuery is an abstract class.
It defines 3 messages: 
- AND: aQuery
- OR: aQuery
- NOT

These 3 messages are constructors shared by all queries. They respectively create CZAndQuery, CZOrQuery and CZNotQuery instances.

"
Class {
	#name : #CZQuery,
	#superclass : #Object,
	#classVars : [
		'CZFalseQueryInstance',
		'CZTrueQueryInstance'
	],
	#category : #'Citezen-Query'
}

{ #category : #'initialize-release' }
CZQuery class >> initialize [
	"self initialize"
	
	CZFalseQueryInstance := CZFalseQuery new.
	CZTrueQueryInstance := CZTrueQuery new
]

{ #category : #public }
CZQuery >> AND: aQuery [
	^ (CZAndQuery new)
		leftAnd: self;
		rightAnd: aQuery;
		yourself
]

{ #category : #public }
CZQuery >> NOT [
	^ CZNotQuery new query: self
]

{ #category : #public }
CZQuery >> OR: aQuery [
	^ (CZOrQuery new)
		leftOr: self;
		rightOr: aQuery;
		yourself
]

{ #category : #public }
CZQuery >> value: aBibEntry [
	^ self subclassResponsibility
]
