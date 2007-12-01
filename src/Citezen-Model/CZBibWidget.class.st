Class {
	#name : #CZBibWidget,
	#superclass : #CZBibliographyComponent,
	#instVars : [
		'bibEntries'
	],
	#category : 'Citezen-Seaside'
}

{ #category : #'as yet unclassified' }
CZBibWidget class >> label [
	^'Bib'
]

{ #category : #'as yet unclassified' }
CZBibWidget >> renderAnnote: annote withTitle: aString on: html [

	self
		renderEntries: (bibEntries select: [:each | (each at: 'annote' ifAbsent: [nil]) value = annote])
		withTitle: aString
		on: html
]

{ #category : #'as yet unclassified' }
CZBibWidget >> renderContentOn: html [ 
	file ifNil: [^ self renderFileUnspecifiedOn: html].
	bibEntries _ CZBibParser parseStream: file readStream ascii.

	self renderAnnote: 'internationaljournal' withTitle: 'Journal Publications' on: html.
	self renderEntryType: 'incollection' withTitle: 'Book Chapters' on: html.
	self renderAnnote: 'invited' withTitle: 'Invited Publications' on: html.
	self renderAnnote: 'internationalconference' withTitle: 'Conference Publications' on: html.
	self renderAnnote: 'internationalworkshop' withTitle: 'Workshop Publications' on: html.
	self renderAnnote: 'tooldemo' withTitle: 'Tool Demos' on: html.
	self renderEntryType: 'phdthesis' withTitle: 'PhD Theses' on: html.
	self renderEntryType: 'mastersthesis' withTitle: 'Masters Theses' on: html.
	self renderEntryType: 'techreport' withTitle: 'Technical Reports' on: html.
	self renderRestOn: html.
]

{ #category : #'as yet unclassified' }
CZBibWidget >> renderEntries: aCollection withTitle: aString on: html [
	| sortedCollection |
	aCollection isEmpty ifTrue: [^self].
	sortedCollection _ aCollection sortBy: [:a :b | (a at: 'year' ifAbsent: ['0']) value > (b at: 'year' ifAbsent: ['0']) value].
	html heading level: 1; with: aString.
	(html orderedList)
		class: 'bib';
		with: 
			[(CZBibEntryHtmlRenderer html: html)
				library: BibPhraseLibrary default;
				render: sortedCollection].
	
	bibEntries _ bibEntries \ aCollection
]

{ #category : #'as yet unclassified' }
CZBibWidget >> renderEntryType: aType withTitle: aString on: html [

	self
		renderEntries: (bibEntries select: [:each | each type = aType])
		withTitle: aString
		on: html
]

{ #category : #'as yet unclassified' }
CZBibWidget >> renderRestOn: html [

	self
		renderEntries: bibEntries
		withTitle: 'Miscelaneous'
		on: html
]
