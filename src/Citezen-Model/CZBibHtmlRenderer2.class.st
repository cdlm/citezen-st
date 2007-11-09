Class {
	#name : #CZBibHtmlRenderer2,
	#superclass : #BibStreamRenderer,
	#instVars : [
		'html'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'as yet unclassified' }
CZBibHtmlRenderer2 class >> html: anHtmlCanvas [
	^ (self new)
		html: anHtmlCanvas;
		yourself
]

{ #category : #accessing }
CZBibHtmlRenderer2 >> contents [
	^ self html document stream contents
]

{ #category : #accessing }
CZBibHtmlRenderer2 >> html [
	^html
]

{ #category : #accessing }
CZBibHtmlRenderer2 >> html: aHtmlCanvas [
	html _ aHtmlCanvas.
	self setStream: html document stream
]

{ #category : #'visitor-double dispatch' }
CZBibHtmlRenderer2 >> visitEntry: anEntry [

	self html listItem
		class: 'entry';
		with: [super visitEntry: anEntry]
]

{ #category : #'visitor-double dispatch' }
CZBibHtmlRenderer2 >> visitFieldRef: aFieldRef [
	| text |
	text _ (currentEntry at: aFieldRef fieldName) value.
	text _ text reject: [:each | each = ${ or: [each = $}]].

	text _ text copyReplaceAll: '\''e' with: '&eacute;' asTokens: false.
	text _ text copyReplaceAll: '\^i' with: '&icirc;' asTokens: false.
	text _ text copyReplaceAll: '\^\i' with: '&icirc;' asTokens: false.
	
	(aFieldRef fieldName = 'title' and: [currentEntry hasField: 'url'])
		ifTrue: [self html anchor url: (currentEntry at: 'url') value; with: text]
		ifFalse: [self html html: text.]
]

{ #category : #'visitor-double dispatch' }
CZBibHtmlRenderer2 >> visitLiteralPhrase: aPhrase [
	self html text: (aPhrase text reject: [:each | each = ${ or: [each = $}]])
]

{ #category : #'visitor-double dispatch' }
CZBibHtmlRenderer2 >> visitNamedPhrase: aPhrase [ 
	self html span
		class: aPhrase name;
		with: [super visitNamedPhrase: aPhrase]
]
