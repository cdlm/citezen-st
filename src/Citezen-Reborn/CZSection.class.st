"
A CZSection is a document section mainly a name.
"
Class {
	#name : #CZSection,
	#superclass : #CZDocElement,
	#instVars : [
		'name'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #visiting }
CZSection >> acceptVisitor: aVisitor [

	aVisitor visitSection: self
]

{ #category : #deprecated }
CZSection >> name [
	"deprecated"
	
	^ name
]

{ #category : #deprecated }
CZSection >> name: aString [
	"deprecated"
	
	name := aString
]

{ #category : #printing }
CZSection >> printOn: aStream [

	super printOn: aStream.
	name ifNotNil: [aStream nextPutAll: '('; nextPutAll: name; nextPutAll: ')']
]

{ #category : #accessing }
CZSection >> title [
	
	^ name
]

{ #category : #accessing }
CZSection >> title: aString [
	
	name := aString
]
