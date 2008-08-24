Class {
	#name : #CZNode,
	#superclass : #Object,
	#instVars : [
		'origin',
		'isVolatile'
	],
	#category : #'Citezen-Rendering2'
}

{ #category : #'instance creation' }
CZNode class >> from: anObject [
	^ (anObject isString or: [anObject isNumber])
		ifTrue: [CZText text: anObject]
		ifFalse: [CZGroup nodes: anObject]
]

{ #category : #'initialize-release' }
CZNode >> beVolatile [
	isVolatile := true
]

{ #category : #'initialize-release' }
CZNode >> initialize [
	super initialize.
	isVolatile := false
]

{ #category : #accessing }
CZNode >> isVolatile [
	^ isVolatile
]

{ #category : #accessing }
CZNode >> origin [
	^ origin
]

{ #category : #'initialize-release' }
CZNode >> origin: anObject [ 
	origin := anObject
]

{ #category : #rendering }
CZNode >> streamFrom: anEntry to: aNodeStream [ 
	self subclassResponsibility
]
