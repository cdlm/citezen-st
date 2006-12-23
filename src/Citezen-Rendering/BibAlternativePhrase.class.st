Class {
	#name : #BibAlternativePhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'rules'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'visitor-double dispatch' }
BibAlternativePhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitAlternativePhrase: self
]

{ #category : #accessing }
BibAlternativePhrase >> add: aPhrase condition: aBlock [ 
	rules add: aBlock -> aPhrase
]

{ #category : #accessing }
BibAlternativePhrase >> do: aBlock [
	^ rules do: [:each | aBlock value: each value]
]

{ #category : #'initialize-release' }
BibAlternativePhrase >> initialize [
	super initialize.
	rules := OrderedCollection new
]

{ #category : #accessing }
BibAlternativePhrase >> subPhraseFor: anEntry [ 
	^ (rules
		detect: [:assoc | assoc key value: anEntry]
		ifNone: [nil -> nil])
		value
]
