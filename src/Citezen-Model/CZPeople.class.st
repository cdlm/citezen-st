Class {
	#name : #CZPeople,
	#superclass : #CZValue,
	#instVars : [
		'people',
		'expandOption'
	],
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZPeople class >> defaultValue [
	^ self with: #()
]

{ #category : #'as yet unclassified' }
CZPeople class >> displayFullName [
	^ #fullName
]

{ #category : #'as yet unclassified' }
CZPeople class >> displayNormalizedName [
	^ #normalizedName
]

{ #category : #'as yet unclassified' }
CZPeople class >> displayShortenedName [
	^ #shortenedName
]

{ #category : #'as yet unclassified' }
CZPeople class >> fieldsOfThisFormat [
	^ #(author editor)
]

{ #category : #'as yet unclassified' }
CZPeople >> acceptVisitor: aVisitor [
	aVisitor visitPeople: self
]

{ #category : #'as yet unclassified' }
CZPeople >> expandOption: aSymbol [
	expandOption := aSymbol 
]

{ #category : #'as yet unclassified' }
CZPeople >> expanded [
	people ifNil: [ people := CZAuthorParser parse: value ].
	
	(expandOption = self class displayNormalizedName) ifTrue: [ ^ self normalizedName ].
	(expandOption = self class displayFullName) ifTrue: [ ^ self fullName ].
	^ self shortenedName
]

{ #category : #'as yet unclassified' }
CZPeople >> fullName [
	| ret |
	
	(people size = 0) ifTrue: [ ^ ''].
	(people size = 1) ifTrue: [ ^ people first fullName ].
	
	ret := WriteStream on: String new.
	
	1 to: (people size - 2) do: [ :cpt |
		ret nextPutAll: (people at: cpt) fullName.
		ret nextPutAll: ', ' ].
	ret 
		nextPutAll: (people at: (people size - 1)) fullName;
		nextPutAll: ' and ';
		nextPutAll: (people last) fullName.
		
	ret close.
	^ ret contents
]

{ #category : #'as yet unclassified' }
CZPeople >> initialize [
	super initialize.
	
	expandOption := self class displayNormalizedName
]

{ #category : #'as yet unclassified' }
CZPeople >> normalizedName [
	| ret |
	
	(people size = 0) ifTrue: [ ^ ''].
	(people size = 1) ifTrue: [ ^ people first normalizedName ].
	
	ret := WriteStream on: String new.
	
	people
		do: [ :each | ret nextPutAll: each normalizedName ]
		separatedBy: [ ret nextPutAll: ' and ' ].
		
	ret close.
	^ ret contents
]

{ #category : #'as yet unclassified' }
CZPeople >> setValue: aValue [
	super setValue: aValue.
	people := nil
]

{ #category : #'as yet unclassified' }
CZPeople >> shortenedName [
	| ret |
	
	(people size = 0) ifTrue: [ ^ ''].
	(people size = 1) ifTrue: [ ^ people first shortenedName ].
	
	ret := WriteStream on: String new.
	
	1 to: (people size - 2) do: [ :cpt |
		ret nextPutAll: (people at: cpt) shortenedName.
		ret nextPutAll: ', ' ].
	ret 
		nextPutAll: (people at: (people size - 1)) shortenedName;
		nextPutAll: ' and ';
		nextPutAll: (people last) shortenedName.
		
	ret close.
	^ ret contents
]
