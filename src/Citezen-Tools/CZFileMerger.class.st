"
A CZFileMerger takes a list of bib files and generate one single bibset.

	
	CZFileMerger new 
		inputFiles: #('lse.bib' 'scg.bib');
		merge

For the moment do not pay attention about duplicates.
"
Class {
	#name : #CZFileMerger,
	#superclass : #CZTool,
	#instVars : [
		'bibSet',
		'inputFiles'
	],
	#category : #'Citezen-Tools'
}

{ #category : #example }
CZFileMerger class >> example [
	"self example"
	
	^ self new 
		inputFiles: #('lse.bib' 'scg.bib');
		merge
]

{ #category : #action }
CZFileMerger >> addBibset: aBibSet [

	bibSet addAll:  aBibSet
]

{ #category : #accessing }
CZFileMerger >> bibset [

	^ bibSet
]

{ #category : #accessing }
CZFileMerger >> bibset: aBibSet [

	bibSet :=  aBibSet
]

{ #category : #'initialize-release' }
CZFileMerger >> initialize [
	
	super initialize.
	bibSet := CZSet withStandardDefinitions.
	inputFiles := #()
]

{ #category : #options }
CZFileMerger >> inputFile: aFilename [

	inputFiles add: aFilename
]

{ #category : #options }
CZFileMerger >> inputFiles: aCollectionOfFilenames [

	inputFiles := aCollectionOfFilenames
]

{ #category : #action }
CZFileMerger >> load: inputFile [

	bibSet addAll:  (CZBibParser parse: ((FileStream readOnlyFileNamed: inputFile) contents)).
	
]

{ #category : #action }
CZFileMerger >> merge [

	inputFiles do: [:each | self load: each].
	^ bibSet
]
