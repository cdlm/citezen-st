Class {
	#name : #BibFieldRef,
	#superclass : #BibPhrase,
	#instVars : [
		'fieldName'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibFieldRef class >> name: aSymbol [
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
