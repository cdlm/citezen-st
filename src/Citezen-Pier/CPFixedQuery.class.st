Class {
	#name : #CPFixedQuery,
	#superclass : #PRWidget,
	#instVars : [
		'querySpec',
		'queryResult',
		'errorString'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'accessing-description' }
CPFixedQuery class >> descriptionBibFile [
	^ PRStructureDescription new
		addCondition: (MACondition selector: #isBibFile)
			labelled: 'Select an existing Bib File';
		accessor: #bibFile;
		label: 'Bib File';
		priority: 10;
		beEditable;
		beRequired;
		yourself
]

{ #category : #'accessing-description' }
CPFixedQuery class >> descriptionCaseSensitive [
	<ignoreForCoverage>
	^ MABooleanDescription new
		comment: 'Queries are case sensitive';
		accessor: #caseSensitive;
		label: 'Case sensitive';
		priority: 30;
		default: CPQuerySpec defaultCaseSensitive;
		beEditable;
		yourself
]

{ #category : #'accessing-description' }
CPFixedQuery class >> descriptionDisplay [
	<ignoreForCoverage>
	^ MASingleOptionDescription new
		comment: 'How to display the entries';
		accessor: #display;
		label: 'Display';
		priority: 60;
		options: CPQuerySpec displayList ;
		default: CPQuerySpec defaultDisplay   ;
		beEditable;
		yourself
]

{ #category : #'accessing-description' }
CPFixedQuery class >> descriptionHideControls [
	<ignoreForCoverage>
	^ MABooleanDescription new
		comment: 'Hide display and sort controls';
		accessor: #hideControls;
		label: 'Hide controls';
		priority: 100;
		default: CPQuerySpec defaultHideControls ;
		beEditable;
		yourself
]

{ #category : #'accessing-description' }
CPFixedQuery class >> descriptionQueryString [
	<ignoreForCoverage>
	^ MAStringDescription new
		comment: 'The fixed query string';
		accessor: #queryString;
		label: 'Query';
		priority: 20;
		default: CPQuerySpec defaultQueryString;
		beEditable;
		beRequired;
		yourself
]

{ #category : #'accessing-description' }
CPFixedQuery class >> descriptionSortBy [
	<ignoreForCoverage>
	^ MASingleOptionDescription new
		comment: 'How to sort the query results';
		accessor: #sortBy;
		label: 'Sort by';
		priority: 50;
		options: CPQuerySpec sortList;
		default: CPQuerySpec defaultSortBy  ;
		beEditable;
		yourself
]

{ #category : #accessing }
CPFixedQuery class >> groupLabel [
	^ 'Pier Bibliography'
]

{ #category : #testing }
CPFixedQuery class >> isAbstract [
	^ false
]

{ #category : #accessing }
CPFixedQuery class >> label [
	^ 'Fixed Query'
]

{ #category : #accessing }
CPFixedQuery >> bibFile [
	^ querySpec bibFile
]

{ #category : #seaside }
CPFixedQuery >> children [
	^ Array with: self queryResult
]

{ #category : #accessing }
CPFixedQuery >> errorString [
	^ errorString
]

{ #category : #initialization }
CPFixedQuery >> initialError [
	^ 'Incomplete query specification. Please edit to fill in valid Bib File and Query.'
]

{ #category : #initialization }
CPFixedQuery >> initialize [
	super initialize.
	querySpec := CPQuerySpec default.
	errorString := self initialError
]

{ #category : #accessing }
CPFixedQuery >> queryResult [
	^ queryResult
]

{ #category : #rendering }
CPFixedQuery >> renderContentOn: html [ 

	self queryResult
		ifNil: [self renderErrorOn: html]
		ifNotNil: [self renderQueryOn: html]
]

{ #category : #rendering }
CPFixedQuery >> renderErrorOn: html [
	html heading: 'Invalid query'.
	html paragraph: 'Error: "', self errorString, '"'
]

{ #category : #rendering }
CPFixedQuery >> renderQueryOn: html [
	html render: self queryResult
]

{ #category : #initialization }
CPFixedQuery >> setOwner: aStructure [
	"Called whenever the setting are changed"
	super setOwner: aStructure.
	self updateQuerySpec
]

{ #category : #initialization }
CPFixedQuery >> updateQueryResult [
	queryResult ifNil: 
		[ errorString := self initialError.
		querySpec bibFile 
			ifNil: [ errorString := 'Missing Bib File' ]
			ifNotNil: 
				[ querySpec queryString 
					ifNil: [ errorString := 'Missing query' ]
					ifNotNil: 
						[ querySpec bibFile errorString 
							ifEmpty: [ queryResult := querySpec queryResult ]
							ifNotEmpty: [ errorString := querySpec bibFile errorString ] ] ] ]
]

{ #category : #initialization }
CPFixedQuery >> updateQuerySpec [
	querySpec bibFile ~= (self read: #descriptionBibFile) ifTrue: 
		[ querySpec bibFile: (self read: #descriptionBibFile).
		queryResult := nil ].
	querySpec queryString ~= (self read: #descriptionQueryString) ifTrue: 
		[ querySpec queryString: (self read: #descriptionQueryString).
		queryResult := nil ].
	
	querySpec caseSensitive: (self read: #descriptionCaseSensitive).
	querySpec sortBy: (self read: #descriptionSortBy).
	querySpec display: (self read: #descriptionDisplay).
	querySpec hideControls: (self read: #descriptionHideControls).
	
	self updateQueryResult.
]
