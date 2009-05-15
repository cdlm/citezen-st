"
I am a list of [CZPier]BibEntry bibtex entries. I originate from from BibFile.

I do not have a fixed url, so I am not a PRStructure. I know how to render myself so I am a WAComponent.

I represent either the result of a query, or the entire list of entries in the file.

* Should I be a some kind of Pier entity? (PRViewComponent?)
"
Class {
	#name : #CZPierBibList,
	#superclass : #Object,
	#instVars : [
		'entries'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'instance-creation' }
CZPierBibList class >> from: aString [
	^ self new initializeFrom: aString
]

{ #category : #'instance-creation' }
CZPierBibList class >> withEntries: someEntries [
	^ self new initializeEntries: someEntries
]

{ #category : #accessing }
CZPierBibList >> entries [
	^ entries
]

{ #category : #initialization }
CZPierBibList >> initializeEntries: someEntries [
	entries := someEntries
]

{ #category : #initialization }
CZPierBibList >> initializeFrom: aString [
	| separator |
	separator := String lf, String lf.
	entries := (separator split: aString) collect: [:each | CZPierBibEntry from: each]
]

{ #category : #rendering }
CZPierBibList >> printOn: aStream [
	<ignoreForCoverage>
	entries printOn: aStream
]

{ #category : #querying }
CZPierBibList >> processQuery: querySpec [ 
	^ querySpec useRegex
		ifTrue: [self selectByRegex: querySpec regex ]
		ifFalse: [self selectByKeywords: ('\s+' asRegex split: querySpec queryString) caseSensitive: querySpec caseSensitive ]
		
]

{ #category : #querying }
CZPierBibList >> query: queryString [
	^ self processQuery: (CZPierBibQuerySpec default queryString: queryString; yourself)
]

{ #category : #querying }
CZPierBibList >> queryCaseSensitive: queryString [
	^ self processQuery: (CZPierBibQuerySpec default queryString: queryString; caseSensitive: true; yourself)
]

{ #category : #rendering }
CZPierBibList >> renderContentOn: html [
	<ignoreForCoverage>
	html unorderedList: [entries do: [:each | html listItem: [each renderContentOn: html]]]
]

{ #category : #querying }
CZPierBibList >> selectByKeywords: keywordList caseSensitive: caseSensitive [
	^ self class withEntries: (entries select: [ :each | each containsKeywords: keywordList caseSensitive: caseSensitive ])
]

{ #category : #querying }
CZPierBibList >> selectByRegex: aRegex [ 
	^ self class withEntries: (entries select: [ :each | each matchesRegex: aRegex ])
]

{ #category : #querying }
CZPierBibList >> size [
	^ entries size
]
