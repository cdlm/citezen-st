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

{ #category : #accessing }
CZSection >> name [
	
	^ name
]

{ #category : #accessing }
CZSection >> name: aString [
	
	name := aString
]

{ #category : #printing }
CZSection >> printOn: aStream [

	super printOn: aStream.
	name ifNotNil: [aStream nextPutAll: '('; nextPutAll: name; nextPutAll: ')']
]
