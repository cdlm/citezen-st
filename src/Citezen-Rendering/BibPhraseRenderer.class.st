Class {
	#name : #BibPhraseRenderer,
	#superclass : #BibPhraseVisitor,
	#instVars : [
		'stream',
		'currentEntry'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibPhraseRenderer class >> on: aStream [
	^ self new stream: aStream; yourself
]

{ #category : #accessing }
BibPhraseRenderer >> contents [
	^ stream contents
]

{ #category : #'initialize-release' }
BibPhraseRenderer >> initialize [
	super initialize.
	stream := WriteStream on: String new
]

{ #category : #rendering }
BibPhraseRenderer >> render: aPhrase for: anEntry [
	|evaluatedPhrase|
	evaluatedPhrase := BibPhraseEvaluator evaluate: aPhrase for: anEntry.
	evaluatedPhrase ifNil: [^ self].
	self visit: evaluatedPhrase
]

{ #category : #'initialize-release' }
BibPhraseRenderer >> setStream: aStream [
	stream := aStream
]
