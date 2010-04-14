"
A BibQuery is an object that reifies queries over BibEntries.

BibQuery objects are created by invoking the following (class-side) methods:

BibEntry all
BibEntry contains: aString
BibEntry matches: aPattern
BibEntry hasField: fieldName
BibType matches: aPattern 
BibKey matches: aPattern 
BibField named: fieldName contains: aString
BibField named: fieldName matches: aPattern

Instance methods AND:, OR: and NOT can be used to compose or negate basic queries.

A composed query behaves like a single-argument BlockClosure, i.e., it implements value:
See testCartoonQueries for examples.

"
Class {
	#name : #CZBibQuery,
	#superclass : #Object,
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibQuery >> = aBibquery [
	^ self subclassResponsibility
]

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
CZBibQuery >> printOn: aStream [
	^ aStream nextPutAll: self queryString
]

{ #category : #printing }
CZBibQuery >> queryString [
	^ self subclassResponsibility
]

{ #category : #public }
CZBibQuery >> value: aBibEntry [
	^ self subclassResponsibility
]
