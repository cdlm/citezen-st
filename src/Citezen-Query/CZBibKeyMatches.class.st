Class {
	#name : #CZBibKeyMatches,
	#superclass : #CZBibMatches,
	#category : #'Citezen-Query'
}

{ #category : #printing }
CZBibKeyMatches >> queryString [
	^ '(Key matches ' , self patternAsString , ')'
]

{ #category : #public }
CZBibKeyMatches >> value: aBibEntry [
	^ self pattern match: aBibEntry key
]
