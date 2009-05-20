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
		'queryString',
		'caseSensitive',
		'maxResults',
		'sortBy',
		'display',
		'hideControls'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance creation' }
CPQuerySpec class >> default [
	^ self new setDefaults
]

{ #category : #'instance creation' }
CPQuerySpec class >> defaultCaseSensitive [
	^ false
]

{ #category : #'instance creation' }
CPQuerySpec class >> defaultDisplay [
	^ #summary
]

{ #category : #'instance creation' }
CPQuerySpec class >> defaultHideControls [
	^ false
]

{ #category : #'instance creation' }
CPQuerySpec class >> defaultMaxResults [
	^ 500
]

{ #category : #'instance creation' }
CPQuerySpec class >> defaultQueryString [
	^ ''
]

{ #category : #'instance creation' }
CPQuerySpec class >> defaultSortBy [
	^ #author
]

{ #category : #'instance creation' }
CPQuerySpec class >> displayList [
	^ #(summary abstract bibtex)
]

{ #category : #'instance creation' }
CPQuerySpec class >> sortList [
	^ #(author year category)
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
CPQuerySpec >> maxResults: positiveInteger [
	maxResults := positiveInteger
]

{ #category : #querying }
CPQuerySpec >> queryResult [
	^ CPQueryResult new
		querySpec: self;
		bibList: self queryResultAsBibList
]

{ #category : #querying }
CPQuerySpec >> queryResultAsBibList [
	^ self useRegex 
		ifTrue: [ self bibFile bibList selectByRegex: self regex ]
		ifFalse: 
			[ self bibFile bibList 
				selectByKeywords: self keywords
				caseSensitive: self caseSensitive ]
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
	self queryString: self class defaultQueryString.
	self caseSensitive: self class defaultCaseSensitive.
	self sortBy: self class defaultSortBy.
	self display: self class defaultDisplay.
	self hideControls: self class defaultHideControls .
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

{ #category : #querying }
CPQuerySpec >> useRegex [
	^ self looksLikeARegex and: [self compilesAsARegex]
]
