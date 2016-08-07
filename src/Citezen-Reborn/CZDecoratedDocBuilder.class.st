"
I'm producing document based on an author. The document is composed of sections. 
A document can have an header and footer. 

!!Supported features

- keysOfBlackListedEntries: if you want to make sure that some entries are not used. Just pass a collection with the bib keys of the entry. 
- fileNamed: 'rmod.bib';
- authorMatchingString: to specify author. Examples are '*Ducasse*' or 'S*Ducasse*'.
- fieldOrder: to define the field of an entry and its order. The elements can be:  

[[[#(#author #title #journal #booktitle 
#volume #pages #publisher #year #school
#impactfactor #misc
]]]
We removed url and doi for now because of encodings (ie \_). 
- sectionSpecification: aColl 
Set the list and order of section in the document body. aColl is a list of symbols taken from the following one (which can be obtained doing self new defaultSectionSpecification)

[[[ 	
	#(#internationalJournal #topConference #nationalJournal #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #PhDAndHabilitation #toolDemo #vulgarisation))
]]]

!! Example

| builder |
builder := self new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*Ducasse*';
		french; 
		sectionSpecification: #(#internationalJournal #topConference #nationalJournal #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #PhDAndHabilitation #toolDemo #vulgarisation));
		fieldOrder: #(#author 
			  #title 
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #school
			  #impactfactor 
			  #misc); ""removed doi and url since they may contain _ and the generator does not handle that well for the moment.""
		setFilteringOn.
	builder generate.	
		

"
Class {
	#name : #CZDecoratedDocBuilder,
	#superclass : #CZDocBuilder,
	#instVars : [
		'noHeader',
		'xhtml',
		'bodySpecification',
		'footerString',
		'headerString'
	],
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #Bibtex }
CZDecoratedDocBuilder class >> bibtex [
	"self bibtex"
	| builder|
	builder := self new
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generateBibtexFile
]

{ #category : #doit }
CZDecoratedDocBuilder class >> xhtml [
	"self xhtml"
		
	|  builder|
	builder :=  self new
		french; 
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generateXHTMLFile.
	builder generateBibtexFile.
]

{ #category : #building }
CZDecoratedDocBuilder >> addFooter [

	noHeader ifTrue: [^self].
	doc footer: (CZFooter new text: self footerString)
					
]

{ #category : #building }
CZDecoratedDocBuilder >> addHeader [
	
	noHeader ifTrue: [^self].
	doc header: (CZHeader new text: self headerString)
]

{ #category : #building }
CZDecoratedDocBuilder >> buildBody [

	self sectionSpecification
		do: [ :each |  
				self 
					addBibSection: (self perform: (each, #Query) asSymbol)  
					withTitle: (localization  perform: each) ] 
					
]

{ #category : #initialize }
CZDecoratedDocBuilder >> defaultFooterString [
	^ ''
					
]

{ #category : #initialize }
CZDecoratedDocBuilder >> defaultHeaderString [
	^ ''
					
]

{ #category : #initialize }
CZDecoratedDocBuilder >> defaultSectionSpecification [

	^ #(internationalJournal topConference  nationalJournal  internationalConference  nationalConference   invitedPaper bookChapter book editor internationalWorkshop PhDAndHabilitation toolDemo  vulgarisation ) 
]

{ #category : #generate }
CZDecoratedDocBuilder >> extension [
	^ '.txt'
]

{ #category : #building }
CZDecoratedDocBuilder >> filter [

	super filter.
	workingBibSet := workingBibSet select: self authorQuery
]

{ #category : #accessing }
CZDecoratedDocBuilder >> footerString [
	^ footerString ifNil: [ footerString := self defaultFooterString ]
					
]

{ #category : #accessing }
CZDecoratedDocBuilder >> footerString: aString [
	footerString := aString
					
]

{ #category : #generate }
CZDecoratedDocBuilder >> generate [

	self generateFor: self build document.
]

{ #category : #generate }
CZDecoratedDocBuilder >> generateFor: aDoc [
	self generateFor: aDoc on: (FileStream newFileNamed: Date today yyyymmdd , self extension).
]

{ #category : #generate }
CZDecoratedDocBuilder >> generateFor: aDoc on: aStream [
	| visitor |
	visitor := self generatorClass new.
	fieldOrder ifNotNil: [ visitor fieldOrder: fieldOrder ].
	visitor outputStream: aStream.
	self halt.
	visitor visit: aDoc
]

{ #category : #accessing }
CZDecoratedDocBuilder >> headerString [
	
	^ headerString ifNil: [ headerString := self defaultHeaderString ]
]

{ #category : #accessing }
CZDecoratedDocBuilder >> headerString: aString [
	
	headerString := aString
]

{ #category : #initialize }
CZDecoratedDocBuilder >> initialize [

	super initialize.
	self withHeader.
	bodySpecification := self defaultSectionSpecification. 

]

{ #category : #settings }
CZDecoratedDocBuilder >> noHeader [

	noHeader := true
]

{ #category : #settings }
CZDecoratedDocBuilder >> sectionSpecification [
	^ bodySpecification 
]

{ #category : #settings }
CZDecoratedDocBuilder >> sectionSpecification: aColl [ 
	"Set the list and order of section in the document body. aColl is a list of symbols taken from the following one (which can be obtained doing self new defaultSectionSpecification)
	
	#(#internationalJournal #topConference #nationalJournal #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #PhDAndHabilitation #toolDemo #vulgarisation))
	"
	bodySpecification := aColl
]

{ #category : #settings }
CZDecoratedDocBuilder >> withHeader [

	noHeader := false
]
