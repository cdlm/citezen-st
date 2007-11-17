"
Defines scope for macro definitions. For instance base definitions for month macros are (erm, will be) defined in a constant BibSet that is the top scope.
"
Class {
	#name : #CZScoped,
	#superclass : #Object,
	#instVars : [
		'scope'
	],
	#category : #'Citezen-Model'
}

{ #category : #testing }
CZScoped class >> isAbstract [
	^ true
]

{ #category : #accessing }
CZScoped >> scope [
	^ scope
]

{ #category : #accessing }
CZScoped >> scope: aBibStructure [
	scope := aBibStructure
]
