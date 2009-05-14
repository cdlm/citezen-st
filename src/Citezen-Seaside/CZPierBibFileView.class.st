"
I present a [CZPier]BibFile as a Pier page
"
Class {
	#name : #CZPierBibFileView,
	#superclass : #PRDefaultView,
	#instVars : [
		'bib',
		'query',
		'queryResult'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #accessing }
CZPierBibFileView >> bib [
	^ bib ifNil: [ bib := self find: CZPierBibFile ]
]

{ #category : #querying }
CZPierBibFileView >> processQuery [
	queryResult := self bib query: self query
]

{ #category : #accessing }
CZPierBibFileView >> query [
	^ query
]

{ #category : #accessing }
CZPierBibFileView >> query: aString [
	query := aString
]

{ #category : #rendering }
CZPierBibFileView >> renderContentOn: html [ 
	self bib isValid
		ifTrue: [self renderQueryOn: html]
		ifFalse: [self renderErrorOn: html]
]

{ #category : #rendering }
CZPierBibFileView >> renderDebugInfoOn: html [ 
	html text: 'Loaded bibtex file: ' , bib file filePath printString; break;
		text: 'Number of bib entries: ' , bib bibList size printString; break;
		text: 'Last update: ' , bib modificationTimePrintString; break.

]

{ #category : #rendering }
CZPierBibFileView >> renderErrorOn: html [
	html heading: 'Invalid bibtex file'.
	html text: bib error.

]

{ #category : #rendering }
CZPierBibFileView >> renderQueryOn: html [
	self renderDebugInfoOn: html.
	html form: [
		html text: 'Query: '.
		html textInput on: #query of: self.
		html submitButton text: 'search';
			callback: [ self processQuery ]
		].
	self renderQueryResultOn: html 

]

{ #category : #rendering }
CZPierBibFileView >> renderQueryResultOn: html [
	"Need links to control output format, sort order etc"
	queryResult ifNotNil: [
		html heading: 'Query result: ', '(', queryResult entries size printString, ' results)'.
		queryResult renderContentOn: html
		]
		"ifNil: [ html text: 'I have nothing to show you']"
]
