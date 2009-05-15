"
I present a [CZPier]BibFile as a Pier page
"
Class {
	#name : #CZPierBibFileView,
	#superclass : #PRDefaultView,
	#instVars : [
		'queryResult',
		'queryString',
		'querySpec',
		'bibFile'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #accessing }
CZPierBibFileView >> bibFile [
	^ bibFile ifNil: [ bibFile := self find: CZPierBibFile ]
]

{ #category : #'initialize-release' }
CZPierBibFileView >> initialize [
	super initialize.
	querySpec := CZPierBibQuerySpec default.
]

{ #category : #accessing }
CZPierBibFileView >> queryString [
	^ queryString
]

{ #category : #accessing }
CZPierBibFileView >> queryString: aString [ 
	queryString := aString
]

{ #category : #rendering }
CZPierBibFileView >> renderContentOn: html [ 
	self bibFile isValid
		ifTrue: [self renderQueryOn: html]
		ifFalse: [self renderErrorOn: html]
]

{ #category : #rendering }
CZPierBibFileView >> renderDebugInfoOn: html [ 
	html text: 'Loaded bibtex file: ' , self bibFile file filePath printString; break;
		text: 'Number of bib entries: ' , self bibFile bibList size printString; break;
		text: 'Last update: ' , self bibFile modificationTimePrintString; break.

]

{ #category : #rendering }
CZPierBibFileView >> renderErrorOn: html [
	html heading: 'Invalid bibtex file'.
	html text: self bibFile error.

]

{ #category : #rendering }
CZPierBibFileView >> renderQueryOn: html [ 
	self renderDebugInfoOn: html.
	html
		form: [html text: 'Query: '.
			html textInput on: #queryString of: self.
			html submitButton text: 'search';
				callback: [querySpec queryString: queryString.
					queryResult := self bibFile bibList processQuery: querySpec]].
	self renderQueryResultOn: html
]

{ #category : #rendering }
CZPierBibFileView >> renderQueryResultOn: html [ 
	"Need links to control output format, sort order etc"
	queryResult
		ifNotNil: [html heading: 'Query result: ' , '(' , queryResult entries size printString , ' results)'.
			queryResult renderContentOn: html ]
		"ifNil: [ html text: 'I have nothing to show you']"
]
