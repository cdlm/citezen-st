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

{ #category : #'visitor-double dispatch' }
BibSequencePhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitSequencePhrase: self
]

{ #category : #accessing }
BibSequencePhrase >> addAll: phrasesCollection [
	^ subPhrases addAll: phrasesCollection
]

{ #category : #initializing }
BibSequencePhrase >> initialize [
	subPhrases := OrderedCollection new
]

{ #category : #accessing }
BibSequencePhrase >> initiator [
	^ initiator
]

{ #category : #initializing }
BibSequencePhrase >> initiator: anObject [
	initiator := anObject
]

{ #category : #accessing }
BibSequencePhrase >> lastSeparator [
	lastSeparator ifNotNil: [^ lastSeparator].
	^ separator
]

{ #category : #initializing }
BibSequencePhrase >> lastSeparator: anObject [
	lastSeparator := anObject
]

{ #category : #accessing }
BibSequencePhrase >> separator [
	^ separator
]

{ #category : #initializing }
BibSequencePhrase >> separator: anObject [
	separator := anObject
]

{ #category : #accessing }
BibSequencePhrase >> size [
	^ subPhrases size
]

{ #category : #accessing }
BibSequencePhrase >> subPhrases [
	^ subPhrases
]

{ #category : #accessing }
BibSequencePhrase >> terminator [
	^ terminator
]

{ #category : #initializing }
BibSequencePhrase >> terminator: anObject [
	terminator := anObject
]
