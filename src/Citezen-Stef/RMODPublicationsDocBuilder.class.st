"
Silly for now to subclass from singleAuthorDocBuilder (but probably SingleAuthorDocBuilder should be renamed since it has all the entries to build team report)

	self generateLatexForEval2008to2012
"
Class {
	#name : #RMODPublicationsDocBuilder,
	#superclass : #CZSingleAuthorDocBuilder,
	#instVars : [
		'startingYear',
		'endingYear'
	],
	#category : #'Citezen-Stef'
}

{ #category : #generation }
RMODPublicationsDocBuilder class >> generateLatexForEval2008to2012 [
	"normally this is four years so we should stop in 2011 but there are fuzy so let us go until 2012"
	"self generateLatexForEval2008to2012"
	|  builder|
	builder :=  self new
		toLatex;
		english; 
		fileNamed: 'rmod.bib';
		fieldOrder: #(#author 
			  #title 
			  #chapter
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #impactfactor 
			  #misc); 
		startingYear: 2008;
		setFilteringOn;
		yourself.
	builder generateLatexFile.
]

{ #category : #accessing }
RMODPublicationsDocBuilder >> endingYear: anInteger [
	
	endingYear := anInteger
]

{ #category : #building }
RMODPublicationsDocBuilder >> filter [

	super filter.
	workingBibSet := workingBibSet select: self validTeamQuery  "could be also teamEntry"
]

{ #category : #initialize }
RMODPublicationsDocBuilder >> initialize [

	super initialize.
	startingYear := 2008.
	endingYear := 2011.  "normally inria report are for 4 years period"
]

{ #category : #building }
RMODPublicationsDocBuilder >> isFromWithinReportingPeriod: anIntegerRepresentingAYear [
	"we could check also and remove too recent paper - but inria is fuzzy about that"
	^ startingYear <= anIntegerRepresentingAYear
]

{ #category : #building }
RMODPublicationsDocBuilder >> latexName [

	^ 'RMOD Publications'
]

{ #category : #accessing }
RMODPublicationsDocBuilder >> startingYear: anInteger [
	
	startingYear := anInteger
]

{ #category : #building }
RMODPublicationsDocBuilder >> validTeamQuery [

	^ self teamEntryQuery AND: (CZFieldQuery 
								named: #year 
								checks: [ :value | self isFromWithinReportingPeriod: value asNumber])
]
