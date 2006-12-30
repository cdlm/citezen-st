Class {
	#name : #BibHtmlRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'html'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #accessing }
BibHtmlRenderer >> contents [
	^ html document close stream contents
]

{ #category : #'initialize-release' }
BibHtmlRenderer >> initialize [
	super initialize.
	html := WAStaticHtmlCanvas root: WAHtmlRoot new
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
