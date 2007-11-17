Class {
	#name : #CZBibListHtmlView,
	#superclass : #PRDefaultView,
	#instVars : [
		'bib'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #accessing }
CZBibListHtmlView >> bib [
	^bib ifNil: [bib := (self find: CZBibList)]
]

{ #category : #rendering }
CZBibListHtmlView >> render: bibEntries annote: annote withTitle: aString on: html [
	
	| selectedEntries |
	selectedEntries := bibEntries select: [:each | (each at: 'annote' ifAbsent: [nil]) value = annote].
	self
		renderEntries: selectedEntries
		withTitle: aString
		on: html.
	^bibEntries \ selectedEntries
]

{ #category : #rendering }
CZBibListHtmlView >> render: bibEntries restOn: html [

	self
		renderEntries: bibEntries
		withTitle: 'Miscelaneous'
		on: html
]

{ #category : #rendering }
CZBibListHtmlView >> render: bibEntries type: aType withTitle: aString on: html [

	| selectedEntries |
	selectedEntries := bibEntries select: [:each | each type = aType].
	self
		renderEntries: selectedEntries
		withTitle: aString
		on: html.
	^bibEntries \ selectedEntries
]

{ #category : #rendering }
CZBibListHtmlView >> renderContentOn: html [
	| bibEntries |
	bibEntries := self bib entries.

	bibEntries := self render: bibEntries annote: 'internationaljournal' withTitle: 'Journal Publications' on: html.
	bibEntries := self render: bibEntries type: 'incollection' withTitle: 'Book Chapters' on: html.
	bibEntries := self render: bibEntries annote: 'invited' withTitle: 'Invited Publications' on: html.
	bibEntries := self render: bibEntries annote: 'internationalconference' withTitle: 'Conference Publications' on: html.
	bibEntries := self render: bibEntries annote: 'internationalworkshop' withTitle: 'Workshop Publications' on: html.
	bibEntries := self render: bibEntries annote: 'tooldemo' withTitle: 'Tool Demos' on: html.
	bibEntries := self render: bibEntries type: 'phdthesis' withTitle: 'PhD Theses' on: html.
	bibEntries := self render: bibEntries type: 'mastersthesis' withTitle: 'Masters Theses' on: html.
	bibEntries := self render: bibEntries type: 'techreport' withTitle: 'Technical Reports' on: html.
	bibEntries := self render: bibEntries restOn: html.
	
]

{ #category : #rendering }
CZBibListHtmlView >> renderEntries: aCollection withTitle: aString on: html [
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
]
