Class {
	#name : #CZAuthor,
	#superclass : #Object,
	#instVars : [
		'lastNames',
		'firstNames',
		'particles',
		'junior'
	],
	#category : #'Citezen-Model'
}

{ #category : #'instance creation' }
CZAuthor class >> named: aCollection [
	^ self new dispatchFirstVonLast: aCollection
]

{ #category : #'instance creation' }
CZAuthor class >> named: aCollection firstNames: firstNamesCollection [
	^ (self new)
		dispatchVonLast: aCollection;
		firstNames: firstNamesCollection;
		yourself
]

{ #category : #'instance creation' }
CZAuthor class >> named: aCollection firstNames: firstNamesCollection junior: junior [
	^ (self new)
		dispatchVonLast: aCollection;
		firstNames: firstNamesCollection;
		junior: junior;
		yourself
]

{ #category : #private }
CZAuthor >> dispatchFirstVonLast: aCollection [
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
CZAuthor >> dispatchNamesAndFirstNames [
	| names |
	names := self lastNames.
	names size <= 1 ifTrue: [^self].
	self firstNames: (self lastNames copyFrom: 1 to: names size - 1).
	self lastNames: (self lastNames copyFrom: names size to: names size)
]

{ #category : #private }
CZAuthor >> dispatchVonLast: aCollection [
	| index |
	"locate the last names"
	index := aCollection findFirst: [:name | name first isUppercase].
	index = 0 "no name after particles"
		ifTrue: [index := aCollection size].
	self particles: (aCollection removeFirst: index - 1).
	self lastNames: aCollection
]

{ #category : #displaying }
CZAuthor >> displayFullNameOn: aStream [
	self firstNames , self lastNames
		do: [:name | aStream nextPutAll: name]
		separatedBy: [aStream space]
]

{ #category : #displaying }
CZAuthor >> displayShortenedNameOn: aStream [
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
CZAuthor >> firstNames [
	^ firstNames ifNil: [OrderedCollection new]
]

{ #category : #accessing }
CZAuthor >> firstNames: aCollection [
	firstNames := aCollection
]

{ #category : #displaying }
CZAuthor >> fullName [
	| stream |
	stream := String new writeStream.
	self displayFullNameOn: stream.
	^ stream contents
]

{ #category : #accessing }
CZAuthor >> junior [
	^ junior ifNil: [OrderedCollection new]
]

{ #category : #accessing }
CZAuthor >> junior: aCollection [
	junior := aCollection
]

{ #category : #accessing }
CZAuthor >> lastNames [
	^ lastNames ifNil: [OrderedCollection new]
]

{ #category : #accessing }
CZAuthor >> lastNames: aCollection [
	lastNames := aCollection
]

{ #category : #accessing }
CZAuthor >> particles [
	^ particles ifNil: [OrderedCollection new]
]

{ #category : #accessing }
CZAuthor >> particles: aCollection [
	particles := aCollection
]

{ #category : #printing }
CZAuthor >> printOn: aStream [
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

{ #category : #displaying }
CZAuthor >> shortenedName [
	^ (self displayShortenedNameOn: (String new writeStream)) contents
]
