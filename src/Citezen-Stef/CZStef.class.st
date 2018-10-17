"
CZStef new latex; html; bib ; generate
	
"
Class {
	#name : #CZStef,
	#superclass : #Object,
	#instVars : [
		'generators',
		'bodySpecification'
	],
	#category : 'Citezen-Stef'
}

{ #category : #API }
CZStef >> bib [

	generators add: CZBibTeXDocBuilder
	
	
]

{ #category : #generate }
CZStef >> bodySpecification [

	^ bodySpecification ifNil: [ bodySpecification := self defaultSpecification ]
]

{ #category : #generate }
CZStef >> bodySpecification: aCollection [ 
	"Symbol taken from #( #PhDAndHabilitation #internationalJournal #nationalJournal #topConference #internationalConference  #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation)"
	
	bodySpecification := aCollection 
]

{ #category : #generate }
CZStef >> defaultSpecification [

	^ #( #internationalJournal #nationalJournal #topConference #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #PhDAndHabilitation)
]

{ #category : #API }
CZStef >> generate [
	generators do: [ :genClass | 
		| builder |
		builder := genClass new
			fileNamed: 'rmod.bib';
			authorMatchingString: '*', 'Ducasse', '*';
			bodySpecification: #( #PhDAndHabilitation #internationalJournal #nationalJournal #topConference #internationalConference  #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation);
			setFilteringOn.
		builder generate.	
		]
]

{ #category : #API }
CZStef >> html [

	generators add: CZXHTMLDocBuilder
	
	
]

{ #category : #initialization }
CZStef >> initialize [

	generators := OrderedCollection new
	
]

{ #category : #API }
CZStef >> latex [

	generators add: CZLaTeXDocBuilder
	
	
]
