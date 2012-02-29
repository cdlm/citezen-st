"
A CZText is a bunch of text
"
Class {
	#name : #CZText,
	#superclass : #CZDocElement,
	#instVars : [
		'text'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #accessing }
CZText >> text [

	^ text
]

{ #category : #accessing }
CZText >> text: aString [

	text := aString
]
