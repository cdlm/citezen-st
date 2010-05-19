Class {
	#name : #CZTitleElement,
	#superclass : #Object,
	#instVars : [
		'title',
		'htmlLevel'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZTitleElement >> acceptVisitor: aVisitor [
	aVisitor visitTitle: self
]

{ #category : #'as yet unclassified' }
CZTitleElement >> htmlLevel [
	^ htmlLevel 
]

{ #category : #'as yet unclassified' }
CZTitleElement >> htmlLevel: anInteger [
	| level |
	
	(anInteger <= 1)
		ifTrue: [ level := 1 ]
		ifFalse: [
			(anInteger >= 6)
				ifTrue: [ level := 6 ]
				ifFalse: [ level := anInteger ] ].
			
	htmlLevel := level 
]

{ #category : #'as yet unclassified' }
CZTitleElement >> initialize [
	title := self undefinedString.
	htmlLevel := 1
]

{ #category : #'as yet unclassified' }
CZTitleElement >> title [
	^ title
]

{ #category : #'as yet unclassified' }
CZTitleElement >> title: aString [
	(aString isNil)
		ifFalse: [ title := aString ]
		ifTrue: [ title := self undefinedString ]
]

{ #category : #'as yet unclassified' }
CZTitleElement >> undefinedString [
	^ 'UNDEFINED TITLE'
]
