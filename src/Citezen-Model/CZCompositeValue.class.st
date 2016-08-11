"
A CZCompositeValue represents a string value in a BibTeX field created with the concatenation of CZString or CZMacroReference.
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

{ #category : #visiting }
CZCompositeValue >> acceptVisitor: aVisitor [
	aVisitor visitCompositeValue: self
]

{ #category : #adding }
CZCompositeValue >> add: aValue [
	| realValueToAdd |
	
	(aValue isKindOf: CZScoped) 
		ifTrue: [ aValue scope: self. realValueToAdd := aValue ]
		ifFalse: [
			(aValue isKindOf: Number)	
				ifTrue: [ realValueToAdd := CZInteger new setValue: aValue ]
				ifFalse: [ realValueToAdd := CZString new setValue: aValue ]
			].
		
	value add: realValueToAdd 
]

{ #category : #adding }
CZCompositeValue >> addAll: aCollection [
	aCollection do: [ :each | self add: each].
]

{ #category : #iterating }
CZCompositeValue >> do: aBlock [
	value do: aBlock
]

{ #category : #iterating }
CZCompositeValue >> do: aBlock separatedBy: aSecondBlock [
	value do: aBlock separatedBy: aSecondBlock 
	

]

{ #category : #accessing }
CZCompositeValue >> expanded [
	"evaluate recursively and concatenate"
	| aStream |
	aStream := WriteStream on: String new.
	value do: [ :each | aStream nextPutAll: each expanded ].
	^ aStream contents 
]

{ #category : #'initialize-release' }
CZCompositeValue >> initialize [
	super initialize.
	value := OrderedCollection new
]

{ #category : #testing }
CZCompositeValue >> isComposite [
	^ true
]

{ #category : #accessing }
CZCompositeValue >> notExpanded [
	"return the bibtex # notation"
	
	"^ String streamContents: 
	[  :aStream |
			value do:
				[ :each | (each isKindOf: CZValue)
					ifTrue: [	each notExpanded printOn: aStream ]
					ifFalse: [ aStream nextPutAll: each].		
				]
			separatedBy: 
				[ aStream nextPutAll: ' # ']
	]."

	^ super notExpanded 
]

{ #category : #printing }
CZCompositeValue >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	
	value
		do: 
			[ :each | aStream nextPutAll: (
				(each isKindOf: CZValue) 
					ifTrue: [ each expanded] 
					ifFalse: [ each ]) ]
		separatedBy: 
			[aStream nextPutAll: ' # '].
		
	aStream nextPut: $)
]
