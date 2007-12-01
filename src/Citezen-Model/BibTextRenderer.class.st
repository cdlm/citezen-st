Class {
	#name : #BibTextRenderer,
	#superclass : #BibStreamRenderer,
	#category : 'Citezen-Rendering'
}

{ #category : #rendering }
BibTextRenderer >> beginEntry: anEntry [
	"do nothing"
]

{ #category : #rendering }
BibTextRenderer >> block: aBlock [
	aBlock value
]

{ #category : #rendering }
BibTextRenderer >> endEntry: anEntry [
	self newline; newline
]

{ #category : #rendering }
BibTextRenderer >> newline [
	stream cr
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

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitLiteralPhrase: aPhrase [
	self text: aPhrase text
]

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitNamedPhrase: aPhrase [ 
	self block: [super visitNamedPhrase: aPhrase]
]
