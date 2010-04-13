Class {
	#name : #CZString,
	#superclass : #CZValue,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZString class >> defaultValue [
	^ self with: ''
]

{ #category : #'as yet unclassified' }
CZString >> expanded [
	(value class = CZCompositeValue)
		ifTrue:[ ^ value expanded ].
	
	^ value asString reject: [ :each | each = ${ or: [ each = $} ] ]
]

{ #category : #'as yet unclassified' }
CZString >> notExpanded [ 
	(value class = CZCompositeValue)
		ifTrue:[ ^ value notExpanded ].
	
	^ super notExpanded.
]

{ #category : #'as yet unclassified' }
CZString >> rawValueWithBibtexSyntax [ 
	^ '{',value,'}'
]
