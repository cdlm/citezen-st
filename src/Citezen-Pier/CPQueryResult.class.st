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
		unorderedList: [self sortEntriesByAuthor
				do: [:each | html
						listItem: [self renderEntry: each on: html]]]
]

{ #category : #rendering }
CPQueryResult >> renderByCategoryOn: html [ 
	| entriesToRender extracted |
	<ignoreForCoverage>
	entriesToRender := self sortEntriesByAuthor.
	extracted := self 
		extractType: #article
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Journal papers'
		on: html.
	extracted := self 
		extractType: #book
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Books'
		on: html.
	extracted := self 
		extractType: #inproceedings
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Conference / workshop papers'
		on: html.
	extracted := self 
		extractType: #proceedings
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Proceedings'
		on: html.
	extracted := self 
		extractType: #incollection
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Book chapters'
		on: html.
	extracted := self 
		extractType: #inbook
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Book chapters'
		on: html.
	extracted := self 
		extractType: #phdthesis
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'PhD thesis'
		on: html.
	extracted := self 
		extractType: #mastersthesis
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Masters thesis'
		on: html.
	extracted := self 
		extractType: #techreport
		from: entriesToRender.
	self 
		renderSubList: extracted
		named: 'Technical reports'
		on: html.
	self 
		renderSubList: entriesToRender
		named: 'Miscellaneous'
		on: html


	" #misc # #booklet  #manual #unpublished "
]

{ #category : #rendering }
CPQueryResult >> renderByYearOn: html [ 
	<ignoreForCoverage>
	| entriesToRender year thisEntry list |
	entriesToRender := self sortEntriesByYear.
	year := 0.
	list := nil.
	[entriesToRender notEmpty] whileTrue: [
		thisEntry := entriesToRender removeFirst.
		thisEntry year ~= year ifTrue: [
			year := thisEntry year.
			html heading: year printString
			].
		list := html unorderedList.
		list add: [self renderEntry: thisEntry on: html].
	]

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
				[ self renderSortedBy: html.
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
CPQueryResult >> renderSortedBy: html [ 
	<ignoreForCoverage>
	html text: ' Sort by: '.
	html select
		list: querySpec sortList;
		on: #sortBy
			of: querySpec;
		beSubmitOnChange
]

{ #category : #rendering }
CPQueryResult >> renderSubList: entryList named: heading on: html [ 
	<ignoreForCoverage>
	entryList notEmpty
		ifTrue: [html heading: heading.
			html
				unorderedList: [entryList
						do: [:each | html
								listItem: [self renderEntry: each on: html]]]]
]

{ #category : #accessing }
CPQueryResult >> timestamp [
	^ timestamp
]
