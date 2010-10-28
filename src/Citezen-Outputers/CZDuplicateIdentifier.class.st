"
CZDuplicateIdentifier is responsible to find duplicates into either a single bibset or between multiple bibsets (where we can specify which one take precedence).

| dup load |
dup := CZDuplicateIdentifier new.
dup withoutInternalKeyDuplicates: (CZFileLoader bibFromFileNamed: 'rmod.bib') .
(dup keyBasedDuplicates) inspect.
	

| dup load |
dup := CZDuplicateIdentifier new.
dup withoutInternalTitleDuplicates: (CZFileLoader bibFromFileNamed: 'rmod.bib') .
(dup titleBasedDuplicates) inspect.
	
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

{ #category : #'key based' }
CZDuplicateIdentifier >> keyBasedDuplicates [ 
	"Returns the duplicated entries identified when running withoutInternalKeyDuplicates:"
	^ duplicates 
]

{ #category : #titlebased }
CZDuplicateIdentifier >> titleBasedDuplicates [ 
	"Returns the duplicated entries identified when running withoutInternalTitleDuplicates:"
	^ duplicates 
]

{ #category : #'key based' }
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

{ #category : #titlebased }
CZDuplicateIdentifier >> withoutInternalTitleDuplicates: aBibSet [
	"Returns a version without duplicated entries based on title"

	prioritaryBibSet := aBibSet.
	withoutDuplications := CZSet new.
	duplicates := CZSet new.
	prioritaryBibSet do: [:each | 
				(withoutDuplications anySatisfy: [:ent | (ent at: #title) value = (each at: #title) value])
					ifFalse: [withoutDuplications addEntry: each]
					ifTrue: [duplicates addEntry: each ]].
	^ withoutDuplications
	
]
