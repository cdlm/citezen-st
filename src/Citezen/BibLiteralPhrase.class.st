Class {
	#name : #BibLiteralPhrase,
	#superclass : #BibPhrase,
	#instVars : [
		'text'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'instance creation' }
BibLiteralPhrase class >> text: aString [ 
	^ self new setText: aString;
		 yourself
]

{ #category : #'visitor-double dispatch' }
BibLiteralPhrase >> acceptVisitor: aVisitor [
	^ aVisitor visitLiteralPhrase: self
]

{ #category : #'initialize-release' }
BibLiteralPhrase >> setText: aString [
	text := aString
]

{ #category : #accessing }
BibLiteralPhrase >> text [
	^ text
]
