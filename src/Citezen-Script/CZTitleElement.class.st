"
CZTitleElement represent a title in the output file.
Its representation depends on the output you choose.

CZTitleElement newTitle: 'Here is my title' htmlLevel: 3
can be reprensented by: 
- xHTML -> '<h3>Here is my title</h3>'
- BibTeX -> There are no titles in a bibtex file: it's ignored.

htmlLevel corresponds to a number between 1 and 6 (for the <h1> to <h6> tags).
"
Class {
	#name : #CZTitleElement,
	#superclass : #Object,
	#instVars : [
		'title',
		'htmlLevel'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZTitleElement class >> newTitle: aString [ 
	^ self new title: aString; yourself
]

{ #category : #'as yet unclassified' }
CZTitleElement class >> newTitle: aString htmlLevel: anInteger [
	^ self new title: aString; htmlLevel: anInteger; yourself
]

{ #category : #'as yet unclassified' }
CZTitleElement >> acceptVisitor: aVisitor [
	aVisitor visitTitle: self
]

{ #category : #'as yet unclassified' }
CZTitleElement >> htmlLevel [
	^ htmlLevel ifNil: [htmlLevel := 1]
]

{ #category : #'as yet unclassified' }
CZTitleElement >> htmlLevel: anInteger [
	htmlLevel := anInteger min: 6 max: 1
]

{ #category : #'as yet unclassified' }
CZTitleElement >> title [
	^ title ifNil: [title := '']
]

{ #category : #'as yet unclassified' }
CZTitleElement >> title: aString [
	title := aString
]
