Class {
	#name : #BibTextRenderer,
	#superclass : #BibStreamRenderer,
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibTextRenderer >> text: aString [
	aString ifNil: [^ self].
	stream nextPutAll: aString
]

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitFieldRef: aFieldRef [
	self text: (currentEntry at: aFieldRef fieldName)
]

{ #category : #'visitor-double dispatch' }
BibTextRenderer >> visitLiteralPhrase: aPhrase [
	self text: aPhrase text
]
