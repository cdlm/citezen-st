Class {
	#name : #CZScript,
	#superclass : #Object,
	#instVars : [
		'bibFileName',
		'bibList'
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

{ #category : #accessing }
CZScript >> bibFileName [

	^ bibFileName
]

{ #category : #accessing }
CZScript >> bibFileName: aString [

	bibFileName := aString
]

{ #category : #initialization }
CZScript >> defaultBibFileName [

	^ DefaultBibFileName ifNil: [self class defaultBibFileName]
]

{ #category : #initialization }
CZScript >> initialize [

	super initialize.
	self bibFileName: self defaultBibFileName.
]

{ #category : #actions }
CZScript >> workingList [

	bibList := (CZBibFile fileName: self bibFileName) bibList.
	CZQuery default bibList: bibList;  authorRegex: 'Ducasse'.
]
