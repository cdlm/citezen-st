"
A CZString represents an author or editor value in a BibTeX field.
It stores references to CZAuthor objects. It can also store the display option to choose what author representation should be returned by the expanded message
"
Class {
	#name : #CZPeople,
	#superclass : #CZValue,
	#instVars : [
		'people',
		'expandOption'
	],
	#category : #'Citezen-Model'
}

{ #category : #default }
CZPeople class >> defaultValue [
	^ self with: #()
]

{ #category : #customize }
CZPeople class >> displayFullName [
	^ #fullName
]

{ #category : #customize }
CZPeople class >> displayNormalizedName [
	^ #normalizedName
]

{ #category : #customize }
CZPeople class >> displayShortenedName [
	^ #shortenedName
]

{ #category : #default }
CZPeople class >> fieldsOfThisFormat [
	^ #(author editor)
]

{ #category : #visiting }
CZPeople >> acceptVisitor: aVisitor [
	aVisitor visitPeople: self
]

{ #category : #'expand options' }
CZPeople >> displayFullName [

	self expandOption: self class displayFullName
]

{ #category : #'expand options' }
CZPeople >> displayNormalizedName [

	self expandOption: self class displayNormalizedName
]

{ #category : #'expand options' }
CZPeople >> displayShortenedName [

	self expandOption: self class displayShortenedName
]

{ #category : #private }
CZPeople >> expandOption: aSymbol [
	expandOption := aSymbol 
]

{ #category : #accessing }
CZPeople >> expanded [
	people ifNil: [ people := CZAuthorParser parse: value ].
	(expandOption = self class displayNormalizedName) ifTrue: [ ^ self normalizedName ].
	(expandOption = self class displayFullName) ifTrue: [ ^ self fullName ].
	^ self shortenedName
]

{ #category : #accessing }
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

{ #category : #initialize }
CZPeople >> initialize [
	super initialize.
	
	expandOption := self class displayNormalizedName
]

{ #category : #accessing }
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

{ #category : #printing }
CZPeople >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' ', self expanded printString.
]

{ #category : #accessing }
CZPeople >> setValue: aValue [
	super setValue: aValue.
	people := nil
]

{ #category : #accessing }
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
