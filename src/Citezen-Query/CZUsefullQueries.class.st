"
Some useful queries, on class side.
"
Class {
	#name : #CZUsefullQueries,
	#superclass : #Object,
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZUsefullQueries class >> dontMatchAuthor: aString [
	^ (self matchAuthor: aString) NOT
]

{ #category : #'as yet unclassified' }
CZUsefullQueries class >> matchAuthor: aString [
	^ (CZBibFieldQuery named: #author checks: [:each | ('*',aString,'*') match: each])
]
