Class {
	#name : #BibBblRenderer,
	#superclass : #BibTextRenderer,
	#instVars : [
		'showBlocks'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #rendering }
BibBblRenderer >> basicText: aString [
	super text: aString
]

{ #category : #rendering }
BibBblRenderer >> block: aBlock [
	showBlocks ifTrue: [
		self basicText: '
\newblock '
	].
	aBlock value
]

{ #category : #'initialize-release' }
BibBblRenderer >> initialize [
	super initialize.
	showBlocks := false
]

{ #category : #rendering }
BibBblRenderer >> render: aPhrase for: anEntry [
	showBlocks := false.
	self basicText: '\bibitem[displayKey]{' , anEntry key , '}
'. "need display key here"
	super render: aPhrase for: anEntry.
	self basicText: '

'
]

{ #category : #rendering }
BibBblRenderer >> text: aString [
	showBlocks := true.
	super text: aString
]

{ #category : #'visitor-double dispatch' }
BibBblRenderer >> visitBlockPhrase: aPhrase [
	self block: [super visitBlockPhrase: aPhrase]
]
