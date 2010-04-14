Class {
	#name : #CZBibMatches,
	#superclass : #CZBibQuery,
	#instVars : [
		'pattern'
	],
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibMatches >> = aBibquery [
	^ self class = aBibquery class and: [ self pattern = aBibquery pattern ]
]

{ #category : #'accessing-private' }
CZBibMatches >> pattern [
	^ pattern
]

{ #category : #'accessing-private' }
CZBibMatches >> pattern: anObject [
	pattern := anObject
]

{ #category : #private }
CZBibMatches >> patternAsString [
	"surround with quotes and escape any embedded quotes"

	^ '"' , (self pattern copyWithRegex: '"' matchesReplacedWith: '\"') , '"'
]

{ #category : #printing }
CZBibMatches >> queryString [
	^ '(Entry matches ' , self patternAsString , ')'
]

{ #category : #public }
CZBibMatches >> value: aBibEntry [
	"^ aBibEntry matches: self pattern"
	self subclassResponsibility 
]
