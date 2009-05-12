"
I present a CZPierBibFile as a Pier page
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
CZPierBibFileView >> renderErrorOn: html [
	html heading: 'Invalid bibtex file'.
	bib file
		ifNil: [html text: 'The bibtex file has not been defined. Please edit this page and define it']
		ifNotNil: [
			html text: bib file filePath printString , ' is not a valid bibtex file. '.
			bib file exists
				ifFalse: [html text: 'No such file exists. ']]
]

{ #category : #rendering }
CZPierBibFileView >> renderQueryOn: html [ 
	html text: 'Loaded bibtex file: ' , bib file filePath printString;
		 break;
		 text: 'Number of bib entries: ' , bib bibList size printString.
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
