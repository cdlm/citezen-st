"
A person's name, separated in its semantically meaningful parts (in the LaTeX sense), e.g. first and middle names, particle, last names, and suffixes.
"
Class {
	#name : #CZAuthor,
	#superclass : #Object,
	#instVars : [
		'lastNames',
		'firstNames',
		'particles',
		'junior'
	],
	#category : 'Citezen-Model'
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

{ #category : #comparing }
CZAuthor >> = other [
	^ self class == other class
		and: [ lastNames = other lastNames
			and: [ firstNames = other firstNames
				and: [ particles = other particles
					and: [ junior = other junior ] ] ] ]
]

{ #category : #displaying }
CZAuthor >> asBibKey [
	"in lowercase and without \'{ and \' in the string"
	^ String streamContents: [:stream |
		self displayAsBibKeyOn: stream ]
]

{ #category : #private }
CZAuthor >> cleanForBibKey: aString [
	"Return a copy with the first letter capitalized"

	aString isEmpty ifTrue: [ ^ '' ].
	^ String streamContents: [ :str |
		aString do: [ :aChar | 
			aChar isLetter ifTrue: [ str nextPut: aChar asLowercase ]]]
	
]

{ #category : #displaying }
CZAuthor >> compactLastName [
	^ String streamContents: [:stream |
		self displayCompactLastNamesOn: stream ]
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
	self firstNames: (aCollection copyFrom: 1 to: index - 1).
	self dispatchVonLast: (aCollection copyFrom: index to: aCollection size)
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
	self particles: (aCollection copyFrom: 1 to: index - 1).
	self lastNames: (aCollection copyFrom: index to: aCollection size)
]

{ #category : #displaying }
CZAuthor >> displayAsBibKeyOn: aStream [
	"Uquillas Gomez -> uquillasgomez"
	"B\'era -> bera"
	self lastNames
		do: [:lastName | aStream nextPutAll: (self cleanForBibKey: lastName)]

]

{ #category : #displaying }
CZAuthor >> displayCompactLastNamesOn: aStream [
	"Uquillas Gomez -> UquillasGomez"
	self lastNames
		do: [:lastName | aStream nextPutAll: lastName]

]

{ #category : #displaying }
CZAuthor >> displayFullNameOn: aStream [
	self firstNames , self lastNames
		do: [:name | aStream nextPutAll: name]
		separatedBy: [aStream space]
]

{ #category : #displaying }
CZAuthor >> displayNormalizedNameOn: aStream [
	self particles, self lastNames
		do: [:each | aStream nextPutAll: each ]
		separatedBy: [ aStream space ].
	self firstNames ifNotEmpty: [aStream nextPutAll: ', '].
	self firstNames
		do: [:each | aStream nextPutAll: each ]
		separatedBy: [ aStream space ].

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
	^ firstNames
]

{ #category : #accessing }
CZAuthor >> firstNames: aCollection [
	firstNames := aCollection asArray
]

{ #category : #displaying }
CZAuthor >> fullName [
	| stream |
	stream := String new writeStream.
	self displayFullNameOn: stream.
	^ stream contents
]

{ #category : #accessing }
CZAuthor >> initialize [
	firstNames := lastNames := junior := particles := #()
]

{ #category : #accessing }
CZAuthor >> junior [
	^ junior
]

{ #category : #accessing }
CZAuthor >> junior: aCollection [
	junior := aCollection asArray
]

{ #category : #accessing }
CZAuthor >> lastNames [
	^ lastNames
]

{ #category : #accessing }
CZAuthor >> lastNames: aCollection [
	lastNames := aCollection asArray
]

{ #category : #displaying }
CZAuthor >> normalizedName [
	^ String streamContents: [:stream |
		self displayNormalizedNameOn: stream ]
]

{ #category : #accessing }
CZAuthor >> particles [
	^ particles
]

{ #category : #accessing }
CZAuthor >> particles: aCollection [
	particles := aCollection asArray
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
	^ String streamContents: [:stream |
		self displayShortenedNameOn: stream ]
]
