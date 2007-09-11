"
Render bibliographic entries to HTML using Seaside's canvas.

NB. Both BibHtmlRenderer and the canvas know about the stream, so using #setStream: after #html: will break stuff.
"
Class {
	#name : #BibHtmlRenderer,
	#superclass : #BibStreamRenderer,
	#instVars : [
		'html',
		'context',
		'document',
		'docRoot'
	],
	#category : 'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibHtmlRenderer class >> html: anHtmlCanvas [
	^ (self new)
		html: anHtmlCanvas;
		yourself
]

{ #category : #accessing }
BibHtmlRenderer >> contents [
	^ self html document stream contents
]

{ #category : #accessing }
BibHtmlRenderer >> html [
	^ html ifNil: [
		html := WAStaticHtmlCanvas document:
			(WAHtmlStreamDocument new stream: stream)]
]

{ #category : #accessing }
BibHtmlRenderer >> html: anHtmlCanvas [
	html := anHtmlCanvas.
	self setStream: html document stream
]

{ #category : #'visitor-double dispatch' }
BibHtmlRenderer >> visitBlockPhrase: aPhrase [
	self html div
		class: aPhrase name;
		with: [super visitBlockPhrase: aPhrase]
]

{ #category : #'visitor-double dispatch' }
BibHtmlRenderer >> visitFieldRef: aFieldRef [
	self html text: (currentEntry at: aFieldRef fieldName)
]

{ #category : #'visitor-double dispatch' }
BibHtmlRenderer >> visitLiteralPhrase: aPhrase [
	self html text: aPhrase text
]
