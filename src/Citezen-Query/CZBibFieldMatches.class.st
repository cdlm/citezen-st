Class {
	#name : #CZBibFieldMatches,
	#superclass : #CZBibMatches,
	#instVars : [
		'field'
	],
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibFieldMatches >> = aBibquery [
	^ super = aBibquery and: [ self field = aBibquery field ]
]

{ #category : #accessing }
CZBibFieldMatches >> field [
	^ field
]

{ #category : #accessing }
CZBibFieldMatches >> field: anObject [
	field := anObject
]

{ #category : #printing }
CZBibFieldMatches >> queryString [
	^ '(' , self field , ' matches ' , self patternAsString , ')'
]

{ #category : #public }
CZBibFieldMatches >> value: aBibEntry [
	^ self pattern match: ((aBibEntry at: field) rawValue)
]
