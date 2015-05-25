Class {
	#name : #CZLinkItem,
	#superclass : #CZDocElement,
	#instVars : [
		'name',
		'link'
	],
	#category : #'Citezen-Reborn'
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
