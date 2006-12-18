Class {
	#name : #BibSet,
	#superclass : #Object,
	#instVars : [
		'macros',
		'entries'
	],
	#category : #Citezen
}

{ #category : #'instance creation' }
BibSet class >> fromDeclarations: declarations [
	|instance|
	instance := self new.
	declarations do: [:each | each addToBibSet: instance].
	^ instance
]

{ #category : #adding }
BibSet >> addEntry: anEntry [
	entries at: anEntry key put: anEntry
]

{ #category : #adding }
BibSet >> addEntry: anEntry ifDuplicate: aBlock [
	entries at: anEntry key ifAbsent: [^ self addEntry: anEntry].
	^ aBlock value
]

{ #category : #adding }
BibSet >> addMacro: anAssociation [
	macros add: anAssociation
]

{ #category : #adding }
BibSet >> addMacro: aMacro ifDuplicate: aBlock [
	macros at: aMacro key ifAbsent: [^ self addMacro: aMacro].
	^ aBlock value
]

{ #category : #accessing }
BibSet >> entries [
	^ entries
]

{ #category : #'initialize-release' }
BibSet >> initialize [
	super initialize.
	macros := Dictionary new. "name -> value"
	entries := Dictionary new "entry key -> entry"
]

{ #category : #accessing }
BibSet >> macros [
	^ macros
]
