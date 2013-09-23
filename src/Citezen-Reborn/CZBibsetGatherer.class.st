"
I'm a visitor collecting bib entries that are contained in a structure.
It is handy to build for example the bibtex file associated with a given document.

 CZBibsetGatherer bibsetFrom: aDoc

Todo:
--------
Should write a test with a set to see that all the entities inside the set are gathered.
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
	"should not be bibset addAll: aSet entries ? "
]

{ #category : #visiting }
CZBibsetGatherer >> visitEntry: anEntry [
	"We do not treat enttry ie we do not filed fields because we may want to do analysis"
	
	bibset addEntry: anEntry.
]
