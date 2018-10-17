"
A BibPhrase referencing a single CZField.

This specifies the placement of that field in the enclosing phrase; the field will then be rendered by name, value, or other wise by a format-specific renderer visiting the phrase.
"
Class {
	#name : #BibFieldRef,
	#superclass : #BibPhrase,
	#instVars : [
		'fieldName'
	],
	#category : 'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibFieldRef class >> field: aSymbol [
	^ self new fieldName: aSymbol; yourself
]

{ #category : #'visitor-double dispatch' }
BibFieldRef >> acceptVisitor: aVisitor [
	^ aVisitor visitFieldRef: self
]

{ #category : #accessing }
BibFieldRef >> fieldName [
	^ fieldName
]

{ #category : #accessing }
BibFieldRef >> fieldName: aSymbol [
	fieldName := aSymbol
]

{ #category : #printing }
BibFieldRef >> printString [
	^ super printString , '(' , self fieldName printString , ')'
]
