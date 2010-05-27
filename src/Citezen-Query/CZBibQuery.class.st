"
CZBibQuery is an abstract class.
It defines 3 messages: 
- AND: aQuery
- OR: aQuery
- NOT

These 3 messages are constructors shared by all queries. They respectively create CZBibAnd, CZBibOr and CZBibNot instances.
"
Class {
	#name : #CZBibQuery,
	#superclass : #Object,
	#category : #'Citezen-Query'
}

{ #category : #public }
CZBibQuery >> AND: aQuery [
	^ (CZBibAnd new)
		leftAnd: self;
		rightAnd: aQuery;
		yourself
]

{ #category : #public }
CZBibQuery >> NOT [
	^ CZBibNot new query: self
]

{ #category : #public }
CZBibQuery >> OR: aQuery [
	^ (CZBibOr new)
		leftOr: self;
		rightOr: aQuery;
		yourself
]

{ #category : #printing }
CZBibQuery >> queryString [
	^ self subclassResponsibility
]

{ #category : #public }
CZBibQuery >> value: aBibEntry [
	^ self subclassResponsibility
]
