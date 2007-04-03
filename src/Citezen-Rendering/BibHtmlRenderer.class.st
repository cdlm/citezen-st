Class {
	#name : #BibHtmlRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'html'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibHtmlRenderer class >> on: anHtmlCanvas [
	^ self new html: anHtmlCanvas
]

{ #category : #accessing }
BibHtmlRenderer >> contents [
	^html document stream contents
]

{ #category : #accessing }
BibHtmlRenderer >> html [
	^ html
]

{ #category : #'initialize-release' }
BibHtmlRenderer >> html: anHtmlCanvas [
	html := anHtmlCanvas
]

{ #category : #'visitor-double dispatch' }
BibHtmlRenderer >> visitBlockPhrase: aPhrase [
	html div
		class: aPhrase name;
		with: [super visitBlockPhrase: aPhrase]
]

{ #category : #'visitor-double dispatch' }
BibHtmlRenderer >> visitLiteralPhrase: aPhrase [
	html text: aPhrase text
]
