"
I render a [CP]BibFilePage.

I present an interface to compose a query and parameters for displaying the result. I squirrel away everything in a QuerySpec object, which is responsiblke for processing the query.

I display the query parameters in my url, and read them back if the url is reused.

I am a View, hence cannot be embedded.

"
Class {
	#name : #CPBibFileView,
	#superclass : #PRDefaultView,
	#instVars : [
		'queryResult',
		'querySpec',
		'bibFile'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'accessing-description' }
CPBibFileView class >> descriptionCaseSensitive [
	<ignoreForCoverage>
	^ MABooleanDescription new
		comment: 'Queries are case sensitive';
		parameterName: 'caseSensitive';
		accessor: #caseSensitive;
		label: 'Case sensitive';
		priority: 30;
		default: CPQuerySpec defaultCaseSensitive;
		beEditable;
		yourself
]

{ #category : #'accessing-description' }
CPBibFileView class >> descriptionDisplay [
	<ignoreForCoverage>
	^ MASingleOptionDescription new
		comment: 'How to display the entries';
		parameterName: 'display';
		accessor: #display;
		label: 'Display';
		priority: 60;
		options: CPQuerySpec displayList;
		default: CPQuerySpec defaultDisplay;
		beEditable;
		yourself
]

{ #category : #'accessing-description' }
CPBibFileView class >> descriptionHideControls [
	<ignoreForCoverage>
	^ MABooleanDescription new
		comment: 'Hide display and sort controls';
		parameterName: 'hideControls';
		accessor: #hideControls;
		label: 'Hide controls';
		priority: 100;
		default: CPQuerySpec defaultHideControls ;
		beEditable;
		yourself
]

{ #category : #'accessing-description' }
CPBibFileView class >> descriptionQueryString [
	<ignoreForCoverage>
	^ MAStringDescription new
		comment: 'The fixed query string';
		parameterName: 'query';
		accessor: #queryString;
		label: 'Query';
		priority: 20;
		default: CPQuerySpec defaultQueryString;
		beEditable;
		beOptional;
		yourself
]

{ #category : #'accessing-description' }
CPBibFileView class >> descriptionSortBy [
	<ignoreForCoverage>
	^ MASingleOptionDescription new
		comment: 'How to sort the query results';
		parameterName: 'sortBy';
		accessor: #sortBy;
		label: 'Sort by';
		priority: 50;
		options: CPQuerySpec sortList;
		default: CPQuerySpec defaultSortBy  ;
		beEditable;
		yourself
]

{ #category : #accessing }
CPBibFileView >> caseSensitive: aBoolean [
	querySpec caseSensitive: aBoolean.
	queryResult := nil
]

{ #category : #seaside }
CPBibFileView >> children [
	^ Array with: queryResult
]

{ #category : #private }
CPBibFileView >> defaultSymbolFor: aSelector [
	"self new defaultSymbolFor: #hello"
	^ ('default' , aSelector asString first asUppercase asString , aSelector asString allButFirst) asSymbol
]

{ #category : #accessing }
CPBibFileView >> display: displayType [
	querySpec display: displayType.
	queryResult := nil
]

{ #category : #accessing }
CPBibFileView >> hideControls: aBoolean [
	querySpec hideControls: aBoolean.
	queryResult := nil
]

{ #category : #seaside }
CPBibFileView >> initialRequest: aRequest [ 
	"Override this to extract additional data from the request. This is only
	called for requests that don't have a valid session yet.'"

	aRequest fields at: 'caseSensitive' ifPresent: [:val | querySpec caseSensitive: val = 'true' ].
	aRequest fields at: 'sortBy' ifPresent: [:val | querySpec sortBy: val asSymbol ].
	aRequest fields at: 'display' ifPresent: [:val | querySpec display: val asSymbol ].
	aRequest fields at: 'hideControls' ifPresent: [:val | querySpec hideControls: val = 'true' ].
	aRequest fields at: 'maxResults' ifPresent: [:val | querySpec maxResults: val asNumber ].

	aRequest fields at: 'query' ifPresent: [:val | self queryString: val ]
]

{ #category : #'initialize-release' }
CPBibFileView >> initialize [
	super initialize.
	querySpec := CPQuerySpec default
]

{ #category : #'initialize-release' }
CPBibFileView >> initializeBibFileFrom: aContext [
	bibFile ifNil:[
		bibFile := aContext structure.
		querySpec bibFile: bibFile.
		querySpec maxResults: bibFile maxResults ]
]

{ #category : #'initialize-release' }
CPBibFileView >> initializeOwner: aStructure link: anInternalLink [
	super initializeOwner: aStructure link: anInternalLink.
	self updateQuerySpec
]

{ #category : #accessing }
CPBibFileView >> queryString: aString [
	querySpec queryString: aString.
	queryResult := nil
]

{ #category : #rendering }
CPBibFileView >> renderContentOn: html [ 
	bibFile invariant
		ifTrue: [self renderQueryOn: html.
			self renderQueryResultOn: html]
		ifFalse: [self renderErrorOn: html]
	
]

{ #category : #rendering }
CPBibFileView >> renderDebugInfoOn: html [ 
	html text: 'Loaded bibtex file: ' , self bibFile file filePath printString; break;
		text: 'Number of bib entries: ' , bibFile bibList size printString; break;
		text: 'Last update: ' , self bibFile modificationTimePrintString; break.

]

{ #category : #rendering }
CPBibFileView >> renderErrorOn: html [
	html heading: 'Invalid configuration'.
	html text: bibFile errorString.

]

{ #category : #rendering }
CPBibFileView >> renderQueryOn: html [
	querySpec hideControls
		ifFalse: [html
				paragraph: [html
						form: [html strong: 'Query: '.
							html textInput on: #queryString of: querySpec.
							html submitButton text: 'search'.
							html break; text: 'case sensitive'.
							html checkbox on: #caseSensitive of: querySpec;
								submitOnClick.
							html hiddenInput callback: [: val | queryResult := nil ]
							"html hiddenInput callback: [: val | self processQuery]"
							]]]

]

{ #category : #rendering }
CPBibFileView >> renderQueryResultOn: html [
	querySpec queryString notEmpty
		ifTrue:
			[queryResult ifNil: [queryResult := querySpec queryResult].
			html render: queryResult.]

]

{ #category : #seaside }
CPBibFileView >> setContext: aContext [ 
	super setContext: aContext.
	(aContext structure isKindOf: CPBibFile)
		ifTrue: [self initializeBibFileFrom: aContext]
]

{ #category : #accessing }
CPBibFileView >> sortBy: sortType [
	querySpec sortBy: sortType.
	queryResult := nil
]

{ #category : #seaside }
CPBibFileView >> states [
	^ Array with: querySpec
]

{ #category : #seaside }
CPBibFileView >> updateIfNotDefault: paramSelector url: anUrl [ 
	| paramValue |
	paramValue := querySpec perform: paramSelector.
	paramValue ~= (CPQuerySpec perform: (self defaultSymbolFor: paramSelector)) ifTrue: 
		[ anUrl 
			addParameter: paramSelector asString
			value: paramValue ]
]

{ #category : #'initialize-release' }
CPBibFileView >> updateQuerySpec [
	querySpec queryString ~= (self read: #descriptionQueryString) ifTrue: 
		[ self queryString: (self read: #descriptionQueryString) ].	
	
	querySpec caseSensitive: (self read: #descriptionCaseSensitive).
	querySpec sortBy: (self read: #descriptionSortBy).
	querySpec display: (self read: #descriptionDisplay).
	querySpec hideControls: (self read: #descriptionHideControls).

]

{ #category : #seaside }
CPBibFileView >> updateUrl: anUrl [ 
	anUrl 
		addParameter: 'query'
		value: querySpec queryString.

	self updateIfNotDefault: #caseSensitive url: anUrl.
	self updateIfNotDefault: #sortBy url: anUrl.
	self updateIfNotDefault: #display url: anUrl.
	self updateIfNotDefault: #hideControls url: anUrl.
	
	"self updateIfNotDefault: #maxResults url: anUrl"
]
