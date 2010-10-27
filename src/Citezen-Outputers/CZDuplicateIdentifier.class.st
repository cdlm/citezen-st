"
CZDuplicateIdentifier is responsible to find duplicates into either a single bibset or between multiple bibsets (where we can specify which one take precedence).

| dup load |
dup := CZDuplicateIdentifier new.
dup withoutInternalDuplicates: (CZFileLoader bibFromFileNamed: 'rmod.bib') .
(dup duplicates) inspect.
	
"
Class {
	#name : #CZDuplicateIdentifier,
	#superclass : #CZTool,
	#instVars : [
		'bibSet',
		'bibSet2',
		'prioritaryBibSet',
		'withoutDuplications',
		'duplicates'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #accessing }
CZDuplicateIdentifier >> keyBasedDuplicates [ 
	"Returns the duplicated entries identified when running withoutInternalKeyDuplicates:"
	^ duplicates 
]

{ #category : #accessing }
CZDuplicateIdentifier >> withoutInternalKeyDuplicates: aBibSet [
	"Returns a version without duplicated entries based on keys"
	
	prioritaryBibSet := aBibSet.
	withoutDuplications := CZSet new.
	duplicates := CZSet new.
	prioritaryBibSet do: [:each | 
				(withoutDuplications includesKey:  each key)
					ifFalse: [withoutDuplications addEntry: each]
					ifTrue: [duplicates addEntry: each ]].
	^ withoutDuplications
	
]
