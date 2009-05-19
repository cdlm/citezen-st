"
I render a [CP]BibFilePage
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

{ #category : #'initialize-release' }
CPBibFileView >> initialize [
	super initialize.
	querySpec := CPQuerySpec default
]

{ #category : #rendering }
CPBibFileView >> renderContentOn: html [ 
	bibFile isValid
		ifTrue: [self renderQueryOn: html]
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
	html text: bibFile error.

]

{ #category : #rendering }
CPBibFileView >> renderQueryOn: html [ 
	"self renderDebugInfoOn: html."
	html paragraph:
	[html
		form: [html strong: 'Query: '.
			html textInput on: #queryString of: querySpec.
			html submitButton text: 'search';
				callback: [queryResult := querySpec bibFile: bibFile; processQuery].
			html break; text: 'case sensitive'.
			html checkbox on: #caseSensitive of: querySpec.
		]].
	self renderQueryResultOn: html
]

{ #category : #rendering }
CPBibFileView >> renderQueryResultOn: html [
	queryResult ifNotNil: [ html render: queryResult ]
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
