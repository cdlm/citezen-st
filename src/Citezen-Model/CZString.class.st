"
A CZString represents a string value in a BibTeX field.
"
Class {
	#name : #CZString,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #default }
CZString class >> defaultValue [
	^ self with: ''
]

{ #category : #visiting }
CZString >> acceptVisitor: aVisitor [
	aVisitor visitString: self
]

{ #category : #accessing }
CZString >> expanded [
	^ value asString reject: [ :each | each = ${ or: [ each = $} ] ]
]
