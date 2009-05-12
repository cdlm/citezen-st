"
I am a single bibtex entry in a CZPierBibList.

I hold the text string for the bibtex entry, and possibly a parsed CZEntry, which is lazily computed.

I do not have a url of my own, so I am not a PRStructure.
"
Class {
	#name : #CZPierBibEntry,
	#superclass : #Object,
	#instVars : [
		'text',
		'entry'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'instance-creation' }
CZPierBibEntry class >> from: aString [
	^ self new initializeText: aString

]

{ #category : #accessing }
CZPierBibEntry >> entry [
	"Needs some error checking.
	What if:
	- Parsing fails
	- CZSet does not contain exactly 1 entry"
	| czset |
	^ entry ifNil: [
		czset := CZBibParser parse: text.
		entry := czset first.
		]
]

{ #category : #initialization }
CZPierBibEntry >> initializeText: aString [
	text := aString
]
