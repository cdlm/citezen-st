Class {
	#name : #BibBlockPhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'name',
		'subphrase'
	],
	#category : 'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibBlockPhrase class >> named: aString with: aPhrase [
	^ self new name: aString subphrase: aPhrase 
]

{ #category : #'visitor-double dispatch' }
BibBlockPhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitBlockPhrase: self
]

{ #category : #accessing }
BibBlockPhrase >> name [
	^ name
]

{ #category : #'initialize-release' }
BibBlockPhrase >> name: aString subphrase: aPhrase [
	name := aString.
	subphrase := aPhrase
]

{ #category : #printing }
BibBlockPhrase >> printString [
	^ super printString , '(' , self name printString , ')'
]

{ #category : #accessing }
BibBlockPhrase >> subphrase [
	^ subphrase
]
