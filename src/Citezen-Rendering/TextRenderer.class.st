Class {
	#name : #TextRenderer,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
TextRenderer class >> on: aStream [
	^ self new stream: aStream; yourself
]

{ #category : #accessing }
TextRenderer >> contents [
	^ stream contents
]

{ #category : #initialization }
TextRenderer >> initialize [
	stream := WriteStream on: String new
]

{ #category : #initialization }
TextRenderer >> setStream: aStream [
	stream := aStream
]

{ #category : #rendering }
TextRenderer >> text: aString [
	stream nextPutAll: aString
]
