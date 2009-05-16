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

{ #category : #accessing }
CPBibFileView >> bibFile [
	^ bibFile ifNil: [ bibFile := self find: CPBibFilePage ]
]

{ #category : #'initialize-release' }
CPBibFileView >> initialize [
	super initialize.
	querySpec := CPBibQuerySpec default
]

{ #category : #rendering }
CPBibFileView >> renderContentOn: html [ 
	self bibFile isValid
		ifTrue: [self renderQueryOn: html]
		ifFalse: [self renderErrorOn: html]
]

{ #category : #rendering }
CPBibFileView >> renderDebugInfoOn: html [ 
	html text: 'Loaded bibtex file: ' , self bibFile file filePath printString; break;
		text: 'Number of bib entries: ' , self bibFile bibList size printString; break;
		text: 'Last update: ' , self bibFile modificationTimePrintString; break.

]

{ #category : #rendering }
CPBibFileView >> renderErrorOn: html [
	html heading: 'Invalid bibtex file'.
	html text: self bibFile error.

]

{ #category : #rendering }
CPBibFileView >> renderQueryOn: html [ 
	self renderDebugInfoOn: html.
	html
		form: [html text: 'Query: '.
			html textInput on: #queryString of: querySpec.
			html submitButton text: 'search';
				callback: [queryResult := self bibFile bibList processQuery: querySpec].
			html break; text: 'case sensitive'.
			html checkbox on: #caseSensitive of: querySpec.
				].
	self renderQueryResultOn: html
]

{ #category : #rendering }
CPBibFileView >> renderQueryResultOn: html [ 
	"Need links to control output format, sort order etc"
	queryResult
		ifNotNil: [html heading: 'Query result: ' , '(' , queryResult entries size printString , ' results)'.
			queryResult renderContentOn: html ]
		"ifNil: [ html text: 'I have nothing to show you']"
]
