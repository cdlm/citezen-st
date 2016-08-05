"
CZQuery is an abstract class.
It defines 3 messages: 
- AND: aQuery
- OR: aQuery
- NOT

These 3 messages are constructors shared by all queries. They respectively create CZAndQuery, CZOrQuery and CZNotQuery instances.

"
Class {
	#name : #CZQuery,
	#superclass : #Object,
	#classVars : [
		'CZFalseQueryInstance',
		'CZTrueQueryInstance'
	],
	#category : #'Citezen-Query'
}

{ #category : #builder }
CZQuery class >> article [

	^ (CZTypeQuery checks: [ :value | value = 'article' ])
]

{ #category : #builder }
CZQuery class >> book [
	^ CZTypeQuery checks: [ :value | value = 'book' ]
]

{ #category : #builder }
CZQuery class >> conference [
	^ CZTypeQuery checks: [ :value | value = 'inproceedings' ]
]

{ #category : #'initialize-release' }
CZQuery class >> initialize [
	"self initialize"
	
	CZFalseQueryInstance := CZFalseQuery new.
	CZTrueQueryInstance := CZTrueQuery new
]

{ #category : #builder }
CZQuery class >> internationalconference [
	^ CZFieldQuery
		named: #annote
		checks: [ :value | 
			 '*internationalconference*' match: value ]
]

{ #category : #builder }
CZQuery class >> internationaljournal [
	^ CZFieldQuery
		named: #annote
		checks: [ :value | 
			'*internationaljournal*' match: value ]
]

{ #category : #builder }
CZQuery class >> phdthesis [
	^ (CZTypeQuery checks: [ :value | value = 'phdthesis' ])
]

{ #category : #builder }
CZQuery class >> techreport [
	^ CZTypeQuery checks: [ :value | value = 'techreport' ]
]

{ #category : #builder }
CZQuery class >> topconference [
	^ CZFieldQuery
		named: #annote
		checks: [ :value | 
			'*topconference*' match: value  ]
]

{ #category : #builder }
CZQuery class >> vulgarisation [
	^ CZFieldQuery
		named: #annote
		checks: [ :value | '*vulgarisation*' match: value ]
]

{ #category : #builder }
CZQuery class >> year [

	^ (CZFieldQuery named: #year checks: [ :value | value asNumber])
]

{ #category : #builder }
CZQuery class >> yearOfValue: aNumberIndicatingYear [

	^ (CZFieldQuery 
		named: #year 
		checks: [ :value | value asNumber =  aNumberIndicatingYear ])
]

{ #category : #public }
CZQuery >> AND: aQuery [
	^ (CZAndQuery new)
		leftAnd: self;
		rightAnd: aQuery;
		yourself
]

{ #category : #public }
CZQuery >> NOT [
	^ CZNotQuery new query: self
]

{ #category : #public }
CZQuery >> OR: aQuery [
	^ (CZOrQuery new)
		leftOr: self;
		rightOr: aQuery;
		yourself
]

{ #category : #public }
CZQuery >> value: aBibEntry [
	^ self subclassResponsibility
]
