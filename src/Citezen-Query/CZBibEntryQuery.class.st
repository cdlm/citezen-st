"
CZBibGeneralQuery resolves the query in the value: message.
This message takes a CZEntry as parameter.
The 3 subclasses just change what they send to super value:

Remember the pattern of a BibTeX entry:
@type{key,
field1 = value1,
field2 = value2,
...
}

- If you want to create queries on the type, use: CZBibTypeQuery
- If you want to create queries on the key, use: CZBibKeyQuery
- If you want to create queries on a field, use: CZBibFieldQuery

Take a look at their class comments.
"
Class {
	#name : #CZBibEntryQuery,
	#superclass : #CZBibQuery,
	#instVars : [
		'block'
	],
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibEntryQuery class >> checks: aBlock [
	^ self new block: aBlock 
]

{ #category : #'as yet unclassified' }
CZBibEntryQuery >> block: aBlock [
	block := aBlock 
]

{ #category : #'as yet unclassified' }
CZBibEntryQuery >> value: aValue [
	block ifNil: [ ^ true ].
	(aValue = '') ifTrue: [ ^ false ].
	^ block value: aValue 
]
