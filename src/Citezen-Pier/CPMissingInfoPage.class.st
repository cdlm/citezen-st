"
I am a special kind of query for checking that certain required information appears in all entries that match the fixed query.

I can be used to check that abstracts, download urls etc are present.
"
Class {
	#name : #CPMissingInfoPage,
	#superclass : #CPFixedQuery,
	#category : #'Citezen-Pier'
}

{ #category : #'accessing-description' }
CPMissingInfoPage class >> descriptionRequiredInfoRegex [
	<ignoreForCoverage>
	^ MAStringDescription new
		comment: 'Regex to match author field, or editor field for entries with no author';
		parameterName: 'info';
		accessor: #requiredInfoRegex;
		label: 'Required information regex';
		priority: 25;
		default: CPMissingInfoQuerySpec defaultRequiredInfoRegex;
		beEditable;
		beRequired;
		yourself
]

{ #category : #accessing }
CPMissingInfoPage class >> label [
	^ 'Missing Information Page'
]

{ #category : #initialization }
CPMissingInfoPage >> initialize [
	super initialize.
	querySpec := CPMissingInfoQuerySpec default
]

{ #category : #initialization }
CPMissingInfoPage >> updateQuerySpec [
	super updateQuerySpec.
	querySpec requiredInfoRegex ~= (self read: #descriptionRequiredInfoRegex) ifTrue: 
		[ querySpec requiredInfoRegex: (self read: #descriptionRequiredInfoRegex).
		queryResult := nil ].
	
	self updateQueryResult.
]
