"
CZFalseQuery represents a query that always returns false.
"
Class {
	#name : #CZFalseQuery,
	#superclass : #CZQuery,
	#category : 'Citezen-Query'
}

{ #category : #public }
CZFalseQuery >> AND: aQuery [
	"optimized for false, false and something is false"
	^ CZFalseQueryInstance
]

{ #category : #public }
CZFalseQuery >> OR: aQuery [
	"optimized for false, false or something is something"
	^ aQuery
]

{ #category : #public }
CZFalseQuery >> value: anObject [

	^ false
]
