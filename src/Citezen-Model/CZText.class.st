Class {
	#name : #CZText,
	#superclass : #CZNode,
	#instVars : [
		'string'
	],
	#category : 'Citezen-Rendering2'
}

{ #category : #'instance creation' }
CZText class >> text: aString [
	^ self new setText: aString; yourself
]

{ #category : #'initialize-release' }
CZText >> setText: aString [
	string := aString
]

{ #category : #rendering }
CZText >> streamFrom: anEntry to: aNodeStream [ 
	aNodeStream nextPut: self
]

{ #category : #accessing }
CZText >> text [
	^ string
]
