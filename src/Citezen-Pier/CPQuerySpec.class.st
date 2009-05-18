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
	#name : #CPQuerySpec,
	#superclass : #Object,
	#instVars : [
		'bibFile',
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
CPQuerySpec class >> default [
	^ self new setDefaults
]

{ #category : #getters }
CPQuerySpec >> bibFile [
	^ bibFile
]

{ #category : #setters }
CPQuerySpec >> bibFile: aBibFile [
	bibFile := aBibFile
]

{ #category : #getters }
CPQuerySpec >> caseSensitive [
	^ caseSensitive
]

{ #category : #setters }
CPQuerySpec >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #private }
CPQuerySpec >> compilesAsARegex [
	^ [queryString asRegex. true ] on: RegexSyntaxError do: [ false ]
]

{ #category : #getters }
CPQuerySpec >> controls [
	^ controls
]

{ #category : #setters }
CPQuerySpec >> controls: aBoolean [
	controls := aBoolean
]

{ #category : #private }
CPQuerySpec >> detectRegex [
	useRegex := self looksLikeARegex and: [self compilesAsARegex]
]

{ #category : #getters }
CPQuerySpec >> display [
	^ display 
]

{ #category : #setters }
CPQuerySpec >> displayAbstract [
	display := #abstract.
]

{ #category : #setters }
CPQuerySpec >> displayBibtex [
	display := #bibtex.
]

{ #category : #setters }
CPQuerySpec >> displaySummary [
	display := #summary.
]

{ #category : #querying }
CPQuerySpec >> keywords [
	^ '\s+' asRegex split: self queryString
]

{ #category : #private }
CPQuerySpec >> looksLikeARegex [
	^ queryString includesAnyOf: self regexChars
]

{ #category : #querying }
CPQuerySpec >> processQuery [
	^ self useRegex
		ifTrue: [self bibFile bibList selectByRegex: self regex ]
		ifFalse: [self bibFile bibList selectByKeywords: self keywords caseSensitive: self caseSensitive ]

]

{ #category : #getters }
CPQuerySpec >> queryString [
	^ queryString
]

{ #category : #setters }
CPQuerySpec >> queryString: aString [
	queryString := aString.
	self detectRegex.
]

{ #category : #querying }
CPQuerySpec >> regex [
	^ caseSensitive 
		ifTrue: [ queryString asRegex ]
		ifFalse: [ queryString asRegexIgnoringCase  ]
]

{ #category : #private }
CPQuerySpec >> regexChars [
	^ '[]*?\'
]

{ #category : #'initialize-release' }
CPQuerySpec >> setDefaults [
	self queryString: ''.
	self caseSensitive: false.
	self sortByCategory.
	self displaySummary.
	self controls: true.
]

{ #category : #getters }
CPQuerySpec >> sortBy [
	^ sortBy 
]

{ #category : #setters }
CPQuerySpec >> sortByAuthor [
	sortBy := #author
]

{ #category : #setters }
CPQuerySpec >> sortByCategory [
	sortBy := #category
]

{ #category : #setters }
CPQuerySpec >> sortByYear [
	sortBy := #year
]

{ #category : #getters }
CPQuerySpec >> useRegex [
	^ useRegex
]
