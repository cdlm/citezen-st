"
I manage author filtering.
"
Class {
	#name : #CZSingleAuthorDocBuilder,
	#superclass : #CZDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #building }
CZSingleAuthorDocBuilder >> filter [

	super filter.
	workingBibSet := workingBibSet select: self authorQuery
]
