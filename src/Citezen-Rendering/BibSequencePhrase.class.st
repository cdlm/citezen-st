"
A BibSequencePhrase presents its sub-phrases in a sequence, with configurable decorations between the elements or around the whole sequence.

This is useful for e.g. enumerating authors. i.e. in ""W, X, Y, and Z."" there is no initiator, comma-space as a separator, ', and ' as a lastSeparator, and period as a terminator.
"
Class {
	#name : #BibSequencePhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'subphrases',
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
	^ subphrases add: aPhrase
]

{ #category : #accessing }
BibSequencePhrase >> addAll: phrasesCollection [ 
	^ subphrases addAll: phrasesCollection
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> addBlockWithField: aFieldName [ 
	self add: ((BibFieldRef field: aFieldName) blockNamed: aFieldName)
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> addField: aFieldName [
	self add: (BibFieldRef field: aFieldName)
]

{ #category : #'accessing-convenience' }
BibSequencePhrase >> addFields: aCollection [
	aCollection do: [:each | self addField: each]
]

{ #category : #enumerating }
BibSequencePhrase >> do: aBlock [ 
	| remainingSize |
	remainingSize := subphrases size.
	remainingSize > 0 
		ifTrue: 
			[self initiatorDo: aBlock.
			subphrases do: [:each | aBlock value: each]
				separatedBy: 
					[remainingSize := remainingSize - 1.
					remainingSize = 1 
						ifTrue: [self lastSeparatorDo: aBlock]
						ifFalse: [self separatorDo: aBlock]].
			self terminatorDo: aBlock]
]

{ #category : #enumerating }
BibSequencePhrase >> do: aBlock for: anEntry [
	| remainingSize actualSubphrases |
	actualSubphrases := subphrases reject: [:each |
		BibPhrasePrunableEvaluator new entry: anEntry; visit: each ].
	remainingSize := actualSubphrases size.
	remainingSize > 0 
		ifTrue: 
			[self initiatorDo: aBlock.
			actualSubphrases do: [:each | aBlock value: each]
				separatedBy: 
					[remainingSize := remainingSize - 1.
					remainingSize = 1 
						ifTrue: [self lastSeparatorDo: aBlock]
						ifFalse: [self separatorDo: aBlock]].
			self terminatorDo: aBlock]
]

{ #category : #'initialize-release' }
BibSequencePhrase >> initialize [
	super initialize.
	subphrases := OrderedCollection new
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
	^ self lastSeparator ifNotNilDo: aBlock
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
BibSequencePhrase >> subphrases [
	^ subphrases
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
