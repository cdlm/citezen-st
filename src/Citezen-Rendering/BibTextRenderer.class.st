Class {
	#name : #BibTextRenderer,
	#superclass : #BibPhraseRenderer,
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
BibTextRenderer >> visitSequencePhrase: aSequencePhrase [
	|remainingSize|
	remainingSize := aSequencePhrase subPhrases size.
	remainingSize > 0 ifTrue: [
		self text: aSequencePhrase initiator.
		aSequencePhrase subPhrases
			do: [:each | self visit: each]
			separatedBy: [
				remainingSize := remainingSize - 1. "count down to last separator"
				self text:
					(remainingSize = 1
						ifTrue: [aSequencePhrase lastSeparator]
						ifFalse: [aSequencePhrase separator])].
		self text: aSequencePhrase terminator
	]
]
