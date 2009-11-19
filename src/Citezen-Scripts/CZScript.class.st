Class {
	#name : #CZScript,
	#superclass : #Object,
	#instVars : [
		'bibFileName',
		'bibList',
		'bibStream',
		'originalBibList',
		'blackListedKeys',
		'sectionOrder'
	],
	#classVars : [
		'DefaultBibFileName'
	],
	#category : #'Citezen-Scripts'
}

{ #category : #initialization }
CZScript class >> defaultBibFileName [ 

	^ 'lse.bib'
]

{ #category : #initialization }
CZScript class >> initialize [
	
	DefaultBibFileName := self defaultBibFileName 
]

{ #category : #initialization }
CZScript >> addSection [

	"will be more complex because there is one to one type to sructure mapping"
	(bibList groupedBy: [:each | each type])
		
	"should follow the order and remove the others then create section"
]

{ #category : #accessing }
CZScript >> bibFileName [

	^ bibFileName
]

{ #category : #accessing }
CZScript >> bibFileName: aString [

	bibFileName := aString
]

{ #category : #actions }
CZScript >> bibList [

	^ bibList
]

{ #category : #accessing }
CZScript >> bibStream [

	^ bibStream
	
]

{ #category : #accessing }
CZScript >> bibStream: aStream [

	bibStream := aStream
	
]

{ #category : #accessing }
CZScript >> blackListedKeys [

	^ blackListedKeys 
]

{ #category : #accessing }
CZScript >> blackListedKeys: aCollection [

	blackListedKeys := aCollection 
]

{ #category : #initialization }
CZScript >> defaultBibFileName [

	^ DefaultBibFileName ifNil: [self class defaultBibFileName]
]

{ #category : #initialization }
CZScript >> document [

	| doc |
	doc := CZBibRenderedDocument new.
	doc addSection. 
	^ doc

]

{ #category : #actions }
CZScript >> fillUpBibList [

	originalBibList := (CZBibParser on: self bibStream) parse.
	bibList := originalBibList.
	"at the beginning both sets are the same after filtering the biblist will reduce"	
]

{ #category : #initialization }
CZScript >> initialize [

	super initialize.
	self bibFileName: self defaultBibFileName.
	self blackListedKeys: (OrderedCollection new)
]

{ #category : #actions }
CZScript >> keepAuthor: aString [

	| pattern |
	pattern := '*',aString, '*'.
	bibList := bibList select: [:each | (each  at: #author) match: pattern]
]

{ #category : #accessing }
CZScript >> originalBibs [

	^ originalBibList
]

{ #category : #actions }
CZScript >> removeBlackList [ 

	blackListedKeys isEmpty ifTrue: [^ self].
	bibList := bibList reject: [:each | blackListedKeys includes: each  key]
	
]

{ #category : #actions }
CZScript >> sectionOrder: aCollection [


	sectionOrder := aCollection
]
