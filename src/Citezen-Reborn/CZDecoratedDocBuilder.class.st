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
		authorMatchingString: '*';
		sectionSpecification: #( #PhDAndHabilitation #internationalJournal #nationalJournal #topConference #internationalConference  #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation);
		setFilteringOn.
	builder generate.	
		

My subclasses are not really subclasses. They should be configuration objects. 




"
Class {
	#name : #CZDecoratedDocBuilder,
	#superclass : #CZBodyDocBuilder,
	#instVars : [
		'noHeader',
		'footerString',
		'headerString'
	],
	#category : 'Citezen-Reborn-DocumentBuilder'
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

{ #category : #'public api' }
CZDecoratedDocBuilder >> build [
	"Build the current document: i.e., add a document header and footer, filter entities that not desirable and build the document body."
	
	self addHeader.
	super build.
	self addFooter
]

{ #category : #initialize }
CZDecoratedDocBuilder >> defaultFooterString [
	^ ''
					
]

{ #category : #initialize }
CZDecoratedDocBuilder >> defaultHeaderString [
	^ ''
					
]

{ #category : #generate }
CZDecoratedDocBuilder >> extension [
	^ '.txt'
]

{ #category : #accessing }
CZDecoratedDocBuilder >> footerString [
	^ footerString ifNil: [ footerString := self defaultFooterString ]
					
]

{ #category : #accessing }
CZDecoratedDocBuilder >> footerString: aString [
	footerString := aString
					
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

]

{ #category : #settings }
CZDecoratedDocBuilder >> noHeader [

	noHeader := true
]

{ #category : #settings }
CZDecoratedDocBuilder >> withHeader [

	noHeader := false
]
