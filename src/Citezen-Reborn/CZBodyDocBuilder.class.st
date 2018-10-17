"
I'm a document builder with the description of a list of section (each one representing a query to a bibset).

	self new bodySpecification: #(#internationalJournal #topConference #nationalJournal #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #PhDAndHabilitation #toolDemo #vulgarisation).


"
Class {
	#name : #CZBodyDocBuilder,
	#superclass : #CZDocBuilder,
	#instVars : [
		'bodySpecification'
	],
	#category : 'Citezen-Reborn-DocumentBuilder'
}

{ #category : #settings }
CZBodyDocBuilder >> bodySpecification [
	^ bodySpecification 
]

{ #category : #settings }
CZBodyDocBuilder >> bodySpecification: aColl [ 
	"Set the list and order of section in the document body. aColl is a list of symbols taken from the following one (which can be obtained doing self new defaultSectionSpecification)
	
	#(#internationalJournal #topConference #nationalJournal #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #PhDAndHabilitation #toolDemo #vulgarisation))
	"
	bodySpecification := aColl
]

{ #category : #'public API' }
CZBodyDocBuilder >> buildBody [

	self bodySpecification
		do: [ :each |  
				self 
					addSectionFromQuery: (self perform: (each, #Query) asSymbol)  
					withTitle: (localization perform: each) ] 
					
]

{ #category : #initialize }
CZBodyDocBuilder >> defaultSectionSpecification [
	^ #(#internationalJournal #nationalJournal #topConference internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #PhDAndHabilitation #toolDemo #vulgarisation)
]

{ #category : #initialize }
CZBodyDocBuilder >> extension [ 
	"this should be probably be revisited because in case of Pillar model generation there is no such file extension"
	self subclassResponsibility 
]

{ #category : #building }
CZBodyDocBuilder >> filter [
	"set the working set to only the author entries"
	super filter.
	workingBibSet := workingBibSet select: self authorQuery
]

{ #category : #generate }
CZBodyDocBuilder >> generate [

	self generateFor: self build document.
]

{ #category : #'file helper' }
CZBodyDocBuilder >> generateFor: aDoc [

	((Date today yyyymmdd, self extension) asFileReference ensureDelete; ensureCreateFile ) writeStreamDo: [ :st | 
				self generateFor: aDoc on: st ]
]

{ #category : #generate }
CZBodyDocBuilder >> generateFor: aDoc on: aStream [
	| visitor |
	visitor := self generatorClass new.
	fieldOrder ifNotNil: [ visitor fieldOrder: fieldOrder ].
	visitor outputStream: aStream.
	visitor visit: aDoc
]

{ #category : #generate }
CZBodyDocBuilder >> generatorClass [

	^ self subclassResponsibility 
]

{ #category : #initialize }
CZBodyDocBuilder >> initialize [

	super initialize.
	bodySpecification := self defaultSectionSpecification. 

]
