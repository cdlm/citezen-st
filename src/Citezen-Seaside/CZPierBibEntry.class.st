"
I am a single bibtex entry in a [CZPier]BibList.

I hold the text string for the bibtex entry, and possibly a parsed BibEntry, which is lazily computed.

I do not have a url of my own, so I am not a PRStructure. I can render myself, so I am a WAComponent.

* Should I be some kind of Pier entity? (e.g., PRViewComponent?)
"
Class {
	#name : #CZPierBibEntry,
	#superclass : #WAComponent,
	#instVars : [
		'text',
		'entry'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'instance-creation' }
CZPierBibEntry class >> from: aString [
	^ self new initializeText: aString

]

{ #category : #accessing }
CZPierBibEntry >> entry [
	"Needs some error checking.
	What if:
	- Parsing fails
	- CZSet does not contain exactly 1 entry"
	| czset |
	^ entry ifNil: [
		czset := CZBibParser parse: text.
		entry := czset entries first.
		]
]

{ #category : #initialization }
CZPierBibEntry >> initializeText: aString [
	text := aString
]

{ #category : #querying }
CZPierBibEntry >> matches: aRegex [
	"NB: want any match within self, not an exact match, so we send search:, not matches:"
	^ aRegex search: text
]

{ #category : #rendering }
CZPierBibEntry >> renderContentOn: html [ 
	[(CZHtmlRenderer html: html) library: BibPhraseLibrary default;
		 render: self entry]
		on: Error
		do: [
			html text: Error description.
			html text: text.
			]
]
