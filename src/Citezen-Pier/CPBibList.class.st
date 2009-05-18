"
I am a list of [CP]BibEntry bibtex entries. I originate from from BibFile.

I do not have a fixed url, so I am not a PRStructure. I know how to render myself so I am a WAComponent.

I represent either the result of a query, or the entire list of entries in the file.

* Should I be a some kind of Pier entity? (PRViewComponent?)
"
Class {
	#name : #CPBibList,
	#superclass : #PRDefaultView,
	#instVars : [
		'entries'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance-creation' }
CPBibList class >> from: aString [
	^ self new initializeFrom: aString
]

{ #category : #'instance-creation' }
CPBibList class >> withEntries: someEntries [
	^ self new initializeEntries: someEntries
]

{ #category : #accessing }
CPBibList >> entries [
	^ entries
]

{ #category : #initialization }
CPBibList >> initializeEntries: someEntries [
	entries := someEntries
]

{ #category : #initialization }
CPBibList >> initializeFrom: aString [ 
	| separator |
	separator := String lf , String lf.
	entries := (separator split: aString) collect: [ :each | CPBibEntry from: each ]
]

{ #category : #rendering }
CPBibList >> printOn: aStream [
	<ignoreForCoverage>
	entries printOn: aStream
]

{ #category : #querying }
CPBibList >> query: queryString [ 
	^ CPQuerySpec default
			queryString: queryString;
			processQuery
]

{ #category : #querying }
CPBibList >> queryCaseSensitive: queryString [ 
	^ CPQuerySpec default
			queryString: queryString;
			caseSensitive: true;
			processQuery
]

{ #category : #rendering }
CPBibList >> renderContentOn: html [
	<ignoreForCoverage>
	html unorderedList: [entries do: [:each | html listItem: [each renderContentOn: html]]]
]

{ #category : #querying }
CPBibList >> selectByKeywords: keywordList caseSensitive: caseSensitive [
	^ self class withEntries: (entries select: [ :each | each containsKeywords: keywordList caseSensitive: caseSensitive ])
]

{ #category : #querying }
CPBibList >> selectByRegex: aRegex [ 
	^ self class withEntries: (entries select: [ :each | each matchesRegex: aRegex ])
]

{ #category : #querying }
CPBibList >> size [
	^ entries size
]
