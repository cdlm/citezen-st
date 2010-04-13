Class {
	#name : #CZPeople,
	#superclass : #CZValue,
	#instVars : [
		'people'
	],
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZPeople class >> defaultValue [
	^ self with: #()
]

{ #category : #'as yet unclassified' }
CZPeople class >> fieldsOfThisFormat [
	^ #(author editor)
]

{ #category : #'as yet unclassified' }
CZPeople >> expanded [
	^ people ifNil: [ people := CZAuthorParser parse: value ]
]

{ #category : #'as yet unclassified' }
CZPeople >> rawValueWithBibtexSyntax [ 
	^ '{',self notExpanded,'}'
]

{ #category : #'as yet unclassified' }
CZPeople >> setValue: aValue [
	super setValue: aValue.
	people := nil
]
