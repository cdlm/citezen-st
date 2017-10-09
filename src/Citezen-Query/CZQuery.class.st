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
CZQuery class >> PhDAndHabilitation [
	^ (CZTypeQuery checks: [ :each | each = #phdthesis ])
		OR: (self annotationWithType: '*habilitation*')
]

{ #category : #builder }
CZQuery class >> annotationWithType: aString [

	^  CZFieldQuery 
			named: #annote 
			checks: [ :value | aString match: value ]
]

{ #category : #builder }
CZQuery class >> article [

	^ (CZTypeQuery checks: [ :value | value = 'article' ])
]

{ #category : #builder }
CZQuery class >> book [
	^ CZTypeQuery checks: [ :value | value = #book ]
]

{ #category : #builder }
CZQuery class >> bookChapter [
	^ self annotationWithType: '*articlebook*'
]

{ #category : #builder }
CZQuery class >> booklet [
	^ CZFieldQuery
		named: #annote
		checks: [ :value | 
			 '*booklet*' match: value ]
]

{ #category : #builder }
CZQuery class >> conference [
	^ CZTypeQuery checks: [ :value | value = 'inproceedings' ]
]

{ #category : #builder }
CZQuery class >> deliverable [
	^ self annotationWithType: '*deliverable*'
]

{ #category : #builder }
CZQuery class >> editor [

	^ (CZFieldQuery
		named: #editor
		checks: [ :value | value containsTeamMember: CZEntry teamMemberPatterns ])
		OR: (self annotationWithType: '*workshopproceedings*')
]

{ #category : #builder }
CZQuery class >> inSubmission [
	^ CZFieldQuery named: #keywords checks: [ :value | '*insubmission*' match: value ]
]

{ #category : #'initialize-release' }
CZQuery class >> initialize [
	"self initialize"
	
	CZFalseQueryInstance := CZFalseQuery new.
	CZTrueQueryInstance := CZTrueQuery new
]

{ #category : #builder }
CZQuery class >> internationalConference [
	^ CZFieldQuery
		named: #annote
		checks: [ :value | 
			 '*internationalconference*' match: value ]
]

{ #category : #builder }
CZQuery class >> internationalJournal [
	^ CZFieldQuery
		named: #annote
		checks: [ :value | 
			'*internationaljournal*' match: value ]
]

{ #category : #builder }
CZQuery class >> internationalWorkshop [
	^ self annotationWithType: '*internationalworkshop*'
]

{ #category : #builder }
CZQuery class >> invitedQuery [
	^ self annotationWithType: '*invited*'
]

{ #category : #builder }
CZQuery class >> journal [
	"returns international and national journals."
	^ CZTypeQuery checks: [ :value | value = #article ]
]

{ #category : #builder }
CZQuery class >> nationalConference [
	"pay attention not to put a star else internationalconference will be matched too"

	^ self annotationWithType: 'nationalconference*'
]

{ #category : #builder }
CZQuery class >> nationalJournal [
	^ CZFieldQuery named: #annote checks: [ :value | ('*nationaljournal*' match: value) and: [ ('*internationaljournal*' match: value) not ] ]
]

{ #category : #builder }
CZQuery class >> nationalWorkshop [
	^ self annotationWithType: 'nationalworkshop*'
]

{ #category : #builder }
CZQuery class >> periodical [
	^ self annotationWithType: '*periodical*'
]

{ #category : #builder }
CZQuery class >> phdthesis [
	^ (CZTypeQuery checks: [ :value | value = 'phdthesis' ])
]

{ #category : #builder }
CZQuery class >> teamEntry [
	^ CZEntryQuery checks: [ :each | each isTeamEntry ]
]

{ #category : #builder }
CZQuery class >> techReport [
	^ CZTypeQuery checks: [ :value | value = 'techreport' ]
]

{ #category : #builder }
CZQuery class >> toolDemo [
	^ self annotationWithType: '*tooldemo*'
]

{ #category : #builder }
CZQuery class >> topConference [
	^ self annotationWithType: '*topconference*'
]

{ #category : #builder }
CZQuery class >> vulgarisation [
	^ self annotationWithType: '*vulgarisation*'
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
