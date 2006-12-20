Class {
	#name : #BibSequencePhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'subPhrases',
		'initiator',
		'separator',
		'lastSeparator',
		'terminator'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibSequencePhrase class >> with: aCollection [
	^ self new addAll: aCollection; yourself
]

{ #category : #accessing }
BibSequencePhrase >> addAll: phrasesCollection [
	^ subPhrases addAll: phrasesCollection
]

{ #category : #initializing }
BibSequencePhrase >> initialize [
	subPhrases := OrderedCollection new
]

{ #category : #initializing }
BibSequencePhrase >> initiator: anObject [
	initiator := anObject
]

{ #category : #initializing }
BibSequencePhrase >> lastSeparator: anObject [
	lastSeparator := anObject
]

{ #category : #templating }
BibSequencePhrase >> renderEntry: anEntry using: aRenderer [
	|subSize|
	subSize := subPhrases size.
	subSize > 0 ifTrue: [
		initiator ifNotNil: [aRenderer text: initiator].
		subPhrases
			do: [:each | each renderEntry: anEntry using: aRenderer]
			separatedBy: [
				subSize := subSize - 1. "count down to last separator"
				subSize = 1
					ifTrue: [self renderLastSeparatorUsing: aRenderer]
					ifFalse: [self renderSeparatorUsing: aRenderer]].
		terminator ifNotNil: [aRenderer text: terminator]
	]
]

{ #category : #templating }
BibSequencePhrase >> renderLastSeparatorUsing: aRenderer [
	lastSeparator ifNil: [^ self renderSeparatorUsing: aRenderer].
	aRenderer text: lastSeparator
	
]

{ #category : #templating }
BibSequencePhrase >> renderSeparatorUsing: aRenderer [
	separator ifNotNil: [aRenderer text: separator]
	
]

{ #category : #initializing }
BibSequencePhrase >> separator: anObject [
	separator := anObject
]

{ #category : #initializing }
BibSequencePhrase >> terminator: anObject [
	terminator := anObject
]
