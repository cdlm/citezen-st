Class {
	#name : #CZUnifiedEntry,
	#superclass : #Object,
	#instVars : [
		'authors',
		'rawEntry'
	],
	#category : #'Citezen-Analysis'
}

{ #category : #accessing }
CZUnifiedEntry >> authors [
	^ authors ifNil: [authors := OrderedCollection new]
]

{ #category : #accessing }
CZUnifiedEntry >> authors: anObject [
	authors := anObject
]

{ #category : #accessing }
CZUnifiedEntry >> rawEntry [
	^ rawEntry
]

{ #category : #accessing }
CZUnifiedEntry >> rawEntry: anObject [
	rawEntry := anObject
]
