"
Defines scope for macro definitions. For instance base definitions for month macros are (erm, should be) defined in a constant BibSet that is the top scope.
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
CZScoped >> lookupMacroAt: aKey [
	"Return the value of macro named aKey, looking up the scope chain if necessary."
	^ self lookupMacroAt: aKey ifAbsent: [CZField undefined: aKey]
]

{ #category : #accessing }
CZScoped >> lookupMacroAt: aKey ifAbsent: aBlock [
	"Look up the scope chain for the value of macro named aKey."
	^ scope isNil
		ifTrue: [aBlock value]
		ifFalse: [scope lookupMacroAt: aKey ifAbsent: aBlock]
]

{ #category : #accessing }
CZScoped >> scope [
	^ scope
]

{ #category : #accessing }
CZScoped >> scope: aBibStructure [
	scope := aBibStructure
]
