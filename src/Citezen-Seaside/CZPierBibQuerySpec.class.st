"
I hold all the information relevant to either an ad hoc query or a fixed query.

I can be used to parse query information hiding in a URL, I can generate the query part ofa URL, and I can be used to store the spec of a fixed query.

I am consulted by a [CZPier]BibList or a BibEntry so they know how to render themselves (sort order etc.).

I am basically a data holder with just a few smarts.

- ignoreCase = y/n
- useRegex = n/y [auto-recognize regexes containing: []*^$\ ]
- sortBy = author/year/category
- display = plain/abstract/bibtex
- showControls = y/n

"
Class {
	#name : #CZPierBibQuerySpec,
	#superclass : #Object,
	#instVars : [
		'useRegex',
		'sortBy',
		'display',
		'controls',
		'queryString',
		'caseSensitive'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'instance creation' }
CZPierBibQuerySpec class >> default [
	^ self new setDefaults
]

{ #category : #getters }
CZPierBibQuerySpec >> caseSensitive [
	^ caseSensitive
]

{ #category : #setters }
CZPierBibQuerySpec >> caseSensitiveOff [
	caseSensitive := false
]

{ #category : #setters }
CZPierBibQuerySpec >> caseSensitiveOn [
	caseSensitive := true
]

{ #category : #getters }
CZPierBibQuerySpec >> controls [
	^ controls
]

{ #category : #setters }
CZPierBibQuerySpec >> controlsOff [
	controls := false
]

{ #category : #setters }
CZPierBibQuerySpec >> controlsOn [
	controls := true
]

{ #category : #private }
CZPierBibQuerySpec >> detectRegex [
	useRegex := queryString includesAnyOf: self regexChars
]

{ #category : #getters }
CZPierBibQuerySpec >> display [
	^ display 
]

{ #category : #setters }
CZPierBibQuerySpec >> displayAbstract [
	display := #abstract.
]

{ #category : #setters }
CZPierBibQuerySpec >> displayBibtex [
	display := #bibtex.
]

{ #category : #setters }
CZPierBibQuerySpec >> displaySummary [
	display := #summary.
]

{ #category : #getters }
CZPierBibQuerySpec >> queryString [
	^ queryString
]

{ #category : #setters }
CZPierBibQuerySpec >> queryString: aString [
	queryString := aString.
	self detectRegex.
]

{ #category : #querying }
CZPierBibQuerySpec >> regex [
	^ caseSensitive 
		ifTrue: [ queryString asRegex ]
		ifFalse: [ queryString asRegexIgnoringCase  ]
]

{ #category : #private }
CZPierBibQuerySpec >> regexChars [
	^ '[]*?\'
]

{ #category : #'initialize-release' }
CZPierBibQuerySpec >> setDefaults [
	self queryString: ''.
	self caseSensitiveOff.
	self sortByCategory.
	self displaySummary.
	self controlsOn
]

{ #category : #getters }
CZPierBibQuerySpec >> sortBy [
	^ sortBy 
]

{ #category : #setters }
CZPierBibQuerySpec >> sortByAuthor [
	sortBy := #author
]

{ #category : #setters }
CZPierBibQuerySpec >> sortByCategory [
	sortBy := #category
]

{ #category : #setters }
CZPierBibQuerySpec >> sortByYear [
	sortBy := #year
]

{ #category : #getters }
CZPierBibQuerySpec >> useRegex [
	^ useRegex
]
