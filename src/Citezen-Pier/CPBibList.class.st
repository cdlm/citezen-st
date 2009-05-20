"
I am a list of [CP]BibEntry bibtex entries. I originate from from BibFile.

I do not have a fixed url, so I am not a PRStructure. I know how to render myself so I am a WAComponent.

I represent either the result of a query, or the entire list of entries in the file.

* Should I be a some kind of Pier entity? (PRViewComponent?)
"
Class {
	#name : #CPBibList,
	#superclass : #Object,
	#instVars : [
		'entries'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance-creation' }
CPBibList class >> entries: newEntries [
	^ self new initializeEntries: newEntries
]

{ #category : #'instance-creation' }
CPBibList class >> from: aString [
	^ self new initializeFrom: aString
]

{ #category : #composing }
CPBibList >> + aBibList [
	^ self class entries: (entries clone addAll: aBibList entries; yourself)
]

{ #category : #composing }
CPBibList >> - aBibList [
	^ self class entries: (entries clone removeAll: aBibList entries; yourself)
]

{ #category : #accessing }
CPBibList >> entries [
	^ entries
]

{ #category : #sorting }
CPBibList >> extractSatisfying: aBlock [
	| result |
	result := entries select: [ :each | aBlock value: each ].
	entries removeAllFoundIn: result.
	^ self class entries: result
]

{ #category : #sorting }
CPBibList >> extractType: selector [
	| result |
	result := entries select: [ :each | each type = selector ].
	entries removeAllFoundIn: result.
	^ self class entries: result
]

{ #category : #initialization }
CPBibList >> initialize [
	self initializeEntries: OrderedCollection new
]

{ #category : #initialization }
CPBibList >> initializeEntries: newEntries [
	entries := newEntries
]

{ #category : #initialization }
CPBibList >> initializeFrom: aString [ 
	| separator |
	separator := String lf , String lf.
	self initializeEntries: ((separator split: aString)
				select: [:each | each notEmpty ]
				thenCollect: [:each | CPBibEntry from: each])
]

{ #category : #printing }
CPBibList >> printOn: aStream [
	<ignoreForCoverage>
	entries printOn: aStream
]

{ #category : #querying }
CPBibList >> selectByKeywords: keywordList caseSensitive: caseSensitive [ 
	^ self class entries: (entries select: 
			[ :each | 
			each 
				containsKeywords: keywordList
				caseSensitive: caseSensitive ])
]

{ #category : #querying }
CPBibList >> selectByRegex: aRegex [ 
	^ self class entries: (entries select: [ :each | each matchesRegex: aRegex ])
]

{ #category : #querying }
CPBibList >> size [
	^ self entries size
]

{ #category : #sorting }
CPBibList >> sortByAuthor [
	"Actually by key"
	^ self class entries: (entries asSortedCollection: [:a :b | a key < b key])
]

{ #category : #sorting }
CPBibList >> sortByYear [
	^ self class entries: (entries asSortedCollection: [:a :b | a year > b year])
]
