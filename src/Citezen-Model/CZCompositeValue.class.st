Class {
	#name : #CZCompositeValue,
	#superclass : #CZScoped,
	#instVars : [
		'values'
	],
	#category : 'Citezen-Model'
}

{ #category : #'instance creation' }
CZCompositeValue class >> with: aValue [
	^ self new add: aValue
]

{ #category : #adding }
CZCompositeValue >> add: aValue [
	values add: aValue
]

{ #category : #adding }
CZCompositeValue >> addAll: aCollection [
	values addAll: aCollection
]

{ #category : #'initialize-release' }
CZCompositeValue >> initialize [
	super initialize.
	values := OrderedCollection new
]
