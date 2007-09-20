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
	^ anObject isCollection
		ifTrue: [CZGroup nodes: anObject]
		ifFalse: [CZText text: anObject]
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
