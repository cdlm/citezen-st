"
A BibNamedPhrase wraps another BibPhrase to give it a name, or mark it as a block. Name and block-ness are left for the renderer to interpret.
"
Class {
	#name : #BibNamedPhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'name',
		'isBlock',
		'subphrase'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibNamedPhrase class >> blockNamed: aString with: aPhrase [ 
	^ self new blockName: aString subphrase: aPhrase
]

{ #category : #'instance creation' }
BibNamedPhrase class >> named: aString with: aPhrase [ 
	^ self new name: aString subphrase: aPhrase
]

{ #category : #'visitor-double dispatch' }
BibNamedPhrase >> acceptVisitor: aVisitor [ 
	^ aVisitor visitNamedPhrase: self
]

{ #category : #'initialize-release' }
BibNamedPhrase >> blockName: aString subphrase: aPhrase [ 
	name := aString.
	isBlock := true.
	subphrase := aPhrase
]

{ #category : #accessing }
BibNamedPhrase >> isBlock [
	^ isBlock
]

{ #category : #accessing }
BibNamedPhrase >> name [
	^ name
]

{ #category : #'initialize-release' }
BibNamedPhrase >> name: aString subphrase: aPhrase [ 
	name := aString.
	isBlock := false.
	subphrase := aPhrase
]

{ #category : #printing }
BibNamedPhrase >> printString [
	^ super printString , '(' , self name printString , ')'
]

{ #category : #accessing }
BibNamedPhrase >> subphrase [
	^ subphrase
]
