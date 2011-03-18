Class {
	#name : #CZUnifiedAuthor,
	#superclass : #Object,
	#instVars : [
		'rawAuthor',
		'entries'
	],
	#category : #'Citezen-Analysis'
}

{ #category : #queries }
CZUnifiedAuthor >> coAuthors [ 
	| coAuthors |
	coAuthors := Set new.
	self entries do: [:entry | 
		entry authors do: [:author | author = self ifFalse: [coAuthors add: author ]] ].
	^ coAuthors
]

{ #category : #accessing }
CZUnifiedAuthor >> entries [
	^ entries ifNil: [entries := OrderedCollection new]
]

{ #category : #accessing }
CZUnifiedAuthor >> entries: anObject [
	entries := anObject
]

{ #category : #accessing }
CZUnifiedAuthor >> rawAuthor [
	^ rawAuthor
]

{ #category : #accessing }
CZUnifiedAuthor >> rawAuthor: anObject [
	rawAuthor := anObject
]
