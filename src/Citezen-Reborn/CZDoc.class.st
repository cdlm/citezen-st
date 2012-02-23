Class {
	#name : #CZDoc,
	#superclass : #Object,
	#instVars : [
		'elements',
		'title'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #'initialize-release' }
CZDoc >> add: anElement [

	elements add: anElement.
	anElement doc: self.
	^ anElement
]

{ #category : #configuration }
CZDoc >> autonomousNumbering [
]

{ #category : #configuration }
CZDoc >> continuousNumbering [
	
]

{ #category : #configuration }
CZDoc >> defaultTitle [

	^ '  '
]

{ #category : #accessing }
CZDoc >> elements [

	^ elements
]

{ #category : #'initialize-release' }
CZDoc >> initialize [

	super initialize.
	elements := OrderedCollection new.
	self title: self defaultTitle
	
]

{ #category : #accessing }
CZDoc >> title [

	^ title
	
]

{ #category : #accessing }
CZDoc >> title: aName [

	title := aName
	
]
