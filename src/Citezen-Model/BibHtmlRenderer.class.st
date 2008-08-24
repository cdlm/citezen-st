"
Render bibliographic entries to HTML using Seaside's canvas.

NB. Both BibHtmlRenderer and the canvas know about the stream, so using #setStream: after #html: will break stuff.
"
Class {
	#name : #BibHtmlRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'html'
	],
	#category : #'Citezen-Rendering'
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
			(WAHtmlStreamDocument new stream: (String new writeStream))]
]

{ #category : #accessing }
BibHtmlRenderer >> html: anHtmlCanvas [
	html := anHtmlCanvas
]

{ #category : #'visitor-double dispatch' }
BibHtmlRenderer >> text: aString [
	aString ifNil: [^ self].
	self html text: aString asString
]

{ #category : #'visitor-double dispatch' }
BibHtmlRenderer >> visitNamedPhrase: aPhrase [ 
	(aPhrase isBlock ifTrue: [self html div] ifFalse: [self html span])
		class: aPhrase name;
		with: [super visitNamedPhrase: aPhrase]
]
