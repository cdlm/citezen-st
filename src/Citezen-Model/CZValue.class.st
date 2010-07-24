"
Hierarchy of values that a field can hold. Handles bib-specific stuff like expansion of values like macro references without overloading base classes.
"
Class {
	#name : #CZValue,
	#superclass : #CZScoped,
	#instVars : [
		'value'
	],
	#category : #'Citezen-Model'
}

{ #category : #default }
CZValue class >> defaultValue [
	"Should be subclassResponsibility, but abused for undefined values"
	^ self with: ''
]

{ #category : #default }
CZValue class >> fieldsOfThisFormat [
	^ #()
]

{ #category : #'instance creation' }
CZValue class >> with: aValue [
	^ self new setValue: aValue
]

{ #category : #'as yet unclassified' }
CZValue >> acceptVisitor: aVisitor [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZValue >> expanded [
	^ value
]

{ #category : #'as yet unclassified' }
CZValue >> isComposite [
	^ false
]

{ #category : #'as yet unclassified' }
CZValue >> notExpanded [
	^ value
]

{ #category : #'as yet unclassified' }
CZValue >> setValue: aValue [
	value := aValue
]
