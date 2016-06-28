"
Since a bibentry is also used inside documents,  there is a need to have a document structure. A CZDoc is document composed of CZDocElements.
A CZDoc is built using a CZDocBuilder which is able to add entries (bibentries) structured as sections or other in a document. 

I'm also a walkable structure using a CZVisitor.


This model should probably be removed and pillar model should be used. 

"
Class {
	#name : #CZDoc,
	#superclass : #Object,
	#instVars : [
		'elements',
		'title',
		'header',
		'footer'
	],
	#category : #'Citezen-Reborn-DocModel'
}

{ #category : #visitor }
CZDoc >> acceptVisitor: aVisitor [

	aVisitor visitDoc: self.
]

{ #category : #'initialize-release' }
CZDoc >> add: anElement [

	elements add: anElement.
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

{ #category : #accessing }
CZDoc >> footer [
	^ footer
]

{ #category : #accessing }
CZDoc >> footer: anObject [
	footer := anObject
]

{ #category : #accessing }
CZDoc >> header [
	^ header
]

{ #category : #accessing }
CZDoc >> header: anObject [
	header := anObject
]

{ #category : #'initialize-release' }
CZDoc >> initialize [

	super initialize.
	elements := OrderedCollection new.
	self title: self defaultTitle.
	
	"not cool to define a footer for nothing but like that the visitor can walk 
	without tests"
	footer := CZFooter new.
	header := CZHeader new
	
]

{ #category : #accessing }
CZDoc >> title [

	^ title
	
]

{ #category : #accessing }
CZDoc >> title: aString [

	title := CZString with: aString
	
]
