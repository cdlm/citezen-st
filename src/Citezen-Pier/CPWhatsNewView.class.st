Class {
	#name : #CPWhatsNewView,
	#superclass : #PRDefaultView,
	#instVars : [
		'whatsNew'
	],
	#category : #'Citezen-Pier'
}

{ #category : #initialization }
CPWhatsNewView >> initializeWhatsNewFrom: aContext [
	whatsNew ifNil:[ whatsNew := aContext structure ]
]

{ #category : #rendering }
CPWhatsNewView >> renderContentOn: html [
	| queryResult |
	whatsNew invariant
		ifTrue: [
			html paragraph: [ html text: 'Previous timestamp: ', whatsNew timestamp printString ].
			queryResult := whatsNew generateNews.
			queryResult ifNotNil: [ html render: queryResult ]]
		ifFalse: [
			html paragraph: [html strong: 'Required fields undefined. Please edit and and save.']]
	
]

{ #category : #seaside }
CPWhatsNewView >> setContext: aContext [ 
	super setContext: aContext.
	(aContext structure isKindOf: CPWhatsNew)
		ifTrue: [self initializeWhatsNewFrom: aContext]
]
