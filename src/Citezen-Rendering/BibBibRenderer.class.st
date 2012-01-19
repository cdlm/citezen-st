"
A BibBibRenderer renders bibliographic objects back to BibTeX's .bib database format.
"
Class {
	#name : #BibBibRenderer,
	#superclass : #BibTextRenderer,
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibBibRenderer >> beginEntry: anEntry [
	self text: '@' , anEntry type , '{' , anEntry key ,',
'
]

{ #category : #rendering }
BibBibRenderer >> endEntry: anEntry [
	self text: '}'.
	super endEntry: anEntry
]

{ #category : #'visitor-double dispatch' }
BibBibRenderer >> visitFieldRef: aFieldRef [
	self text: aFieldRef fieldName; text: ' = '.
	aFieldRef fieldName = 'year' ifFalse: [
		self
			text: '{';
			text: (currentEntry at: aFieldRef fieldName) rawValue;
			text: '},'; newline
	]
	ifTrue: [
		self text: (currentEntry at: aFieldRef fieldName) rawValue; newline
	]
]

{ #category : #'visitor-double dispatch' }
BibBibRenderer >> visitLiteralPhrase: aPhrase [
" do nothing "
]
