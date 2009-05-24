"
I am a special kind of fixed query for publication lists for a given author.

First keywords are used to finds all matching entries.  Then a regex is used to match just those entries with the author regex appearing in the author or editor field.  This will filter out entries appearing in volumes edited by the given author, but authored by other people.

If there are no such entries, then a FixedQuery will do.
"
Class {
	#name : #CPAuthorPage,
	#superclass : #CPFixedQuery,
	#category : #'Citezen-Pier'
}

{ #category : #'accessing-description' }
CPAuthorPage class >> descriptionAuthorRegex [
	<ignoreForCoverage>
	^ MAStringDescription new
		comment: 'Regex to match author field, or editor field for entries with no author';
		parameterName: 'author';
		accessor: #authorRegex;
		label: 'Author/Editor field regex';
		priority: 25;
		default: CPAuthorQuerySpec defaultAuthorRegex;
		beEditable;
		beRequired;
		yourself
]

{ #category : #'accessing-description' }
CPAuthorPage class >> descriptionQueryString [
	<ignoreForCoverage>
	^ MAStringDescription new
		comment: 'Keywords to match all authored or edited works';
		parameterName: 'query';
		accessor: #queryString;
		label: 'Entry keywords';
		priority: 20;
		default: CPAuthorQuerySpec defaultQueryString;
		beEditable;
		beRequired;
		yourself
]

{ #category : #accessing }
CPAuthorPage class >> label [
	^ 'Author Page'
]

{ #category : #initialization }
CPAuthorPage >> initialize [
	super initialize.
	querySpec := CPAuthorQuerySpec default.
]

{ #category : #initialization }
CPAuthorPage >> updateQuerySpec [
	super updateQuerySpec.
	querySpec authorRegex ~= (self read: #descriptionAuthorRegex) ifTrue: 
		[ querySpec authorRegex: (self read: #descriptionAuthorRegex).
		queryResult := nil ].
	
	self updateQueryResult.
]
