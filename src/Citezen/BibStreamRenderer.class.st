Class {
	#name : #BibStreamRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'stream'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibStreamRenderer class >> on: aStream [
	^ self new stream: aStream; yourself
]

{ #category : #accessing }
BibStreamRenderer >> contents [
	^ stream contents
]

{ #category : #'initialize-release' }
BibStreamRenderer >> initialize [
	super initialize.
	stream := WriteStream on: String new
]

{ #category : #'initialize-release' }
BibStreamRenderer >> setStream: aStream [
	stream := aStream
]
