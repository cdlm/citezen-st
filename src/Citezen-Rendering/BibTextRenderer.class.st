"
BibTextRenderer renders bibliographic objects to plain-text-based formats.
"
Class {
	#name : #BibTextRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'stream'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibTextRenderer class >> on: aStream [
	^ self new stream: aStream; yourself
]

{ #category : #rendering }
BibTextRenderer >> beginEntry: anEntry [
	"do nothing"
]

{ #category : #accessing }
BibTextRenderer >> contents [
	^ stream contents
]

{ #category : #rendering }
BibTextRenderer >> endEntry: anEntry [
	self newline; newline
]

{ #category : #'initialize-release' }
BibTextRenderer >> initialize [
	super initialize.
	self setStream: (WriteStream on: String new)
]

{ #category : #rendering }
BibTextRenderer >> newline [
	stream cr
]

{ #category : #'initialize-release' }
BibTextRenderer >> setStream: aStream [
	stream := aStream
]

{ #category : #rendering }
BibTextRenderer >> text: aString [
	aString ifNil: [^ self].
	stream nextPutAll: aString asString
]

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitEntry: anEntry [
	self beginEntry: anEntry.
	super visitEntry: anEntry.
	self endEntry: anEntry

]
