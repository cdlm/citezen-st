"
I am a list of CSPierBibEntry bibtex entries. I originate from from CZPierBibFile.

I do not have a fixed url, so I am not a PRStructure.

I represent either the result of a query, or the entire list of entries in the file.

* Should I be a WAComponent, or some kind of Pier entity? (PRViewComponent?)
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

{ #category : #querying }
CZPierBibList >> filterRegex: aRegex [
	^ self class withEntries: (entries select: [:each | each matches: aRegex ])
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
CZPierBibList >> renderContentOn: html [ 
	html unorderedList: [entries do: [:each | html listItem: [each renderContentOn: html]]]
]

{ #category : #querying }
CZPierBibList >> size [
	^ entries size
]
