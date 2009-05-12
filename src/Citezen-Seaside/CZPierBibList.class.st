"
I am a list of CSPierBibEntry bibtex entries. I originate from from CZPierBibFile.

I do not have a fixed url, so I am not a PRStructure.

I represent either the result of a query, or the entire list of entries in the file.
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

{ #category : #initialization }
CZPierBibList >> initializeFrom: aString [
	| separator |
	separator := String lf, String lf.
	entries := (separator split: aString) collect: [:each | CZPierBibEntry from: each]
]

{ #category : #querying }
CZPierBibList >> size [
	^ entries size
]
