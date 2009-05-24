"
I implement the specialized query for the MissingInfoPage.
"
Class {
	#name : #CPMissingInfoQuerySpec,
	#superclass : #CPQuerySpec,
	#instVars : [
		'requiredInfoRegex'
	],
	#category : #'Citezen-Pier'
}

{ #category : #defaults }
CPMissingInfoQuerySpec class >> defaultRequiredInfoRegex [
	^ ''
]

{ #category : #querying }
CPMissingInfoQuerySpec >> queryResultAsBibList [
	| papers missing |
	papers := super queryResultAsBibList.
	[ missing := papers extractSatisfying: [:entry | (entry matchesRegex: requiredInfoRegex asRegexIgnoringCase) not ] ]
		on: Error
		do: [ ^ CPBibList new ].
	^ missing
]

{ #category : #accessing }
CPMissingInfoQuerySpec >> requiredInfoRegex [
	^ requiredInfoRegex
]

{ #category : #accessing }
CPMissingInfoQuerySpec >> requiredInfoRegex: aRegexString [
	requiredInfoRegex := aRegexString
]

{ #category : #'initialize-release' }
CPMissingInfoQuerySpec >> setDefaults [
	super setDefaults.
	self requiredInfoRegex: self class defaultRequiredInfoRegex
]
