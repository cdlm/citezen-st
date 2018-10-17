"
Defines all the constants for fields and types of entries.
"
Class {
	#name : #CZPool,
	#superclass : #SharedPool,
	#classVars : [
		'Address',
		'Author',
		'Book',
		'BookTitle',
		'Chapter',
		'DOI',
		'DefaultFields',
		'Editor',
		'HAL',
		'HALID',
		'ImpactFactor',
		'Institution',
		'Journal',
		'Misc',
		'Month',
		'Note',
		'Number',
		'Pages',
		'Publisher',
		'School',
		'Series',
		'Title',
		'URL',
		'Volume',
		'Year'
	],
	#category : 'Citezen-Model'
}

{ #category : #constants }
CZPool class >> DOI [
	^ #doi
]

{ #category : #constants }
CZPool class >> HALID [
	^ #'hal-id'
]

{ #category : #constants }
CZPool class >> URL [
	^ #url
]

{ #category : #constants }
CZPool class >> address [
	^ #address
]

{ #category : #constants }
CZPool class >> author [
	^ #author
]

{ #category : #constants }
CZPool class >> book [
	^ #book
]

{ #category : #constants }
CZPool class >> booktitle [
	^ #booktitle
]

{ #category : #constants }
CZPool class >> chapter [
	^ #chapter
]

{ #category : #constants }
CZPool class >> editor [
	^ #editor
]

{ #category : #constants }
CZPool class >> impactFactor [
	^ #impactfactor
]

{ #category : #initialize }
CZPool class >> initialize [
	"self initialize"
	Address := self address.
	Author := self author. 
	BookTitle := self booktitle.
	Chapter := self chapter.
	Book := self book.
	Editor := self editor.
	Institution := self institution.
	Journal := self journal.
	Note := self note.
	Number := self number. 
	Pages := self pages. 
	Publisher := self publisher.
	School := self school.
	Series := self series.
	Volume := self volume.
	Title := self title.
	ImpactFactor := self impactFactor. 
	DOI := self DOI.
	HALID := self HALID.
	URL := self URL.
	Misc := self misc.
	Note := self note. 
	Month := self month.
	Year := self year.
	DefaultFields := {
		self author.
		self title.
		self journal.
		self booktitle.
		self chapter.
		self editor.
		self institution.
		self number.
		self pages.
		self publisher.
		self school.
		self series.
		self volume.
		self month.
		self year.
		self note.
		self URL. 
		self DOI.
		self HALID.
		self misc.
	}
	
]

{ #category : #constants }
CZPool class >> institution [ 
	^ #institution 
]

{ #category : #constants }
CZPool class >> journal [
	^ #journal
]

{ #category : #constants }
CZPool class >> misc [ 
	^ #misc
]

{ #category : #constants }
CZPool class >> month [
	^ #month
]

{ #category : #constants }
CZPool class >> note [
	^ #note
]

{ #category : #constants }
CZPool class >> number [
	^ #number
]

{ #category : #constants }
CZPool class >> pages [
	^ #pages
]

{ #category : #constants }
CZPool class >> publisher [
	^ #publisher
]

{ #category : #constants }
CZPool class >> school [
	^ #school
]

{ #category : #constants }
CZPool class >> series [
	^ #series
]

{ #category : #constants }
CZPool class >> title [
	^ #title
]

{ #category : #constants }
CZPool class >> volume [
	^ #volume
]

{ #category : #constants }
CZPool class >> year [
	^ #year
]
