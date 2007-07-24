Class {
	#name : #BibTextRenderer,
	#superclass : #BibStreamRenderer,
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibTextRenderer >> text: aString [
	aString ifNil: [^ self].
	stream nextPutAll: aString asString
]

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitEntry: anEntry [
	super visitEntry: anEntry.
	self text: '

'
]

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitFieldRef: aFieldRef [
	self text: (entry at: aFieldRef fieldName)
]

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitLiteralPhrase: aPhrase [
	self text: aPhrase text
]
