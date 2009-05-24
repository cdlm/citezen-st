"
I hold all the information needed to process either an ad hoc query or a fixed query.

I decide whether the queryString should be interpreted as a Regex or a list of keywords to match.

I use my parameters to tell BibLists how to sort themselves and BibEntries how to display themselves

These are the parameters that I store:
- bibFile
- queryString = ''
- caseSensitive = n/y
- maxResults = 500
- sortBy = author/year/category
- display = plain/abstract/bibtex
- hideControls = n/y

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

{ #category : #defaults }
CPQuerySpec class >> default [
	^ self new setDefaults
]

{ #category : #defaults }
CPQuerySpec class >> defaultCaseSensitive [
	^ false
]

{ #category : #defaults }
CPQuerySpec class >> defaultDisplay [
	^ #summary
]

{ #category : #defaults }
CPQuerySpec class >> defaultHideControls [
	^ false
]

{ #category : #defaults }
CPQuerySpec class >> defaultMaxResults [
	^ 500
]

{ #category : #defaults }
CPQuerySpec class >> defaultQueryString [
	^ ''
]

{ #category : #defaults }
CPQuerySpec class >> defaultSortBy [
	^ #author
]

{ #category : #values }
CPQuerySpec class >> displayList [
	^ #(summary abstract bibtex)
]

{ #category : #values }
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
	self maxResults: self class defaultMaxResults.
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
