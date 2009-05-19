"
I am a BibList that results from evaluating a query. I know my QuerySpec, so I can render myself accordingly.

I also know the BibFile that I come from so I know when I need to be refreshed.

"
Class {
	#name : #CPQueryResult,
	#superclass : #CPBibList,
	#instVars : [
		'querySpec',
		'timestamp'
	],
	#category : #'Citezen-Pier'
}

{ #category : #accessing }
CPQueryResult >> entries [
	self isExpired
		ifTrue: [ self initializeEntries: querySpec queryResultEntries ].
	^ entries
]

{ #category : #initialization }
CPQueryResult >> initializeEntries: someEntries [
	super initializeEntries: someEntries.
	timestamp := querySpec bibFile timestamp
]

{ #category : #updating }
CPQueryResult >> isExpired [
	^ self querySpec bibFile isExpired or: [timestamp < querySpec bibFile timestamp]
]

{ #category : #accessing }
CPQueryResult >> querySpec [
	^ querySpec
]

{ #category : #accessing }
CPQueryResult >> querySpec: aQuerySpec [
	querySpec := aQuerySpec.
]

{ #category : #rendering }
CPQueryResult >> renderByAuthorOn: html [ 
	<ignoreForCoverage>
	html
		unorderedList: [self entries
				do: [:each | html
						listItem: [self renderEntry: each on: html]]]
]

{ #category : #rendering }
CPQueryResult >> renderByCategoryOn: html [ 
	<ignoreForCoverage>
	html
		unorderedList: [self entries
				do: [:each | html
						listItem: [self renderEntry: each on: html]]]
]

{ #category : #rendering }
CPQueryResult >> renderByYearOn: html [ 
	<ignoreForCoverage>
	html
		unorderedList: [self entries
				do: [:each | html
						listItem: [self renderEntry: each on: html]]]
]

{ #category : #rendering }
CPQueryResult >> renderContentOn: html [ 
	<ignoreForCoverage>
	self renderControlsOn: html.
	self entries
		ifEmpty: [html heading: 'No matching entries found.']
		ifNotEmpty: [querySpec sortBy = #author
				ifTrue: [^ self renderByAuthorOn: html].
			querySpec sortBy = #year
				ifTrue: [^ self renderByYearOn: html].
			querySpec sortBy = #category
				ifTrue: [^ self renderByCategoryOn: html]]
]

{ #category : #rendering }
CPQueryResult >> renderControlsOn: html [ 
	<ignoreForCoverage>
	querySpec hideControls ifFalse: 
		[ html paragraph: 
			[ html form: 
				[ self renderSortBy: html.
				self renderDisplayOn: html.
				self renderHideControlsOn: html ] ] ]
]

{ #category : #rendering }
CPQueryResult >> renderDisplayOn: html [
	<ignoreForCoverage>
	html text: ' Display: '.
	html select
		list: querySpec displayList;
		on: #display
			of: querySpec;
		beSubmitOnChange
]

{ #category : #rendering }
CPQueryResult >> renderEntry: entry on: html [ 
	<ignoreForCoverage>
	querySpec display = #summary
		ifTrue: [^ html render: entry].
	querySpec display = #abstract
		ifTrue: [^ entry renderAbstractOn: html].
	querySpec display = #bibtex
		ifTrue: [^ entry renderBibtexOn: html]
]

{ #category : #rendering }
CPQueryResult >> renderHideControlsOn: html [ 
	<ignoreForCoverage>
	html text: ' Hide controls: '.
	^ html checkbox
		on: #hideControls
			of: querySpec;
		submitOnClick
]

{ #category : #rendering }
CPQueryResult >> renderSortBy: html [ 
	<ignoreForCoverage>
	html text: ' Sort by: '.
	html select list: querySpec sortList;
		 on: #sortBy of: querySpec;
		 beSubmitOnChange
]

{ #category : #accessing }
CPQueryResult >> timestamp [
	^ timestamp
]
