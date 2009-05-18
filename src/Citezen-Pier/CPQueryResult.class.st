"
I am a BibList that results from evaluating a query. I know my QuerySpec, so I can render myself accordingly.

I also know the BibFile that I come from so I know when I need to be refreshed.

"
Class {
	#name : #CPQueryResult,
	#superclass : #CPBibList,
	#instVars : [
		'querySpec'
	],
	#category : #'Citezen-Pier'
}

{ #category : #accessing }
CPQueryResult >> querySpec [
	^ querySpec 
]

{ #category : #accessing }
CPQueryResult >> querySpec: aQuerySpec [
	querySpec := aQuerySpec
]

{ #category : #rendering }
CPQueryResult >> renderContentOn: html [ 
	<ignoreForCoverage>
	self renderControlsOn: html.
	self entries
		ifEmpty: [html heading: 'No matching entries found.']
		ifNotEmpty: [html
				unorderedList: [self entries
						do: [:each | html
								listItem: [each renderContentOn: html]]]]
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
	html text: ' Display: '.
	html select
		list: querySpec displayList;
		on: #display
			of: querySpec;
		beSubmitOnChange
]

{ #category : #rendering }
CPQueryResult >> renderHideControlsOn: html [ 
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
