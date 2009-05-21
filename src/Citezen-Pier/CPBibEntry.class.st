"
I am a single bibtex entry in a [CP]BibList.

I hold the text string for the bibtex entry, and possibly a parsed BibEntry, which is lazily computed.
I can answer whether I contain keywords or match a regex.
I can render myself as html, plain bibtex, or with an abstract.
"
Class {
	#name : #CPBibEntry,
	#superclass : #Object,
	#instVars : [
		'text',
		'entry',
		'error'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance-creation' }
CPBibEntry class >> from: aString [
	^ self new initializeText: aString

]

{ #category : #querying }
CPBibEntry >> containsKeyword: aString [
	^ self containsKeywords: (Array with: aString) caseSensitive: false
]

{ #category : #querying }
CPBibEntry >> containsKeywords: keywordList caseSensitive: caseSensitive [
	^ keywordList allSatisfy: [:kwd | text includesSubstring: kwd caseSensitive: caseSensitive ]
]

{ #category : #accessing }
CPBibEntry >> entry [
	"If the entry is defective, then error will be set to a String description."
	| czset |
	entry
		ifNil: [error ifNotNil: [^ nil].
			[czset := CZBibParser parse: text.
			czset entries isEmpty
				ifTrue: [error := 'No bib entries found']
				ifFalse: [czset entries size > 1
						ifTrue: [error := 'Multiple bib entries found'].
					"Only in this case we have a valid entry with an error"
					entry := czset entries first]]
				on: Error
				do: [:ex | error := ex description]].
	^ entry
]

{ #category : #initialization }
CPBibEntry >> initializeText: aString [
	text := aString
]

{ #category : #accessing }
CPBibEntry >> key [
	^ self entry ifNil: [#aaa] ifNotNil: [ self entry key ]
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
CPBibEntry >> renderAbstractOn: html [ 
	<ignoreForCoverage>
	self renderSummaryOn: html.
	(self entry hasField: 'abstract')
		ifTrue: [html break.
			html strong: 'Abstract'.
			html paragraph: [html emphasis: (self entry at: 'abstract') value]]
]

{ #category : #rendering }
CPBibEntry >> renderBibtexOn: html [ 
	<ignoreForCoverage>
	html preformatted: text
]

{ #category : #rendering }
CPBibEntry >> renderOn: html [ 
	<ignoreForCoverage>
	self renderSummaryOn: html
]

{ #category : #rendering }
CPBibEntry >> renderSummaryOn: html [ 
	<ignoreForCoverage>
	[(CPHtmlRenderer html: html) library: BibPhraseLibrary default;
		 render: self entry]
		on: Error
		do: [html emphasis: Error description.
			html preformatted: text]
]

{ #category : #accessing }
CPBibEntry >> type [
	^ self entry type
]

{ #category : #accessing }
CPBibEntry >> year [
	"If year is missing, we should try to extract it from the key"
	^ self entry ifNil: [0] ifNotNil: [ (self entry at: #year) value ]
]
