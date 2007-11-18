Class {
	#name : #CZBibEntryHtmlView,
	#superclass : #PRDefaultView,
	#instVars : [
		'entry'
	],
	#category : 'Citezen-Seaside'
}

{ #category : #accessing }
CZBibEntryHtmlView >> entry [
	^entry ifNil: [entry := (self find: CZBibEntry) entry]
]

{ #category : #rendering }
CZBibEntryHtmlView >> renderContentOn: html [

	(CZBibEntryHtmlRenderer html: html)
				library: BibPhraseLibrary default;
				render: self entry
]
