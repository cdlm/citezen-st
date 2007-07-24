Class {
	#name : #BibBibRenderer,
	#superclass : #BibTextRenderer,
	#instVars : [
		'showBlocks'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibBibRenderer >> basicText: aString [
	super text: aString
]

{ #category : #rendering }
BibBibRenderer >> block: aBlock [
	aBlock value
]

{ #category : #'initialize-release' }
BibBibRenderer >> initialize [
	super initialize.
]

{ #category : #rendering }
BibBibRenderer >> render: aPhrase for: anEntry [
	self basicText: '@' , anEntry type , '(' , anEntry key ,',
'.
	super render: aPhrase for: anEntry.
	self basicText: ')

'
]

{ #category : #rendering }
BibBibRenderer >> text: aString [
	super text: aString
]

{ #category : #'visitor-double dispatch' }
BibBibRenderer >> visitFieldRef: aFieldRef [
	self text: aFieldRef fieldName.
	self text: ' = '.
	aFieldRef fieldName = 'year' ifFalse: [
		self text: '{'.
		self text: (entry at: aFieldRef fieldName).
		self text: '}',',',String cr
	]
	ifTrue: [
		self text: (entry at: aFieldRef fieldName).
		self text: String cr
	]
]

{ #category : #'visitor-double dispatch' }
BibBibRenderer >> visitLiteralPhrase: aPhrase [
" do nothing "
]
