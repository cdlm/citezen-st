Class {
	#name : #CZItemList,
	#superclass : #CZDocElement,
	#instVars : [
		'elements'
	],
	#category : #'Citezen-Reborn-DocModel'
}

{ #category : #visiting }
CZItemList >> acceptVisitor: aVisitor [

	aVisitor visitItemList: self
]

{ #category : #adding }
CZItemList >> addElement: anElement [

	elements add: anElement
]

{ #category : #accessing }
CZItemList >> elements [

	^ elements
]

{ #category : #initialization }
CZItemList >> initialize [

	super initialize.
	elements := OrderedCollection new.
]
