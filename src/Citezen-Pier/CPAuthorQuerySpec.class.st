Class {
	#name : #CPAuthorQuerySpec,
	#superclass : #CPQuerySpec,
	#instVars : [
		'authorRegex'
	],
	#category : #'Citezen-Pier'
}

{ #category : #defaults }
CPAuthorQuerySpec class >> defaultAuthorRegex [
	^ ''
]

{ #category : #accessing }
CPAuthorQuerySpec >> authorRegex [
	^ authorRegex
]

{ #category : #accessing }
CPAuthorQuerySpec >> authorRegex: aRegexString [
	authorRegex := aRegexString 
]

{ #category : #querying }
CPAuthorQuerySpec >> queryResultAsBibList [
	| papers authored edited |
	papers := super queryResultAsBibList.
	[authored := papers extractSatisfying: [:entry | entry matchesRegex: ('author\s*=[^=]*' , authorRegex) asRegexIgnoringCase].
	edited := papers extractSatisfying: [:entry | (entry matchesRegex: 'author\s*=' asRegexIgnoringCase) not
						and: [entry matchesRegex: ('editor\s*=[^=]*' , authorRegex) asRegexIgnoringCase]]]
		on: Error
		do: [ ^ super queryResultAsBibList ].
	^ authored + edited
]
