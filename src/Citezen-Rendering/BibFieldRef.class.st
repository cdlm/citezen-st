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

{ #category : #accessing }
BibFieldRef >> fieldName [
	^ fieldName
]

{ #category : #accessing }
BibFieldRef >> fieldName: aSymbol [
	fieldName := aSymbol
]

{ #category : #templating }
BibFieldRef >> renderEntry: anEntry using: aRenderer [
	aRenderer text: (anEntry at: self fieldName)
]
