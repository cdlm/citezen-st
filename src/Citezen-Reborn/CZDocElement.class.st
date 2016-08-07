"
A CZDocElement is a basic element used to build a document. 
It knows in particular its document. 

This hierarchy should probably replaced by pillar item ones.  Check CZDoc class comment.
"
Class {
	#name : #CZDocElement,
	#superclass : #Object,
	#instVars : [
		'doc'
	],
	#category : #'Citezen-Reborn-DocModel'
}

{ #category : #visiting }
CZDocElement >> acceptVisitor: aVisitor [

	self subclassResponsibility
]

{ #category : #accessing }
CZDocElement >> doc: aDocument [

	doc := aDocument
]
