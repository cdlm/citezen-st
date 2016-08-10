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

{ #category : #private }
CZPeople >> expandOption: aSymbol [
	expandOption := aSymbol 
]

{ #category : #accessing }
CZPeople >> expanded [
	self people.
	(expandOption = self class displayNormalizedName) ifTrue: [ ^ self normalizedName ].
	(expandOption = self class displayFullName) ifTrue: [ ^ self fullName ].
	^ self shortenedName
]

{ #category : #printing }
CZPeople >> fullName [
	| ret |
	
	(self people size = 0) ifTrue: [ ^ ''].
	(self people size = 1) ifTrue: [ ^ self people first fullName ].
	
	ret := WriteStream on: String new.
	
	1 to: (self people size - 2) do: [ :cpt |
		ret nextPutAll: (self people at: cpt) fullName.
		ret nextPutAll: ', ' ].
	ret 
		nextPutAll: (self people at: (self people size - 1)) fullName;
		nextPutAll: ' and ';
		nextPutAll: (self people last) fullName.
		
	ret close.
	^ ret contents
]

{ #category : #initialize }
CZPeople >> initialize [
	super initialize.
	
	expandOption := self class displayNormalizedName
]

{ #category : #printing }
CZPeople >> normalizedName [
	| ret |
	
	(self people size = 0) ifTrue: [ ^ ''].
	(self people size = 1) ifTrue: [ ^ self people first normalizedName ].
	
	ret := WriteStream on: String new.
	
	self people
		do: [ :each | ret nextPutAll: each normalizedName ]
		separatedBy: [ ret nextPutAll: ' and ' ].
		
	ret close.
	^ ret contents
]

{ #category : #accessing }
CZPeople >> people [ 
	^ people ifNil: [ people := CZAuthorParser parse: value ].
	
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

{ #category : #printing }
CZPeople >> shortenedName [

	"why not using doseparatedby:?"
	| ret |
	
	(self people size = 0) ifTrue: [ ^ ''].
	(self people size = 1) ifTrue: [ ^ self people first shortenedName ].
	
	ret := WriteStream on: String new.
	
	1 to: (self people size - 2) do: [ :cpt |
		ret nextPutAll: (self people at: cpt) shortenedName.
		ret nextPutAll: ', ' ].
	ret 
		nextPutAll: (self people at: (self people size - 1)) shortenedName;
		nextPutAll: ' and ';
		nextPutAll: (self people last) shortenedName.
		
	ret close.
	^ ret contents
]

{ #category : #'expand options' }
CZPeople >> useDisplayFullName [

	self expandOption: self class displayFullName
]

{ #category : #'expand options' }
CZPeople >> useDisplayNormalizedName [

	self expandOption: self class displayNormalizedName
]

{ #category : #'expand options' }
CZPeople >> useDisplayShortenedName [

	self expandOption: self class displayShortenedName
]
