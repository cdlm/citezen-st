"
A BibAlternativePhrase will pick between several alternatives for the actual phrase to use, based on rules.
"
Class {
	#name : #BibAlternativePhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'rules'
	],
	#category : 'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibAlternativePhrase class >> rules: anAssociationCollection [
	|instance|
	instance := self new.
	anAssociationCollection do: [:each |
		instance add: each value condition: each key].
	^ instance
]

{ #category : #'instance creation' }
BibAlternativePhrase class >> rules: anAssociationCollection default: aPhrase [
	^ (self rules: anAssociationCollection)
		default: aPhrase;
		yourself
]

{ #category : #'visitor-double dispatch' }
BibAlternativePhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitAlternativePhrase: self
]

{ #category : #accessing }
BibAlternativePhrase >> add: aPhrase condition: aBlock [ 
	rules add: aBlock -> aPhrase
]

{ #category : #accessing }
BibAlternativePhrase >> default: aPhrase [ 
	rules add: [:whatever | true] -> aPhrase
]

{ #category : #accessing }
BibAlternativePhrase >> do: aBlock [
	^ rules do: [:each | aBlock value: each value]
]

{ #category : #accessing }
BibAlternativePhrase >> do: aBlock for: anEntry [
	^ (self subPhraseFor: anEntry) ifNotNil: [ :it | aBlock value: it ]
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
