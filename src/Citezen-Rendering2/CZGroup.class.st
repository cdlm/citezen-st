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
CZGroup class >> named: aString [
	^ self new name: aString; yourself
]

{ #category : #adding }
CZGroup >> add: aNode [ 
	children add: aNode
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

{ #category : #accessing }
CZGroup >> name: aString [
	name := aString
]

{ #category : #'initialize-release' }
CZGroup >> nodes: aCollection [ 
	children := aCollection
]
