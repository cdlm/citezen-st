Class {
	#name : #CZScriptTest,
	#superclass : #TestCase,
	#category : #'Citezen-Scripts'
}

{ #category : #resources }
CZScriptTest >> bibFileName [
	^ 'testData.bib'
]

{ #category : #resources }
CZScriptTest >> createTestBibFile [
	"self new createTestBibFile"
	(FileDirectory default newFileNamed: self bibFileName)
		nextPutAll: (self scgbibSample copyReplaceAll: String cr with: String lf);
		close
]
