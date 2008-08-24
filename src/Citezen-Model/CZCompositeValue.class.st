"
Concatenation expression as value of a BibTeX field or macro (represents the foo # bar notation in BibTeX).
"
Class {
	#name : #CZCompositeValue,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'instance creation' }
CZCompositeValue class >> with: aValue [
	^ self new add: aValue
]

{ #category : #adding }
CZCompositeValue >> add: aValue [
	value add: aValue
]

{ #category : #adding }
CZCompositeValue >> addAll: aCollection [
	value addAll: aCollection
]

{ #category : #'initialize-release' }
CZCompositeValue >> expanded [
	"evaluate recursively and concatenate"
	^ self shouldBeImplemented
]

{ #category : #'initialize-release' }
CZCompositeValue >> initialize [
	super initialize.
	value := OrderedCollection new
]

{ #category : #'initialize-release' }
CZCompositeValue >> isComposite [
	^ true
]

{ #category : #'initialize-release' }
CZCompositeValue >> notExpanded [
	"return the bibtex # notation"
	^ self shouldBeImplemented
]
