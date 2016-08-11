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

{ #category : #visitor }
CZValue >> acceptVisitor: aVisitor [
	self subclassResponsibility 
]

{ #category : #accessing }
CZValue >> expanded [
	^ value
]

{ #category : #testing }
CZValue >> isComposite [
	^ false
]

{ #category : #accessing }
CZValue >> notExpanded [
	^ value
]

{ #category : #accessing }
CZValue >> setValue: aValue [
	value := aValue
]
