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
		'sortBy',
		'display',
		'queryString',
		'caseSensitive',
		'hideControls',
		'maxResults'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance creation' }
CPQuerySpec class >> default [
	^ self new setDefaults
]

{ #category : #'instance creation' }
CPQuerySpec class >> defaultMaxResults [
	^ 500
]

{ #category : #accessing }
CPQuerySpec >> bibFile [
	^ bibFile
]

{ #category : #accessing }
CPQuerySpec >> bibFile: aBibFile [
	bibFile := aBibFile
]

{ #category : #accessing }
CPQuerySpec >> caseSensitive [
	^ caseSensitive
]

{ #category : #accessing }
CPQuerySpec >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #private }
CPQuerySpec >> compilesAsARegex [
	^ [queryString asRegex. true ] on: RegexSyntaxError do: [ false ]
]

{ #category : #accessing }
CPQuerySpec >> display [
	^ display 
]

{ #category : #accessing }
CPQuerySpec >> display: displayType [
	display := displayType
]

{ #category : #accessing }
CPQuerySpec >> displayList [
	^ #(summary abstract bibtex)
]

{ #category : #accessing }
CPQuerySpec >> hideControls [
	^ hideControls
]

{ #category : #accessing }
CPQuerySpec >> hideControls: aBoolean [ 
	hideControls := aBoolean
]

{ #category : #querying }
CPQuerySpec >> keywords [
	^ '\s+' asRegex split: self queryString
]

{ #category : #private }
CPQuerySpec >> looksLikeARegex [
	^ queryString includesAnyOf: self regexChars
]

{ #category : #accessing }
CPQuerySpec >> maxResults [
	^ maxResults
]

{ #category : #accessing }
CPQuerySpec >> maxResults: anObject [
	maxResults := anObject
]

{ #category : #querying }
CPQuerySpec >> processQuery [
	^ CPQueryResult new
		querySpec: self;
		initializeEntries: self queryResultEntries
]

{ #category : #nil }
CPQuerySpec >> queryResultEntries [
	^ self useRegex
		ifTrue: [self bibFile bibList selectEntriesByRegex: self regex]
		ifFalse: [self bibFile bibList selectEntriesByKeywords: self keywords caseSensitive: self caseSensitive]
]

{ #category : #accessing }
CPQuerySpec >> queryString [
	^ queryString
]

{ #category : #accessing }
CPQuerySpec >> queryString: aString [
	queryString := aString
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
	self sortBy: #author.
	self display: #summary.
	self hideControls: false.
	self maxResults: self class defaultMaxResults. "will be set from bibFile"
]

{ #category : #accessing }
CPQuerySpec >> sortBy [
	^ sortBy 
]

{ #category : #accessing }
CPQuerySpec >> sortBy: sortType [
	sortBy := sortType
]

{ #category : #accessing }
CPQuerySpec >> sortList [
	^ #(author year category)
]

{ #category : #querying }
CPQuerySpec >> useRegex [
	^ self looksLikeARegex and: [self compilesAsARegex]
]
