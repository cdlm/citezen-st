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
	^ (self new)
		addAll: aCollection;
		yourself
]

{ #category : #'visitor-double dispatch' }
BibSequencePhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitSequencePhrase: self
]

{ #category : #accessing }
BibSequencePhrase >> add: aPhrase [ 
	^ subPhrases add: aPhrase
]

{ #category : #accessing }
BibSequencePhrase >> addAll: phrasesCollection [ 
	^ subPhrases addAll: phrasesCollection
]

{ #category : #enumerating }
BibSequencePhrase >> do: aBlock [
	"iterates through 'virtual elements', eg. including necessary separators etc."
	|remainingSize|
	remainingSize := subPhrases size.
	remainingSize > 0 ifTrue: [
		self initiatorDo: aBlock.
		subPhrases
			do: [:each | aBlock value: each]
			separatedBy: [
				remainingSize := remainingSize - 1. "count down to last separator"
				remainingSize = 1
					ifTrue: [self lastSeparatorDo: aBlock]
					ifFalse: [self separatorDo: aBlock]].
		self terminatorDo: aBlock
	]
]

{ #category : #'initialize-release' }
BibSequencePhrase >> initialize [
	super initialize.
	subPhrases := OrderedCollection new
]

{ #category : #accessing }
BibSequencePhrase >> initiator [
	^ initiator
]

{ #category : #accessing }
BibSequencePhrase >> initiator: aPhrase [
	initiator := aPhrase
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> initiatorDo: aBlock [
	^ self initiator ifNotNilDo: aBlock
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> initiatorText: aString [
	initiator := BibLiteralPhrase text: aString
]

{ #category : #accessing }
BibSequencePhrase >> internalLastSeparator [
	^ lastSeparator
]

{ #category : #accessing }
BibSequencePhrase >> lastSeparator [
	lastSeparator ifNil: [^ separator].
	^ lastSeparator
]

{ #category : #accessing }
BibSequencePhrase >> lastSeparator: aPhrase [
	lastSeparator := aPhrase
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> lastSeparatorDo: aBlock [ 
	^ self internalLastSeparator ifNotNilDo: aBlock
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> lastSeparatorText: aString [
	lastSeparator := BibLiteralPhrase text: aString
]

{ #category : #accessing }
BibSequencePhrase >> separator [
	^ separator
]

{ #category : #accessing }
BibSequencePhrase >> separator: aPhrase [
	separator := aPhrase
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> separatorDo: aBlock [
	^ self separator ifNotNilDo: aBlock
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> separatorText: aString [
	separator := BibLiteralPhrase text: aString
]

{ #category : #accessing }
BibSequencePhrase >> subPhrases [
	^ subPhrases
]

{ #category : #accessing }
BibSequencePhrase >> terminator [
	^ terminator
]

{ #category : #accessing }
BibSequencePhrase >> terminator: aPhrase [
	terminator := aPhrase
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> terminatorDo: aBlock [
	^ self terminator ifNotNilDo: aBlock
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> terminatorText: aString [
	terminator := BibLiteralPhrase text: aString
]
