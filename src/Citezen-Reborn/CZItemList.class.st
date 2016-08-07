"
A simple element list. 
"
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

{ #category : #adding }
CZItemList >> addElements: aColOfElements [
	elements addAll: aColOfElements
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
