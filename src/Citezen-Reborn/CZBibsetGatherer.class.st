"
I'm a visitor collecting bib entries that are contained in a structure.
It is handy to build for example the bibtex file associated with a given document.

 CZBibsetGatherer bibsetFrom: aDoc
"
Class {
	#name : #CZBibsetGatherer,
	#superclass : #CZVisitor,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #accessing }
CZBibsetGatherer >> bibset [

	^ bibset
]

{ #category : #'initialize-release' }
CZBibsetGatherer >> initialize [
	
	super initialize.
	bibset := CZSet withStandardDefinitions.
]

{ #category : #visiting }
CZBibsetGatherer >> visit: anObject [ 

	anObject acceptVisitor: self.
]

{ #category : #visiting }
CZBibsetGatherer >> visitBibSet: aSet [
	
	bibset addAll: aSet.
]

{ #category : #visiting }
CZBibsetGatherer >> visitEntry: anEntry [
	
	bibset addEntry: anEntry.
]
