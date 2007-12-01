Class {
	#name : #CZBibliographyComponent,
	#superclass : #MAComponent,
	#instVars : [
		'file'
	],
	#category : 'Citezen-Seaside'
}

{ #category : #testing }
CZBibliographyComponent class >> canBeRoot [
	^ true
]

{ #category : #'accessing-descriptions' }
CZBibliographyComponent class >> descriptionFile [
	^ MAFileDescription new
		comment: 'The .bib file to render.';
		componentClass: MAServerFileChooserComponent;
		kind: MAReferenceFileModel;
		selectorAccessor: #file;
		label: 'BibTeX File';
		yourself
]

{ #category : #testing }
CZBibliographyComponent class >> isAbstract [
	^ false
]

{ #category : #accessing }
CZBibliographyComponent class >> label [
	^ 'Bibliography'
]

{ #category : #accessing }
CZBibliographyComponent >> file [
	^ file
]

{ #category : #accessing }
CZBibliographyComponent >> file: aFileModel [
	file := aFileModel
]

{ #category : #rendering }
CZBibliographyComponent >> renderContentOn: html [ 
	| bibset |
	file ifNil: [^ self renderFileUnspecifiedOn: html].
	bibset := CZBibParser parseStream: file readStream ascii.
	bibset scope: CZSet months.
	(html div)
		id: 'bibliography';
		with: 
				[(BibHtmlRenderer html: html)
					library: BibPhraseLibrary default;
					render: bibset]
]

{ #category : #rendering }
CZBibliographyComponent >> renderFileUnspecifiedOn: html [ 
	html render: 'No file specified'
]
