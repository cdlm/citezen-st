Class {
	#name : #CZQueryTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Tests'
}

{ #category : #running }
CZQueryTest >> setUp [
	bibset := CZBibParser parse: 
	'
	@article { a1,
		author = {Barreau, Adrien},
		title = {title1}
	}
	
	@article { a3,
		author = {Barreau, Adrien},
		title = {title2},
		year = 2003
	}
	
	@article { a2,
		author = {Toto, Robert},
		title = {title3},
		year = 2005
	}
	
	@unpublished { u1,
		author = {Barreau, Adrien},
		title = {titleUn1},
		year = 2005
	}
	
	@misc { m1,
		author = {Toto, Robert},
		title = {title4},
		year = 2000
	}
	'
]

{ #category : #tests }
CZQueryTest >> testBibAndQuery [
	| query query1 query2 collection index |
	query1 := CZBibFieldQuery named: #year checks: [ :each | each > 2004 ].
	query2 := CZBibFieldQuery named: #year checks: [ :each | each < 2006 ].
	query := query1 AND: query2.
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 2).
	
	index := 0.
	bibset entries do: [ :each | ((each at: #year ifAbsent: 2006) value = 2005) ifTrue: 
		[ index := index + 1. 
		  self assert: ((collection at: index) = each) ]]
]

{ #category : #tests }
CZQueryTest >> testBibFieldCompareQuery [
	| query collection index |
	query := CZBibFieldQuery named: #year checks: [ :each | each <= 2005].
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 4).
	
	index := 0.
	bibset entries do: [ :each | ((each at: #year ifAbsent: 2006) value <= 2005) ifTrue: 
		[ index := index + 1. 
		  self assert: ((collection at: index) = each) ]]
]

{ #category : #tests }
CZQueryTest >> testBibFieldMatchQuery [
	| query collection index |
	query := CZBibFieldQuery named: #author checks: [ :each | '*toto*' match: each ].
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 2).
	
	index := 0.
	bibset entries do: [ :each | ('*toto*' match: (each at: #author) rawValue) ifTrue: 
		[ index := index + 1. 
		  self assert: ((collection at: index) = each) ]]
]

{ #category : #tests }
CZQueryTest >> testBibFieldQuery [
	| query collection index |
	query := CZBibFieldQuery named: #year checks: [ :each | each = 2005].
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 2).
	
	index := 0.
	bibset entries do: [ :each | ((each at: #year ifAbsent: 2006) value = 2005) ifTrue: 
		[ index := index + 1. 
		  self assert: ((collection at: index) = each) ]]
]

{ #category : #tests }
CZQueryTest >> testBibFieldQueryWithBadField [
	| query collection |
	query := CZBibFieldQuery named: #yar checks: [ :each | each = 2005].
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 0).
]

{ #category : #tests }
CZQueryTest >> testBibKeyQuery [
	| query collection |
	query := CZBibKeyQuery checks: [ :each | each = #a1].
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 1).
	
	(collection at:1) key = #a1
]

{ #category : #tests }
CZQueryTest >> testBibNotQuery [
	| query collection index |
	query := CZBibTypeQuery checks: [ :each | each = #article].
	query := query NOT.
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 2).
	
	index := 0.
	bibset entries do: [ :each | (each type ~= #article) ifTrue: 
		[ index := index + 1. 
		  self assert: ((collection at: index) = each) ]]
]

{ #category : #tests }
CZQueryTest >> testBibOrQuery [
	| query query1 query2 collection index |
	query1 := CZBibFieldQuery named: #year checks: [ :each | each = 2005 ].
	query2 := CZBibFieldQuery named: #year checks: [ :each | each < 2005 ].
	query := query1 OR: query2.
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 4).
	
	index := 0.
	bibset entries do: [ :each | ((each at: #year ifAbsent: 2006) value <= 2005) ifTrue: 
		[ index := index + 1. 
		  self assert: ((collection at: index) = each) ]]
]

{ #category : #tests }
CZQueryTest >> testBibTypeQuery [
	| query collection index |
	query := CZBibTypeQuery checks: [ :each | each = #article].
	
	collection := bibset entries select: [ :each | query value: each ].
	
	self assert: (collection size = 3).
	
	index := 0.
	bibset entries do: [ :each | (each type = #article) ifTrue: 
		[ index := index + 1. 
		  self assert: ((collection at: index) = each) ]]
]
