"
I am a single bibtex entry in a [CP]BibList.

I hold the text string for the bibtex entry, and possibly a parsed BibEntry, which is lazily computed.

I do not have a url of my own, so I am not a PRStructure. I can render myself, so I am a WAComponent.

* Should I be some kind of Pier entity? (e.g., PRViewComponent?)
"
Class {
	#name : #CPBibEntry,
	#superclass : #WAComponent,
	#instVars : [
		'text',
		'entry'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance-creation' }
CPBibEntry class >> from: aString [
	^ self new initializeText: aString

]

{ #category : #querying }
CPBibEntry >> containsKeywords: keywordList caseSensitive: caseSensitive [
	^ keywordList allSatisfy: [:kwd | text includesSubstring: kwd caseSensitive: caseSensitive ]
]

{ #category : #accessing }
CPBibEntry >> entry [
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
CPBibEntry >> initializeText: aString [
	text := aString
]

{ #category : #querying }
CPBibEntry >> matchesRegex: aRegex [
	^ aRegex search: text
]

{ #category : #rendering }
CPBibEntry >> printOn: aStream [
	<ignoreForCoverage>
	text printOn: aStream
]

{ #category : #rendering }
CPBibEntry >> renderContentOn: html [ 
	<ignoreForCoverage>
	[(CPHtmlRenderer html: html) library: BibPhraseLibrary default;
		 render: self entry]
		on: Error
		do: [
			html text: Error description.
			html text: text.
			]
]
