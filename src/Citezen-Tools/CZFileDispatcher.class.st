"
A CZFileDispatcher takes a bibset and splits it in several ones.
It is useful for creating files for a team or a person out of a large bibset. 

CZFileDispatcher new 
	inBibset: (CZFileMerger new inputFiles: #('lse.bib' 'scg.bib') ; merge);
	outputFilesDescription: {true -> 'rmod.bib' . false -> 'others.bib'};
	dispatchBlock: [:each | each isTeamEntry];
	generate
"
Class {
	#name : #CZFileDispatcher,
	#superclass : #CZTool,
	#instVars : [
		'bibset',
		'dispatchBlock',
		'outputFilesDescription',
		'blackListedFields'
	],
	#category : 'Citezen-Tools'
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

{ #category : #'as yet unclassified' }
CZFileDispatcher class >> pharoPubs [
	"self pharoPubs"
	^ self new
		inBibset: (CZFileLoader  bibFromFileNamed: 'rmod.bib');
		outputFilesDescription: {true -> 'pharo.bib' . false -> 'plouf.bib'};
		dispatchBlock: [:each | each isPharoPub];
		generate
]

{ #category : #action }
CZFileDispatcher >> blackListedFields [
	
	^ blackListedFields 
]

{ #category : #action }
CZFileDispatcher >> blackListedFields: aCollection [
	
	blackListedFields := aCollection 
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
		CZBibTexGenerator new 
			filename: ass value;
			visitBibSet: (splitDict at: ass key)
			]
]

{ #category : #options }
CZFileDispatcher >> inBibset: aBibSet [

	bibset := aBibSet
]

{ #category : #'initialize-release' }
CZFileDispatcher >> initialize [

	super initialize.
	bibset := CZSet withStandardDefinitions.
	blackListedFields := #()
]

{ #category : #options }
CZFileDispatcher >> outputFilesDescription: pairCollection [
	"pairCollection is for example of the form {true -> 'rmod.bib' . false -> 'other.bib'}"
	
	outputFilesDescription := pairCollection
]
