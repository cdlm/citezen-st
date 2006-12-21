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

{ #category : #initialization }
BibPhraseRenderer >> initialize [
	stream := WriteStream on: String new
]

{ #category : #rendering }
BibPhraseRenderer >> render: aPhrase for: anEntry [ 
	currentEntry := anEntry.
	self visit: aPhrase
]

{ #category : #initialization }
BibPhraseRenderer >> setStream: aStream [
	stream := aStream
]
