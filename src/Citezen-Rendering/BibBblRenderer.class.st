"
Renders bibliographic objects to the .bbl format used by LaTeX & BibTeX.
"
Class {
	#name : #BibBblRenderer,
	#superclass : #BibTextRenderer,
	#instVars : [
		'firstBlock'
	],
	#category : 'Citezen-Rendering'
}

{ #category : #rendering }
BibBblRenderer >> beginEntry: anEntry [
	self flag: 'TODO compute displayKey'.
	self
		text: '\bibitem[displayKey]{' , anEntry key , '}';
		newline.
	firstBlock := true.

]

{ #category : #rendering }
BibBblRenderer >> block: aBlock [
	firstBlock ifFalse: [self newline; text: '\newblock '].
	aBlock value.
	"firstBlock := false is done in #text: instead of here because phrases have nested blocks"
]

{ #category : #'initialize-release' }
BibBblRenderer >> initialize [
	super initialize.
	firstBlock := true
]

{ #category : #rendering }
BibBblRenderer >> text: aString [
	super text: aString.
	firstBlock := false
]
