"
Defines scope for macro definitions. For instance base definitions for month macros are (erm, will be) defined in a constant BibSet that is the top scope.
"
Class {
	#name : #BibStructure,
	#superclass : #Object,
	#instVars : [
		'scope'
	],
	#category : 'Citezen-Model'
}

{ #category : #testing }
BibStructure class >> isAbstract [
	^ true
]

{ #category : #accessing }
BibStructure >> scope [
	^ scope
]

{ #category : #accessing }
BibStructure >> scope: aBibStructure [
	scope := aBibStructure
]
