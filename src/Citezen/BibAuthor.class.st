Class {
	#name : #BibAuthor,
	#superclass : #Object,
	#instVars : [
		'lastNames',
		'firstNames',
		'particles',
		'junior'
	],
	#category : #Citezen
}

{ #category : #'instance creation' }
BibAuthor class >> named: aCollection [
	^ self new dispatchFirstVonLast: aCollection
]

{ #category : #'instance creation' }
BibAuthor class >> named: aCollection firstNames: firstNamesCollection [
	^ (self new)
		dispatchVonLast: aCollection;
		firstNames: firstNamesCollection;
		yourself
]

{ #category : #'instance creation' }
BibAuthor class >> named: aCollection firstNames: firstNamesCollection junior: junior [
	^ (self new)
		dispatchVonLast: aCollection;
		firstNames: firstNamesCollection;
		junior: junior;
		yourself
]

{ #category : #private }
BibAuthor >> dispatchFirstVonLast: aCollection [
	| index |
	"locate the particle"
	index := aCollection findFirst: [:name | name first isLowercase].
	index = 0
		ifTrue: [^ self
			firstNames: aCollection allButLast;
			lastNames: (aCollection last: 1);
			yourself].
	self firstNames: (aCollection removeFirst: index - 1).
	self dispatchVonLast: aCollection
]

{ #category : #private }
BibAuthor >> dispatchNamesAndFirstNames [
	| names |
	names := self lastNames.
	names size <= 1 ifTrue: [^self].
	self firstNames: (self lastNames copyFrom: 1 to: names size - 1).
	self lastNames: (self lastNames copyFrom: names size to: names size)
]

{ #category : #private }
BibAuthor >> dispatchVonLast: aCollection [
	| index |
	"locate the last names"
	index := aCollection findFirst: [:name | name first isUppercase].
	index = 0 "no name after particles"
		ifTrue: [index := aCollection size].
	self particles: (aCollection removeFirst: index - 1).
	self lastNames: aCollection
]

{ #category : #displaying }
BibAuthor >> displayFullNameOn: aStream [
	self firstNames , self lastNames
		do: [:name | aStream nextPutAll: name]
		separatedBy: [aStream space]
]

{ #category : #displaying }
BibAuthor >> displayShortenedNameOn: aStream [
	"Write the first letters of the first names and the full last name on the argument stream."
	self firstNames
		do:	[:firstName |
			aStream
				nextPut: firstName first;
				nextPut: $.;
				space].
	self lastNames
		do: [:lastName | aStream nextPutAll: lastName]
		separatedBy: [aStream space]
]

{ #category : #accessing }
BibAuthor >> firstNames [
	^ firstNames ifNil: [OrderedCollection new]
]

{ #category : #accessing }
BibAuthor >> firstNames: aCollection [
	firstNames := aCollection
]

{ #category : #accessing }
BibAuthor >> junior [
	^ junior ifNil: [OrderedCollection new]
]

{ #category : #accessing }
BibAuthor >> junior: aCollection [
	junior := aCollection
]

{ #category : #accessing }
BibAuthor >> lastNames [
	^ lastNames ifNil: [OrderedCollection new]
]

{ #category : #accessing }
BibAuthor >> lastNames: aCollection [
	lastNames := aCollection
]

{ #category : #accessing }
BibAuthor >> particles [
	^ particles ifNil: [OrderedCollection new]
]

{ #category : #accessing }
BibAuthor >> particles: aCollection [
	particles := aCollection
]

{ #category : #printing }
BibAuthor >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self lastNames
		do: [:name | aStream nextPutAll: name]
		separatedBy: [aStream space].
	aStream nextPutAll: ', '.
	self firstNames
		do: [:name | aStream nextPutAll: name]
		separatedBy: [aStream space].
	aStream nextPut: $)
]
