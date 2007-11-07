Class {
	#name : #CZGroup,
	#superclass : #CZNode,
	#instVars : [
		'name',
		'isBlock',
		'children'
	],
	#category : #'Citezen-Rendering2'
}

{ #category : #'instance creation' }
CZGroup class >> blockNamed: aString [
	^ self new name: aString; beBlock; yourself
]

{ #category : #'instance creation' }
CZGroup class >> fromGroup: aGroup nodes: aCollection [
	| instance |
	instance := (self nodes: aCollection).
	instance name: aGroup name;	origin: aGroup origin.
	aGroup isVolatile ifTrue: [instance beVolatile].
	aGroup isBlock ifTrue: [instance beBlock].
	^ instance
]

{ #category : #'instance creation' }
CZGroup class >> named: aString [
	^ self new name: aString; yourself
]

{ #category : #'instance creation' }
CZGroup class >> nodes: aCollection [
	^ self new
		nodes: aCollection;
		yourself
]

{ #category : #adding }
CZGroup >> add: aNode [ 
	children add: aNode
]

{ #category : #testing }
CZGroup >> allVolatiles [
	^ children allSatisfy: [:it | it isVolatile] "true even if empty"
]

{ #category : #rendering }
CZGroup >> asGroup [
	^ self
]

{ #category : #'initialize-release' }
CZGroup >> beBlock [
	isBlock := true
]

{ #category : #'initialize-release' }
CZGroup >> initialize [
	super initialize.
	isBlock := false.
	children := OrderedCollection new
]

{ #category : #testing }
CZGroup >> isEmpty [
	^ children isEmpty
]

{ #category : #testing }
CZGroup >> isPlain [
	^ name isNil
		and: [origin isNil]
		and: [self isBlock not]
]

{ #category : #accessing }
CZGroup >> name: aString [
	name := aString
]

{ #category : #'initialize-release' }
CZGroup >> nodes: aCollection [ 
	children := aCollection
]

{ #category : #rendering }
CZGroup >> streamFrom: anEntry to: aNodeStream [ 
	(self isEmpty or: [self allVolatiles]) 
		ifFalse: 
			[self isPlain 
				ifTrue: [aNodeStream nextPutAll: children]
				ifFalse: [aNodeStream nextPut: self asGroup]]
]
