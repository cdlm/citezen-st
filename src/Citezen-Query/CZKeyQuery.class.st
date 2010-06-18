"
CZKeyQuery creates queries on the key of an BibTeX entry.

Use the message checks: aBlock on class side.
You should give it a block which takes a parameter.

Example:

@misc{key,
title = { Title 1 }
}

@article{entry2,
title = { Title 2 }
}

If you write this query: CZKeyQuery checks: [ :value | 'key*' match: value ]
it will select only the first entry.
"
Class {
	#name : #CZKeyQuery,
	#superclass : #CZEntryQuery,
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZKeyQuery >> value: aCZEntry [
	^ super value: aCZEntry key
]
