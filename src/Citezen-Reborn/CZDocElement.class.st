"
A CZDocElement is a basic element used to build a document. 
It knows in particular its document. 
"
Class {
	#name : #CZDocElement,
	#superclass : #Object,
	#instVars : [
		'doc'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #visiting }
CZDocElement >> acceptVisitor: aVisitor [

	self subclassResponsibility
]

{ #category : #accessing }
CZDocElement >> doc: aDocument [

	doc := aDocument
]
