"
A CZFileDispatcher takes a bibset and split if in several ones.
It is usefull for creating file for a team or a person out of a large bibset. 

CZFileDispatcher new 
	inBibset: (CZFileMerger new inputFiles: #('lse.bib' 'scg.bib') ; merge);
	outputFilesDescription: {true -> 'rmod.bib' . false -> 'other.bib'};
	dispatchBlock: [:each | each isTeamEntry];
	generate
"
Class {
	#name : #CZFileDispatcher,
	#superclass : #CZTool,
	#instVars : [
		'bibset',
		'dispatchBlock',
		'outputFilesDescription'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZFileDispatcher class >> example [
	"self example"
	
	^ self new
		inBibset: (CZFileMerger new inputFiles: #('lse.bib' 'scg.bib') ; merge);
		outputFilesDescription: {true -> 'rmod.bib' . false -> 'other.bib'};
		dispatchBlock: [:each | each isTeamEntry];
		generate
]

{ #category : #action }
CZFileDispatcher >> dispatch [
	dispatchBlock ifNil: [self error: 'No dispatch block'].
	^ bibset groupedBy: dispatchBlock
]

{ #category : #options }
CZFileDispatcher >> dispatchBlock: aBlock [
	
	dispatchBlock := aBlock

	
]

{ #category : #action }
CZFileDispatcher >> generate [
	
	| splitDict |
	splitDict := self dispatch.
	outputFilesDescription associationsDo: [:ass |
		CZBibtexOutputer new 
			setOutputFile: ass value;
			blackListedFields: CZEntry privateFields;
			initializeOutputStream; 
			visitSet: (splitDict at: ass key);
			contents]
]

{ #category : #options }
CZFileDispatcher >> inBibset: aBibSet [

	bibset := aBibSet
]

{ #category : #'initialize-release' }
CZFileDispatcher >> initialize [

	super initialize.
	bibset := CZSet withStandardDefinitions.
]

{ #category : #options }
CZFileDispatcher >> outputFilesDescription: pairCollection [
	"pairCollection is for example of the form {true -> 'rmod.bib' . false -> 'other.bib'}"
	
	outputFilesDescription := pairCollection
]
