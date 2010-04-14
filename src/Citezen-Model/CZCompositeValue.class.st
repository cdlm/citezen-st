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

{ #category : #'initialize-release' }
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

{ #category : #'initialize-release' }
CZCompositeValue >> do: aBlock [
	value do: aBlock
]

{ #category : #'initialize-release' }
CZCompositeValue >> expanded [
	"evaluate recursively and concatenate"
	| aStream |
	aStream := WriteStream on: String new.

	value
		do: 
			[ :each | aStream nextPutAll: (
				(each isKindOf: CZValue) 
					ifTrue: [ each expanded] 
					ifFalse: [ each ]) ]
		separatedBy: 
			[aStream nextPutAll: ' # '].

	^ aStream contents 
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
	
	^ String streamContents: 
	[  :aStream |
			value do:
				[ :each | (each isKindOf: CZValue)
					ifTrue: [	each notExpanded printOn: aStream ]
					ifFalse: [ aStream nextPutAll: each].		
				]
			separatedBy: 
				[ aStream nextPutAll: ' # ']
	].
]

{ #category : #'as yet unclassified' }
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
