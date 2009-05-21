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

{ #category : #seaside }
CPBibFileView >> children [
	^ Array with: queryResult
]

{ #category : #private }
CPBibFileView >> defaultSymbolFor: aSelector [
	"self new defaultSymbolFor: #hello"
	^ ('default' , aSelector asString first asUppercase asString , aSelector asString allButFirst) asSymbol
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

	aRequest fields at: 'query' ifPresent: [:val | querySpec queryString: val. self processQuery ]
]

{ #category : #'initialize-release' }
CPBibFileView >> initialize [
	super initialize.
	querySpec := CPQuerySpec default
]

{ #category : #querying }
CPBibFileView >> processQuery [
	queryResult := querySpec bibFile: bibFile; queryResult

]

{ #category : #'as yet unclassified' }
CPBibFileView >> queryString: aString [
	querySpec queryString: aString
]

{ #category : #rendering }
CPBibFileView >> renderContentOn: html [ 
	bibFile isValid
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
	html heading: 'Invalid bibtex file'.
	html text: bibFile errorString.

]

{ #category : #rendering }
CPBibFileView >> renderQueryOn: html [
	querySpec hideControls
		ifFalse: [html
				paragraph: [html
						form: [html strong: 'Query: '.
							html textInput on: #queryString of: querySpec.
							html submitButton text: 'search';
								callback: [self processQuery].
							html break; text: 'case sensitive'.
							html checkbox on: #caseSensitive of: querySpec;
								submitOnClick]]]

	"Why does submitOnClick not work for the caseSensitive checkbox?"
]

{ #category : #rendering }
CPBibFileView >> renderQueryResultOn: html [
	queryResult ifNotNil: [ html render: queryResult ]

	"TimeProfileBrowser spyOn: [html render: queryResult]"
	
]

{ #category : #seaside }
CPBibFileView >> setContext: aContext [ 
	super setContext: aContext.
	(aContext structure isKindOf: CPBibFile)
		ifTrue: [bibFile := aContext structure.
			querySpec maxResults: bibFile maxResults]
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
