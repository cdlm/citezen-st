"
I present a CZPierBibFile as a Pier page
"
Class {
	#name : #CZPierBibFileView,
	#superclass : #PRDefaultView,
	#instVars : [
		'bib'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'as yet unclassified' }
CZPierBibFileView >> bib [
	^ bib ifNil: [ bib := self find: CZPierBibFile ]
]

{ #category : #'as yet unclassified' }
CZPierBibFileView >> renderContentOn: html [ 
	self bib isValid
		ifTrue: [self renderQueryOn: html]
		ifFalse: [self renderErrorOn: html]
]

{ #category : #'as yet unclassified' }
CZPierBibFileView >> renderErrorOn: html [
	html heading: 'Invalid bibtex file'.
	bib file
		ifNil: [html text: 'The bibtex file has not been defined. Please edit this page and define it']
		ifNotNilDo: [:arg | 
			html text: bib file filePath printString , ' is not a valid bibtex file. '.
			bib file exists
				ifFalse: [html text: 'No such file exists. ']]
]

{ #category : #'as yet unclassified' }
CZPierBibFileView >> renderQueryOn: html [ 
	html text: 'Loaded bibtex file: ' , bib file filePath printString;
		 break;
		 text: 'Number of bib entries: ' , bib bibList size printString
]
