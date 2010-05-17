Class {
	#name : #Bibentry,
	#superclass : #Object,
	#instVars : [
		'title',
		'author',
		'year'
	],
	#classVars : [
		'Database'
	],
	#category : #IBib
}

{ #category : #database }
Bibentry class >> addBibentry: aBibentry [
	self bibentries add: aBibentry
]

{ #category : #database }
Bibentry class >> bibentries [
	self createDatabase .
	^ Database ifNil: [ Database := self createDatabase ]
]

{ #category : #database }
Bibentry class >> createDatabase [
	^ OrderedCollection new
		add: ( self title: 'A first entry' author: 'Rascal' year: '2010' ) ;
		add: ( self title: 'A second entry' author: 'Bidochon' year: '2007' ) ;
		yourself
]

{ #category : #descriptions }
Bibentry class >> descriptionAuthor [
	^ (MAStringDescription new)
		selectorAccessor: #author;
		label: 'Author';
		beRequired ;
		priority: 1000;
		yourself
]

{ #category : #descriptions }
Bibentry class >> descriptionTitle [
	^ (MAStringDescription new)
		selectorAccessor: #title;
		label: 'Title';
		beRequired ;
		priority: 1000;
		yourself
]

{ #category : #descriptions }
Bibentry class >> descriptionYear [
	^ (MAStringDescription new)
		selectorAccessor: #year;
		label: 'Year';
		beRequired ;
		priority: 1000;
		yourself
]

{ #category : #database }
Bibentry class >> removeBibentry: aBibentry [
	self bibentries remove: aBibentry
]

{ #category : #database }
Bibentry class >> title: titleString author: authorString year: yearString [
	^ self new
		title: titleString ;
		author: authorString ;
		year: yearString ;
		yourself
]

{ #category : #'as yet unclassified' }
Bibentry >> author [
	^ author
]

{ #category : #'as yet unclassified' }
Bibentry >> author: aString [
	author := aString 
]

{ #category : #'as yet unclassified' }
Bibentry >> title [
	^ title
]

{ #category : #'as yet unclassified' }
Bibentry >> title: aString [
	title := aString
]

{ #category : #'as yet unclassified' }
Bibentry >> year [
	^ year
]

{ #category : #'as yet unclassified' }
Bibentry >> year: aString [
	year := aString 
]
