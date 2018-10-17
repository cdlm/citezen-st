"
Just to have a link in a document.
For now it looks like it is not working. 
"
Class {
	#name : #CZLinkItem,
	#superclass : #CZDocElement,
	#instVars : [
		'name',
		'link'
	],
	#category : 'Citezen-Reborn-DocModel'
}

{ #category : #'as yet unclassified' }
CZLinkItem >> acceptVisitor: aVisitor [

	aVisitor visitItem: self.
]

{ #category : #'as yet unclassified' }
CZLinkItem >> link [
	
	^ link
]

{ #category : #'as yet unclassified' }
CZLinkItem >> link: aName [

	link := aName
]

{ #category : #'as yet unclassified' }
CZLinkItem >> name [

	^ name
]
