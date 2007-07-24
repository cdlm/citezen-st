Class {
	#name : #BibVisitor,
	#superclass : #Object,
	#category : #'Citezen-Rendering'
}

{ #category : #visiting }
BibVisitor >> visit: anObject [
	^ anObject acceptVisitor: self
]

{ #category : #'visiting-phrases' }
BibVisitor >> visitAlternativePhrase: aPhrase [ 
	"walk everywhere by default"
	^ aPhrase do: [:each | self visit: each]
]

{ #category : #'visiting-bibsets' }
BibVisitor >> visitBibSet: aBibSet [
	aBibSet do: [:each | self visit: each]
]

{ #category : #'visiting-phrases' }
BibVisitor >> visitBlockPhrase: aBlockPhrase [
	^ self visit: aBlockPhrase subphrase

]

{ #category : #'visiting-bibsets' }
BibVisitor >> visitEntry: anEntry [
	anEntry do: [:each | self visit: each]
]

{ #category : #'visiting-bibsets' }
BibVisitor >> visitField: aField [
	"do nothing"
]

{ #category : #'visiting-phrases' }
BibVisitor >> visitFieldRef: aPhrase [
]

{ #category : #'visiting-phrases' }
BibVisitor >> visitLiteralPhrase: aPhrase [
]

{ #category : #'visiting-phrases' }
BibVisitor >> visitSequencePhrase: aPhrase [
	^ aPhrase do: [:each | self visit: each]
]
