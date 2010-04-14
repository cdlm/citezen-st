Class {
	#name : #CZBibTypeMatches,
	#superclass : #CZBibMatches,
	#category : #'Citezen-Query'
}

{ #category : #printing }
CZBibTypeMatches >> queryString [
	^ '(Type matches ' , self patternAsString , ')'
]

{ #category : #public }
CZBibTypeMatches >> value: aBibEntry [
	^ self pattern match: aBibEntry type
]
