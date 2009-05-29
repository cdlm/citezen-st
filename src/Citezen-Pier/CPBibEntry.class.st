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

{ #category : #pier }
CPBibEntry >> pierAbstract [
	^ (self entry hasField: #abstract)
		ifTrue: ['!!Abstract', String cr, (self pierField: #abstract)]
		ifFalse: ['']
]

{ #category : #pier }
CPBibEntry >> pierContents [
	^ (CPPierRenderer new render: self entry) contents, String cr, self pierAbstract
]

{ #category : #pier }
CPBibEntry >> pierContentsFor: aQueryResult [
	self flag: 'Here we want to include a link to the scgbib entry -- how?'.
	^ (CPPierRenderer new render: self entry) contents, String cr, self pierAbstract
	"^ (CPPierRenderer new render: self entry) contents, ' ', (aQueryResult pierLinkTo: entry), String cr, self pierAbstract"
]

{ #category : #pier }
CPBibEntry >> pierField: aFieldSelector [ 
	^ ((CPPierRenderer forField: aFieldSelector) visit: self entry) contents
]

{ #category : #pier }
CPBibEntry >> plainField: aFieldSelector [ 
	^ ((CPPlainPierRenderer forField: aFieldSelector) visit: self entry) contents
]

{ #category : #rendering }
CPBibEntry >> printOn: aStream [
	<ignoreForCoverage>
	text printOn: aStream
]

{ #category : #rendering }
CPBibEntry >> renderAbstractOn: html for: aQueryResult [
	<ignoreForCoverage>
	self renderSummaryOn: html for: aQueryResult.
	(self entry hasField: #abstract)
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
CPBibEntry >> renderDoiOn: html [ 
	<ignoreForCoverage>
	(self entry hasField: #doi)
		ifTrue: [ html space.
			html anchor url: 'http://dx.doi.org/', (self plainField: #doi); with: 'DOI' ]
]

{ #category : #rendering }
CPBibEntry >> renderOn: html for: aQueryResult [
	<ignoreForCoverage>
	self renderSummaryOn: html for: aQueryResult
]

{ #category : #rendering }
CPBibEntry >> renderSummaryOn: html for: aQueryResult [
	<ignoreForCoverage>
	[(CPHtmlRenderer html: html) library: BibPhraseLibrary default;
			render: self entry.
			self renderDoiOn: html.
			self renderUrlsOn: html.
			aQueryResult renderLinkTo: self on: html ]
		on: Error
		do: [html emphasis: Error description.
			html preformatted: text]
]

{ #category : #rendering }
CPBibEntry >> renderUrlsOn: html [ 
	<ignoreForCoverage>
	| urls anchor |
	(self entry hasField: #url)
		ifTrue: [
			urls := '\s+' asRegex split: (self plainField: #url).
			urls do: [: each |
				html space.
				anchor := html anchor url: each.
				(each endsWith: '.pdf')
					ifTrue: [ anchor with: 'PDF']
					ifFalse: [ anchor with: 'URL'] ] ]

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
