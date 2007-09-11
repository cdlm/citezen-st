Class {
	#name : #BibCompositeValue,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : 'Citezen-Model'
}

{ #category : #'instance creation' }
BibCompositeValue class >> with: aValue [
	^ self new add: aValue
]

{ #category : #adding }
BibCompositeValue >> add: aValue [
	values add: aValue
]

{ #category : #adding }
BibCompositeValue >> addAll: aCollection [
	values addAll: aCollection
]

{ #category : #'initialize-release' }
BibCompositeValue >> initialize [
	super initialize.
	values := OrderedCollection new
]
