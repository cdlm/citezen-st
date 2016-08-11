"
| builder |
builder := self new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*';
		sectionSpecification: #( #PhDAndHabilitation #internationalJournal #nationalJournal #topConference #internationalConference  #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation);
		setFilteringOn.
	builder generate.	
"
Class {
	#name : #CZBblDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #generate }
CZBblDocBuilder >> extension [
	
	^ '.bbl'
]

{ #category : #accessing }
CZBblDocBuilder >> footerString [

	^ '\end{thebibliography}'
]

{ #category : #utils }
CZBblDocBuilder >> generatorClass [
	^ CZBblGenerator 
]

{ #category : #accessing }
CZBblDocBuilder >> headerString [

	^ '\begin{thebibliography}{100}[Publications 2012-2016]
\small'
]
