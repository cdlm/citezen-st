Class {
	#name : #CZRMODScript,
	#superclass : #CZPersonalWebPageGenerator,
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'as yet unclassified' }
CZRMODScript >> generateTypeOriented20072010 [
	"self new generateTypeOriented20072010"
	
	self inputFileName: 'rmod.bib'.
	self document outputFile: 'rmod2006-10.html'.
	self setAllDisplayPattern: self allDisplayPatternNoWeb.
	self setArticleDisplayPattern: self articleDisplayPatternNoWeb.
	self setConferenceDisplayPattern:  self conferenceDisplayPatternNoWeb.
	
	self document bibsetInput: self select20062009.
	self typeOrientedConfiguration.
	self configure.
	self document restartOrderedListAtEachScript.
	self document generate.
	^ self document
]

{ #category : #'as yet unclassified' }
CZRMODScript >> onlyStefAuthor [
	^ CZTypeQuery checks: [ :each | true] 
]

{ #category : #'as yet unclassified' }
CZRMODScript >> select20062009 [
	
	| rmod selected|	
	rmod :=  (CZBibParser parse: ((FileStream readOnlyFileNamed: inputFileName ) contents)).
	selected := rmod select: (CZFieldQuery 
					named: #year 
					checks: [ :value | value asNumber between: 2007 and: 2010]).
	^ selected
]
