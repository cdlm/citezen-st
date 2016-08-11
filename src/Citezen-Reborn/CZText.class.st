"
A CZText is a bunch of text.
Why do we need it why can't we use a CZString instead?
To be removed  :)
"
Class {
	#name : #CZText,
	#superclass : #CZDocElement,
	#instVars : [
		'text'
	],
	#category : #'Citezen-Reborn-DocModel'
}

{ #category : #testing }
CZText >> isDefined [

	^ text isNil not
]

{ #category : #accessing }
CZText >> text [

	^ text
]

{ #category : #accessing }
CZText >> text: aString [

	text := aString
]
