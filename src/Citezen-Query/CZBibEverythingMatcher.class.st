Class {
	#name : #CZBibEverythingMatcher,
	#superclass : #CZBibMatches,
	#category : #'Citezen-Query'
}

{ #category : #printing }
CZBibEverythingMatcher >> queryString [
	^ '(Entry matches Everything)'
]

{ #category : #public }
CZBibEverythingMatcher >> value: aBibEntry [
	^ true
]
