Class {
	#name : #CPBibFileView,
	#superclass : #PRDefaultView,
	#instVars : [
		'bibFileWidget'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'as yet unclassified' }
CPBibFileView >> children [
	^ Array with: bibFileWidget 
]

{ #category : #'as yet unclassified' }
CPBibFileView >> initialize [
	super initialize.
	bibFileWidget := CPBibFileWidget new
]

{ #category : #'as yet unclassified' }
CPBibFileView >> renderContentOn: html [
	html render: bibFileWidget 
]

{ #category : #'as yet unclassified' }
CPBibFileView >> setContext: aContext [
	super setContext: aContext.
	bibFileWidget bibFile: aContext structure
]
