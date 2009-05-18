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

{ #category : #accessors }
CPQuerySpec >> bibFile [
	^ bibFile
]

{ #category : #accessors }
CPQuerySpec >> bibFile: aBibFile [
	bibFile := aBibFile
]

{ #category : #accessors }
CPQuerySpec >> caseSensitive [
	^ caseSensitive
]

{ #category : #accessors }
CPQuerySpec >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #private }
CPQuerySpec >> compilesAsARegex [
	^ [queryString asRegex. true ] on: RegexSyntaxError do: [ false ]
]

{ #category : #accessors }
CPQuerySpec >> controls [
	^ controls
]

{ #category : #accessors }
CPQuerySpec >> controls: aBoolean [
	controls := aBoolean
]

{ #category : #accessors }
CPQuerySpec >> display [
	^ display 
]

{ #category : #accessors }
CPQuerySpec >> display: displayType [
	display := displayType
]

{ #category : #accessors }
CPQuerySpec >> displayList [
	^ #(summary abstract bibtex)
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
	^ CPQueryResult new
		querySpec: self;
		initializeEntries: (self useRegex 
			ifTrue: [ self bibFile bibList selectEntriesByRegex: self regex ]
			ifFalse: 
				[ self bibFile bibList 
					selectEntriesByKeywords: self keywords
					caseSensitive: self caseSensitive ])
]

{ #category : #accessors }
CPQuerySpec >> queryString [
	^ queryString
]

{ #category : #accessors }
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
	self sortBy: #category.
	self display: #summary.
	self controls: true.
]

{ #category : #accessors }
CPQuerySpec >> sortBy [
	^ sortBy 
]

{ #category : #accessors }
CPQuerySpec >> sortBy: sortType [
	sortBy := sortType
]

{ #category : #accessors }
CPQuerySpec >> sortList [
	^ #(author year category)
]

{ #category : #querying }
CPQuerySpec >> useRegex [
	^ self looksLikeARegex and: [self compilesAsARegex]
]
