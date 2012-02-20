Class {
	#name : #CZVisitor,
	#superclass : #Object,
	#instVars : [
		'blackListedFields',
		'expandOption',
		'shouldFilter'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #accessing }
CZVisitor >> authorNameExpandOption [
	"returns the name author display option: "
	^ expandOption


]

{ #category : #accessing }
CZVisitor >> blackListedFields [
	"return the list of fields entries that should be filtered out, for example organizations may force to add new fields. Have a look at CZEntry privateFields for a first list of potential fields that should not be treated."
	
	^ blackListedFields
]

{ #category : #accessing }
CZVisitor >> blackListedFields: aList [

	
	blackListedFields := aList
]

{ #category : #accessing }
CZVisitor >> defaultBlackListedFields [

	^ #()
]

{ #category : #'team related' }
CZVisitor >> inSubmissionQuery [

	^ CZFieldQuery 
		named: #keywords 
		checks: [ :value | '*insubmission*' match: value ]
]

{ #category : #'initialize-release' }
CZVisitor >> initialize [

	super initialize.
	self blackListedFields: self defaultBlackListedFields.
	self setAuthorDisplayAsFullName.
	self setFilteringOn.
]

{ #category : #accessing }
CZVisitor >> keysOfBlacklistedEntries [

	^ #()
]

{ #category : #configuration }
CZVisitor >> setAuthorDisplayAsFullName [

	expandOption := #displayFullName
]

{ #category : #configuration }
CZVisitor >> setAuthorDisplayAsNormalizedName [

	expandOption := #displayNormalizedName
]

{ #category : #configuration }
CZVisitor >> setAuthorDisplayAsShortenedName [

	expandOption := #displayShortenedName
]

{ #category : #accessing }
CZVisitor >> setFilteringOff [

	shouldFilter := false
]

{ #category : #accessing }
CZVisitor >> setFilteringOn [

	shouldFilter := true
]

{ #category : #accessing }
CZVisitor >> shouldFilter [

	^ shouldFilter
]

{ #category : #visiting }
CZVisitor >> visitBibSet: aCZSet [
	
	| newCZSet |
	newCZSet := self shouldFilter
						ifTrue: [ aCZSet reject: self inSubmissionQuery	]
						ifFalse: [aCZSet].
	newCZSet entries do: [ :each | each acceptVisitor: self].

	
]

{ #category : #visiting }
CZVisitor >> visitDocument: aDocument [

	aDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #visiting }
CZVisitor >> visitSet: aCZSet [
	
	| newCZSet |
	newCZSet := self shouldFilter
						ifTrue: [ aCZSet reject: self inSubmissionQuery	]
						ifFalse: [aCZSet].
	newCZSet entries do: [ :each | each acceptVisitor: self].

	
]
