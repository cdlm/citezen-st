Class {
	#name : #CZBibEntryHtmlView,
	#superclass : #PRDefaultView,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'as yet unclassified' }
CZBibEntryHtmlView class >> isValidIn: aContext [
	^ (super isValidIn: aContext) and: [ aContext structure isKindOf: CZBibEntry ]
]

{ #category : #accessing }
CZBibEntryHtmlView >> entry [
	^entry ifNil: [entry := (self find: CZBibEntry) entry]
]

{ #category : #rendering }
CZBibEntryHtmlView >> renderContentOn: html [

	(CZHtmlRenderer html: html)
		library: BibPhraseLibrary default;
		render: self entry
]
