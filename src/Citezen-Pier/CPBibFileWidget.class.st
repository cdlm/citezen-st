"
I render a [CP]BibFilePage
"
Class {
	#name : #CPBibFileWidget,
	#superclass : #WAComponent,
	#instVars : [
		'queryResult',
		'querySpec',
		'bibFile'
	],
	#category : #'Citezen-Pier'
}

{ #category : #accessing }
CPBibFileWidget >> bibFile [
	^ bibFile
]

{ #category : #accessing }
CPBibFileWidget >> bibFile: aBibFile [
	bibFile := aBibFile

]

{ #category : #'initialize-release' }
CPBibFileWidget >> children [
	^ Array with: queryResult
]

{ #category : #'initialize-release' }
CPBibFileWidget >> initialize [
	super initialize.
	querySpec := CPQuerySpec default
]

{ #category : #rendering }
CPBibFileWidget >> renderContentOn: html [ 
	self bibFile isValid
		ifTrue: [self renderQueryOn: html]
		ifFalse: [self renderErrorOn: html]
]

{ #category : #rendering }
CPBibFileWidget >> renderDebugInfoOn: html [ 
	html text: 'Loaded bibtex file: ' , self bibFile file filePath printString; break;
		text: 'Number of bib entries: ' , self bibFile bibList size printString; break;
		text: 'Last update: ' , self bibFile modificationTimePrintString; break.

]

{ #category : #rendering }
CPBibFileWidget >> renderErrorOn: html [
	html heading: 'Invalid bibtex file'.
	html text: self bibFile error.

]

{ #category : #rendering }
CPBibFileWidget >> renderQueryOn: html [ 
	"self renderDebugInfoOn: html."
	html paragraph:
	[html
		form: [html big: 'Query: '.
			html textInput on: #queryString of: querySpec.
			html submitButton text: 'search';
				callback: [queryResult := querySpec bibFile: self bibFile; processQuery].
			html break; text: 'case sensitive'.
			html checkbox on: #caseSensitive of: querySpec.
		]].
	self renderQueryResultOn: html
]

{ #category : #rendering }
CPBibFileWidget >> renderQueryResultOn: html [
	queryResult ifNotNil: [ html render: queryResult ]
]
