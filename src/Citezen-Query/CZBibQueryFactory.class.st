"
BibEntry and BibField would be subclasses here, but they are already in Core as subclasses of AbstractBibEntry
"
Class {
	#name : #CZBibQueryFactory,
	#superclass : #Object,
	#category : #'Citezen-Query'
}

{ #category : #querying }
CZBibQueryFactory class >> contains: aString [
	^ self matches: '*' , aString , '*'
]

{ #category : #querying }
CZBibQueryFactory class >> matches: aString [
	^ self subclassResponsibility
]
