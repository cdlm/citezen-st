"
brutally extracted from CPQuerySpec

in the future we should probably import the VW code 
	BibQuery
		BibAll
		BibAnd
		BibHasField
		BibMatches	
			BibEverythingMatcher
			BibFileMatch
		BibOr
		BibNot
		
	
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
	#name : #CZQuery,
	#superclass : #Object,
	#instVars : [
		'caseSensitive',
		'queryString',
		'sortBy',
		'bibList'
	],
	#category : #'Citezen-Scripts'
}

{ #category : #defaults }
CZQuery class >> default [
	^ self new setDefaults
]

{ #category : #defaults }
CZQuery class >> defaultCaseSensitive [
	^ false
]

{ #category : #defaults }
CZQuery class >> defaultQueryString [
	^ ''
]

{ #category : #defaults }
CZQuery class >> defaultSortBy [
	^ #author
]

{ #category : #defaults }
CZQuery class >> sortList [
	^ #(author year category)
]

{ #category : #accessing }
CZQuery >> bibList [

	^ bibList 
]

{ #category : #accessing }
CZQuery >> bibList: aBibList [

	bibList := aBibList
]

{ #category : #accessing }
CZQuery >> caseSensitive [
	^ caseSensitive
]

{ #category : #accessing }
CZQuery >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #private }
CZQuery >> compilesAsARegex [
	^ [queryString asRegex. true ] on: RegexSyntaxError do: [ false ]
]

{ #category : #querying }
CZQuery >> keywords [
	^ '\s+' asRegex split: self queryString
]

{ #category : #private }
CZQuery >> looksLikeARegex [
	^ queryString includesAnyOf: self regexChars
]

{ #category : #accessing }
CZQuery >> queryString [
	^ queryString
]

{ #category : #accessing }
CZQuery >> queryString: aString [
	queryString := aString
]

{ #category : #querying }
CZQuery >> regex [
	^ caseSensitive 
		ifTrue: [ queryString asRegex ]
		ifFalse: [ queryString asRegexIgnoringCase  ]
]

{ #category : #private }
CZQuery >> regexChars [
	^ '|[]*?\'
]

{ #category : #querying }
CZQuery >> result [

	^ self useRegex 
		ifTrue: [ self bibList selectByRegex: self regex ]
		ifFalse: 
			[ self bibList 
				selectByKeywords: self keywords
				caseSensitive: self caseSensitive ]
]

{ #category : #'initialize-release' }
CZQuery >> setDefaults [
	self queryString: self class defaultQueryString.
	self caseSensitive: self class defaultCaseSensitive.
	self sortBy: self class defaultSortBy.
	
]

{ #category : #accessing }
CZQuery >> sortBy [
	^ sortBy 
]

{ #category : #accessing }
CZQuery >> sortBy: sortType [
	sortBy := sortType
]

{ #category : #querying }
CZQuery >> useRegex [
	^ self looksLikeARegex and: [self compilesAsARegex]
]
