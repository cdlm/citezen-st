Class {
	#name : #BibComponent,
	#superclass : #MAComponent,
	#instVars : [
		'file'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #testing }
BibComponent class >> canBeRoot [
	^ true
]

{ #category : #'accessing-descriptions' }
BibComponent class >> descriptionFile [
	^ MAFileDescription new
		comment: 'The .bib file to render.';
		componentClass: MAServerFileChooserComponent;
		kind: MAReferenceFileModel;
		selectorAccessor: #file;
		label: 'BibTeX File';
		yourself
]

{ #category : #testing }
BibComponent class >> isAbstract [
	^ false
]

{ #category : #accessing }
BibComponent class >> label [
	^ 'Bibliography'
]

{ #category : #accessing }
BibComponent >> file [
	^ file
]

{ #category : #accessing }
BibComponent >> file: aFileModel [
	file := aFileModel
]

{ #category : #rendering }
BibComponent >> renderContentOn: html [ 
	| bibset |
	file ifNil: [^ self renderFileUnspecifiedOn: html].
	bibset := BibParser parseStream: file readStream ascii.
	html div id: 'bibliography'; with: [
		(BibHtmlRenderer html: html)
			library: BibPhraseLibrary default;
			render: bibset
	]
]

{ #category : #rendering }
BibComponent >> renderFileUnspecifiedOn: html [ 
	html render: 'No file specified'
]
