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
	html unorderedList: [entries do: [:each | html listItem: [each renderContentOn: html]]]
]

{ #category : #rendering }
CPQueryResult >> renderControlsOn: html [
	<ignoreForCoverage>
	html heading: 'Query result: ' , '(' , self entries size printString , ' results)'.
	html form: [
	html text: 'Display: '.
	html select
		list: querySpec displayList;
		on: #display of: querySpec;
		beSubmitOnChange.
	html text: ' Sort by: '.
	html select
		list: querySpec sortList;
		on: #sortBy of: querySpec;
		beSubmitOnChange.
	html text: ' Render controls: '.
	html checkbox
		on: #controls of: querySpec;
		submitOnClick ]
]
