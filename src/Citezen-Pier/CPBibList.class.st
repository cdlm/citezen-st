"
I am a list of [CP]BibEntry bibtex entries. I originate from from BibFile.

I do not have a fixed url, so I am not a PRStructure. I know how to render myself so I am a WAComponent.

I represent either the result of a query, or the entire list of entries in the file.

* Should I be a some kind of Pier entity? (PRViewComponent?)
"
Class {
	#name : #CPBibList,
	#superclass : #WAComponent,
	#instVars : [
		'entries'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance-creation' }
CPBibList class >> from: aString [
	^ self new initializeFrom: aString
]

{ #category : #accessing }
CPBibList >> entries [
	^ entries
]

{ #category : #sorting }
CPBibList >> extractSatisfying: aBlock from: entriesToRender [ 
	| result |
	result := entriesToRender select: [ :each | aBlock value: each ].
	entriesToRender removeAllFoundIn: result.
	^ result
]

{ #category : #sorting }
CPBibList >> extractType: selector from: entriesToRender [ 
	| result |
	result := entriesToRender select: [ :each | each type = selector ].
	entriesToRender removeAllFoundIn: result.
	^ result
]

{ #category : #initialization }
CPBibList >> initializeEntries: newEntries [
	entries := newEntries
]

{ #category : #initialization }
CPBibList >> initializeFrom: aString [ 
	| separator |
	separator := String lf , String lf.
	entries := (separator split: aString)
				select: [:each | each notEmpty] "extra blank lines in the bibtex file may produce empty entries"
				thenCollect: [:each | CPBibEntry from: each]
]

{ #category : #rendering }
CPBibList >> printOn: aStream [
	<ignoreForCoverage>
	entries printOn: aStream
]

{ #category : #rendering }
CPBibList >> renderContentOn: html [
	<ignoreForCoverage>
	"Simple version -- QueryResult has the richer interface"
	html unorderedList: [entries do: [:each | html listItem: [html render: each]]]
]

{ #category : #querying }
CPBibList >> selectEntriesByKeywords: keywordList caseSensitive: caseSensitive [ 
	^ entries select: 
		[ :each | 
		each 
			containsKeywords: keywordList
			caseSensitive: caseSensitive ]
]

{ #category : #querying }
CPBibList >> selectEntriesByRegex: aRegex [ 
	^ entries select: [ :each | each matchesRegex: aRegex ]
]

{ #category : #querying }
CPBibList >> size [
	^ self entries size
]
