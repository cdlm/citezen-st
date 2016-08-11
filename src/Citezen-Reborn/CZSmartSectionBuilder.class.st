"
I'm a special builder that generates tagged-based publications separate files.

${smartPublications: file='Editor'| title='Workshop Proceedings' | text =  
		'Here are some of the proceedings of workshops and other activities I got over the year.' |
		bibtag='kzEditor'}$
should produce a file named Editor.pillar with Workshop Proceedings as title and some text
followed by a list of all the publications tagged with kzEditor. 

Here is a typical use
!!! Maintenance and Software Evolution
I'm interested in all the aspects of software evolution and maintenance of large systems. I consulted for companies. Do not hesitate to contact me. I'm interested in your problems.
- topics1
- topics2


Given a specification will follow this pattern: 

${smartPublications: file='Editor'| title='Workshop Proceedings' | text =  
		'Here are some of the proceedings of workshops and other activities I got over the year.' |
		bibtag='kzEditor']

!!Supported features

- keysOfBlackListedEntries:
- fileNamed: 'rmod.bib';
- authorMatchingString:
- fieldOrder:

!! Example

| builder |
builder := self new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*Ducasse*';
		english; 
		fieldOrder: #(#author 
			  #title  #journal #booktitle 
			  #volume  #pages  #publisher  
			  #year  #school #impactfactor 
			 #url #doi); 
		setFilteringOn;
	topics: 
		#(
			#('Editor' 'Workshop Proceedings ' 'Here are some of the proceedings of workshops and other activities I got over the year.' '*kzEditor*') 
			#('Education' 'Teaching and Educative Support' 'I''m interested in how to teach computer sciences. I supervized Hilaire Fernandes on how computer sciences can support math teaching.' '*kzTeaching*') 
			#('Vulgarisation' 'Computer Science Vulgarisation' 'I wrote several articles around programming language topics for mass journals.' '*kzVulgarisation*')).
	builder generate.	
		

	
	 
Todo: 
Should probably be using Pillar structures. 
	
{ ""title"" : 	""Editorial and Others"",
	""items "" : [  
	{ ""fileName"" : ""Vulgarisation"",
	  ""title"" : ""Computer Science Vulgarisation"",
 	  ""description"" : ""I wrote several articles around programming language topics for mass journals."",
	""matcher"" : '*kzVulgarisation*'}
		]
	}







"
Class {
	#name : #CZSmartSectionBuilder,
	#superclass : #CZPillarDocBuilder,
	#instVars : [
		'topics'
	],
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #building }
CZSmartSectionBuilder >> bibEntriesFor: aBibTag [

	^ workingBibSet select: (self queryForKozenTag: aBibTag)
]

{ #category : #building }
CZSmartSectionBuilder >> createSubTopic: file title: name text: text bibTag: bibTag [
	"I should create a new file so each CZDoc should be mapped to a file"

	| ndoc section |
	ndoc := CZDoc new title: 'Topics based publications'.
	section := CZSection new 
						title: (CZString new setValue: name); 
						text: (CZText new text: text; yourself);
						items: (CZSet new addAll: (self bibEntriesFor: bibTag); yourself); yourself.
	ndoc add: section. 
	^ ndoc
]

{ #category : #initialize }
CZSmartSectionBuilder >> defaultSmartSpecifications [
	^ #(#('Editor' 'Workshop Proceedings ' 'Here are some of the proceedings of workshops and other activities I got over the year.' '*kzEditor*') #('Education' 'Teaching and Educative Support' 'I''m interested in how to teach computer sciences. I supervized Hilaire Fernandes on how computer sciences can support math teaching.' '*kzTeaching*') #('Vulgarisation' 'Computer Science Vulgarisation' 'I wrote several articles around programming language topics for mass journals.' '*kzVulgarisation*'))
]

{ #category : #building }
CZSmartSectionBuilder >> filter [
	super filter.
	"here we do not want to remove from the working set so that 
	the articles can have multiple categories"
	"Yes but this is not there the problem"
	workingBibSet := originalBibSet select: self authorQuery
]

{ #category : #generate }
CZSmartSectionBuilder >> generate [
	"self new generate"

	self defaultSmartSpecifications
		do: [ :each | 
			| docTopic |
			self filter.	"reset the bib to full to be able to support multiple classifications of one entry."

			"a topic document should be generated in a separate file"
			docTopic := self
				createSubTopic: each first
				title: each second
				text: each third
				bibTag: each fourth.
			(CZPillarGenerator new 	
				filename: each first, self extension)
				visitDoc: docTopic.
				]
]

{ #category : #utils }
CZSmartSectionBuilder >> queryForKozenTag: aTag [

	^ CZFieldQuery 
			named: #keywords 
			checks: [ :value | '*', aTag, '*' match: value ]
]

{ #category : #accessing }
CZSmartSectionBuilder >> topics [
	^ topics ifNil: [ topics := self defaultSmartSpecifications ] 
]

{ #category : #accessing }
CZSmartSectionBuilder >> topics: aCollectionOfTopics [
	topics := aCollectionOfTopics
]
