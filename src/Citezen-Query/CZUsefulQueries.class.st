"
Some useful queries, on class side.
"
Class {
	#name : #CZUsefulQueries,
	#superclass : #Object,
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZUsefulQueries class >> dontMatchAuthor: aString [
	^ (self matchAuthor: aString) NOT
]

{ #category : #'as yet unclassified' }
CZUsefulQueries class >> matchAuthor: aString [
	^ (CZFieldQuery named: #author checks: [:each | ('*',aString,'*') match: each])
]
