"
I hold all the information relevant to either an ad hoc query or a fixed query.

I can be used to parse query information hiding in a URL, I can generate the query part ofa URL, and I can be used to store the spec of a fixed query.

I am consulted by a [CP]BibList or a BibEntry so they know how to render themselves (sort order etc.).

I am basically a data holder with just a few smarts.

- ignoreCase = y/n
- useRegex = n/y [auto-recognize regexes containing: []*^$\ ]
- sortBy = author/year/category
- display = plain/abstract/bibtex
- showControls = y/n

"
Class {
	#name : #CPBibQuerySpec,
	#superclass : #Object,
	#instVars : [
		'useRegex',
		'sortBy',
		'display',
		'controls',
		'queryString',
		'caseSensitive'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance creation' }
CPBibQuerySpec class >> default [
	^ self new setDefaults
]

{ #category : #getters }
CPBibQuerySpec >> caseSensitive [
	^ caseSensitive
]

{ #category : #setters }
CPBibQuerySpec >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #getters }
CPBibQuerySpec >> controls [
	^ controls
]

{ #category : #setters }
CPBibQuerySpec >> controls: aBoolean [
	controls := aBoolean
]

{ #category : #private }
CPBibQuerySpec >> detectRegex [
	useRegex := queryString includesAnyOf: self regexChars
]

{ #category : #getters }
CPBibQuerySpec >> display [
	^ display 
]

{ #category : #setters }
CPBibQuerySpec >> displayAbstract [
	display := #abstract.
]

{ #category : #setters }
CPBibQuerySpec >> displayBibtex [
	display := #bibtex.
]

{ #category : #setters }
CPBibQuerySpec >> displaySummary [
	display := #summary.
]

{ #category : #getters }
CPBibQuerySpec >> queryString [
	^ queryString
]

{ #category : #setters }
CPBibQuerySpec >> queryString: aString [
	queryString := aString.
	self detectRegex.
]

{ #category : #querying }
CPBibQuerySpec >> regex [
	^ caseSensitive 
		ifTrue: [ queryString asRegex ]
		ifFalse: [ queryString asRegexIgnoringCase  ]
]

{ #category : #private }
CPBibQuerySpec >> regexChars [
	^ '[]*?\'
]

{ #category : #'initialize-release' }
CPBibQuerySpec >> setDefaults [
	self queryString: ''.
	self caseSensitive: false.
	self sortByCategory.
	self displaySummary.
	self controls: true.
]

{ #category : #getters }
CPBibQuerySpec >> sortBy [
	^ sortBy 
]

{ #category : #setters }
CPBibQuerySpec >> sortByAuthor [
	sortBy := #author
]

{ #category : #setters }
CPBibQuerySpec >> sortByCategory [
	sortBy := #category
]

{ #category : #setters }
CPBibQuerySpec >> sortByYear [
	sortBy := #year
]

{ #category : #getters }
CPBibQuerySpec >> useRegex [
	^ useRegex
]
