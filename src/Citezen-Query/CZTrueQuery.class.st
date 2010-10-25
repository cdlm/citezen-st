"
CZTrueQuery represents a query that always returns true.
"
Class {
	#name : #CZTrueQuery,
	#superclass : #CZQuery,
	#category : #'Citezen-Query'
}

{ #category : #public }
CZTrueQuery >> AND: aQuery [
	^ aQuery
]

{ #category : #public }
CZTrueQuery >> OR: aQuery [
	^ CZTrueQueryInstance
]

{ #category : #public }
CZTrueQuery >> value: anObject [

	^ true
]
