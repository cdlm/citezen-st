Class {
	#name : #BibEntry,
	#superclass : #Object,
	#instVars : [
		'type',
		'key',
		'fields'
	],
	#category : #Citezen
}

{ #category : #'instance creation' }
BibEntry class >> type: entryType [
	^ self new type: entryType; yourself
]

{ #category : #accessing }
BibEntry >> addFields: aCollection [
	aCollection do: [:each | fields add: each]
]

{ #category : #bibset }
BibEntry >> addToBibSet: aBibSet [
	aBibSet addEntry: self ifDuplicate: [Error signal]

]

{ #category : #accessing }
BibEntry >> fields [
	^ fields
]

{ #category : #accessing }
BibEntry >> fields: aDictionary [
	fields := aDictionary
]

{ #category : #accessing }
BibEntry >> key [
	^ key
]

{ #category : #accessing }
BibEntry >> key: aKey [
	key := aKey
]

{ #category : #accessing }
BibEntry >> type [
	^ type
]

{ #category : #accessing }
BibEntry >> type: aType [
	type := aType
]
