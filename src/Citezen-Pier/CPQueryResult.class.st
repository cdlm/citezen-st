"
I hold a BibList that results from evaluating a query. I know my QuerySpec, so I can render myself accordingly.

I also know the BibFile that I come from so I know when I need to be refreshed.

"
Class {
	#name : #CPQueryResult,
	#superclass : #WAComponent,
	#instVars : [
		'querySpec',
		'timestamp',
		'truncated',
		'bibList'
	],
	#category : #'Citezen-Pier'
}

{ #category : #accessing }
CPQueryResult >> bibList [
	self isExpired ifTrue: [ self bibList: querySpec queryResultAsBibList ].
	^ bibList
]

{ #category : #accessing }
CPQueryResult >> bibList: aBibList [ 
	bibList := aBibList.
	bibList size > querySpec maxResults
		ifTrue: [bibList initializeEntries: (bibList entries copyFrom: 1 to: querySpec maxResults).
			truncated := true].
	timestamp := querySpec bibFile timestamp
]

{ #category : #accessing }
CPQueryResult >> entries [
	^ self bibList entries
]

{ #category : #initialization }
CPQueryResult >> initialize [
	super initialize.
	truncated := false.
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
		orderedList: [bibList sortByAuthor entries
				do: [:each | html
						listItem class: 'entry'; with: [self renderEntry: each on: html]]].
	self renderTruncatedOn: html.
]

{ #category : #rendering }
CPQueryResult >> renderByCategoryOn: html [ 
	| papers extracted drafts articles journalpapers inproceedings tooldemos workshoppapers |
	<ignoreForCoverage>

	papers := bibList sortByAuthor.
	
	drafts := CPBibList new.
	drafts := drafts + (papers extractSatisfying: [ :entry | entry containsKeyword: 'scg-wp' ]).
	drafts := drafts + (papers extractSatisfying: [ :entry | entry containsKeyword: 'scg-sub' ]).

	extracted := papers extractSatisfying: [ :entry | entry containsKeyword: 'invited' ].
	self renderSubList: extracted named: 'Invited Papers' on: html.

	extracted := papers extractType: #book.
	self renderSubList: extracted named: 'Books' on: html.

	articles := papers extractType: #article.
	journalpapers := articles extractSatisfying: [ :entry | entry containsKeyword: 'internationaljournal' ].
	self renderSubList: journalpapers named: 'Refereed Papers in International Journals' on: html.
	self renderSubList: articles named: 'Other Articles' on: html.

	inproceedings := papers extractType: #inproceedings.
	workshoppapers := inproceedings extractSatisfying: [ :entry | entry containsKeyword: 'internationalworkshop' ].
	"conferencepapers := inproceedings extractSatisfying: [ :entry | entry containsKeyword: 'internationalconference' ]."
	tooldemos := inproceedings extractSatisfying: [ :entry | entry containsKeyword: 'tooldemo' ].
	self renderSubList: inproceedings named: 'Refereed Papers in International Conferences' on: html.
	self renderSubList: workshoppapers named: 'Refereed Papers in International Workshops' on: html.

	extracted := papers extractType: #incollection.
	self renderSubList: extracted named: 'Book Chapters' on: html.

	extracted := papers extractSatisfying:  [ :entry |  entry type = #mastersthesis or: [ entry type = #phdthesis ] ].
	self renderSubList: extracted named: 'Theses' on: html.

	extracted := papers extractType: #techreport.
	self renderSubList: extracted named: 'Technical Reports' on: html.

	" #misc # #booklet  #inbook #manual #unpublished"
	self renderSubList: papers named: 'Other publications' on: html.
	
	self renderSubList: tooldemos named: 'Tool demos' on: html.
	self renderSubList: drafts named: 'Drafts' on: html.

	self renderTruncatedOn: html

]

{ #category : #rendering }
CPQueryResult >> renderByYearOn: html [ 
	| entriesToRender thisYearsEntries year thisEntry list |
	<ignoreForCoverage>
	entriesToRender := bibList sortByYear entries.
	thisYearsEntries := OrderedCollection new.
	year := 0.
	list := nil.
	[entriesToRender notEmpty]
		whileTrue: [thisEntry := entriesToRender removeFirst.
			thisEntry year ~= year
				ifTrue: [
					self renderEntries: thisYearsEntries forYear: year on: html.
					thisYearsEntries := OrderedCollection new.
					year := thisEntry year].
			thisYearsEntries addLast: thisEntry].
	self renderEntries: thisYearsEntries forYear: year on: html.
	self renderTruncatedOn: html
]

{ #category : #rendering }
CPQueryResult >> renderContentOn: html [ 
	<ignoreForCoverage>
	self renderControlsOn: html.
	self entries
		ifEmpty: [html paragraph:[ html strong: 'No matching entries found.']]
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
	querySpec hideControls
		ifFalse: [html
				paragraph: [html
						form: [self renderSortedBy: html.
							self renderDisplayOn: html.
							self renderHideControlsOn: html ]]]
]

{ #category : #rendering }
CPQueryResult >> renderDisplayOn: html [
	<ignoreForCoverage>
	html text: ' Display: '.
	html select
		list: CPQuerySpec displayList;
		on: #display
			of: querySpec;
		beSubmitOnChange
]

{ #category : #'as yet unclassified' }
CPQueryResult >> renderEntries: entries forYear: year on: html [ 
	<ignoreForCoverage>
	entries ifNotEmpty: 
		[ html heading: year printString.
		html orderedList: [ entries do: [ :each | html listItem class: 'entry'; with: [self renderEntry: each on: html] ] ] ]
]

{ #category : #rendering }
CPQueryResult >> renderEntry: entry on: html [
	<ignoreForCoverage>
	querySpec display = #summary
		ifTrue: [^ entry renderOn: html for: self].
	querySpec display = #abstract
		ifTrue: [^ entry renderAbstractOn: html for: self].
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
CPQueryResult >> renderLinkTo: entry on: html [
	<ignoreForCoverage>
	| newContext |
	newContext := self context structure: self querySpec bibFile.
	newContext command viewComponent queryString: entry key.
	newContext command viewComponent display: #abstract.
	html space.
	html anchor goto: newContext; with: [html html: '&rarr;']	
]

{ #category : #rendering }
CPQueryResult >> renderSortedBy: html [ 
	<ignoreForCoverage>
	html text: ' Sort by: '.
	html select
		list: CPQuerySpec sortList;
		on: #sortBy
			of: querySpec;
		beSubmitOnChange
]

{ #category : #rendering }
CPQueryResult >> renderSubList: aBibList named: heading on: html [ 
	<ignoreForCoverage>
	aBibList entries notEmpty
		ifTrue: [html heading: heading.
			html orderedList: [aBibList sortByAuthor entries
						do: [:each | html listItem class: 'entry'; with: [self renderEntry: each on: html]]]]
]

{ #category : #rendering }
CPQueryResult >> renderTruncatedOn: html [ 
	<ignoreForCoverage>
	truncated ifTrue: [
		html paragraph: [html strong: 'Maximum results (', querySpec maxResults printString ,') exceeded']
		]
]

{ #category : #querying }
CPQueryResult >> size [
	^ self bibList size
]

{ #category : #accessing }
CPQueryResult >> timestamp [
	^ timestamp
]

{ #category : #querying }
CPQueryResult >> types [
	<ignoreForCoverage>
	"utility method for development"
	^ (entries collect: [:each | each type]) asSet
	
	"scgbib returns:
	a Set(#misc #mastersthesis #booklet #article #proceedings #manual #techreport #inbook #book #phdthesis #unpublished #inproceedings #incollection)"
]
