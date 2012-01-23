"
Defines all the constants for fields and types of entries.
"
Class {
	#name : #CZPool,
	#superclass : #Object,
	#classVars : [
		'RequiredFields'
	],
	#category : #'Citezen-Model'
}

{ #category : #constants }
CZPool class >> author [
	^ #author
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

{ #category : #initialize }
CZPool class >> initialize [
	"self initialize"
	
	RequiredFields := {
		self author.
		self booktitle.
		self chapter.
		self editor.
		self institution.
		self journal.
		self note.
		self number.
		self pages.
		self publisher.
		self school.
		self series.
		self volume.
		self title.
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
CZPool class >> requiredFields [
	^ RequiredFields
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
