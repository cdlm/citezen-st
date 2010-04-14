Class {
	#name : #CZQueryTest,
	#superclass : #TestCase,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZQueryTest >> setUp [
	entry := (CZBibParser parse: CZTestResource bibTest) entries at:1
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testAND [
	| query1 query2 queryAnd |
	query1 := (CZBibHasField new) field: #author.
	query2 := (CZBibHasField new) field: #author.
	queryAnd := query1 AND: query2.
	
	self assert: queryAnd class = CZBibAnd.
	
	self assert: (query1 value: entry).
	self assert: (query2 value: entry).
	self assert: (queryAnd value: entry).
	
	query2 field: #toto.
	self deny: (query2 value: entry).
	self deny: (queryAnd value: entry)
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testCZBibFieldMatches [
	| query |
	
	query := ((CZBibFieldMatches new) pattern: '*test*') field: #title.
	self assert: (query value: entry).	
	
	query pattern: 'test'.
	self deny: (query value: entry).
	
	query pattern: '*test*'; field: #toto.
	self deny: (query value: entry).
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testCZBibHasField [
	| query |
	query := (CZBibHasField new) field: #author.
	
	self assert: (query value: entry).
	query field: #toto.
	self deny: (query value: entry)
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testCZBibKeyMatches [
	| query |
	
	query := (CZBibKeyMatches new) pattern: '*un*'.
	self assert: (query value: entry).	
	
	query pattern: 'un*'.
	self deny: (query value: entry).
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testCZBibTypeMatches [
	| query |
	
	query := (CZBibTypeMatches new) pattern: 'un*'.
	self assert: (query value: entry).	
	
	query pattern: ''.
	self deny: (query value: entry).
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testEquality [
	"test the = overloads"
	| query1 query2 |

	"CZBibAll"	
	self assert: (CZBibAll new) = (CZBibAll new).

	"CZBibAnd"
	query1 := ((CZBibAnd new) leftAnd: (CZBibAll new)) rightAnd: (CZBibAll new).
	query2 := ((CZBibAnd new) leftAnd: (CZBibAll new)) rightAnd: (CZBibAll new).
	self assert: query1 = query2.
	query2 := (CZBibAnd new).
	self deny: query1 = query2.
	
	"CZBibHasField"
	query1 := ((CZBibHasField new) field: #author).
	query2 := ((CZBibHasField new) field: #author).
	self assert: query1 = query2.
	query2 field: #changed.
	self deny: query1 = query2.
	
	"CZBibMatches"
	query1 := ((CZBibMatches new) pattern: '*abc*').
	query2 := ((CZBibMatches new) pattern: '*abc*').
	self assert: query1 = query2.
	query2 pattern: '*changed*'.
	self deny: query1 = query2.
	
	"CZBibFieldMatches"
	query1 := (((CZBibFieldMatches new) pattern: '*abc*') field: #author).
	query2 := (((CZBibFieldMatches new) pattern: '*abc*') field: #author).
	self assert: query1 = query2.
	query2 field: #changed.
	self deny: query1 = query2.
	
	"CZBibNot"
	query1 := ((CZBibNot new) query: (CZBibAll new)).
	query2 := ((CZBibNot new) query: (CZBibAll new)).
	self assert: query1 = query2.
	query2 query: (CZBibNot new).
	self deny: query1 = query2.

	"CZBibOr"
	query1 := (((CZBibOr new) leftOr: (CZBibAll new)) rightOr: (CZBibAll new)).
	query2 := (((CZBibOr new) leftOr: (CZBibAll new)) rightOr: (CZBibAll new)).
	self assert: query1 = query2.
	query2 leftOr: (CZBibOr new).
	self deny: query1 = query2.
	query2 leftOr: (CZBibAll new).
	query2 rightOr: (CZBibOr new).
	self deny: query1 = query2.
	
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testNOT [
	| query queryNot |
	query := (CZBibHasField new) field: #author.
	queryNot := query NOT.
	
	self assert: queryNot class = CZBibNot.
	
	self assert: (query value: entry).
	self deny: (queryNot value: entry).
	
	query field: #toto.
	self assert: (queryNot value: entry).
	
]

{ #category : #'as yet unclassified' }
CZQueryTest >> testOR [
	| query1 query2 queryOr |
	query1 := (CZBibHasField new) field: #author.
	query2 := (CZBibHasField new) field: #author.
	queryOr := query1 OR: query2.
	
	self assert: queryOr class = CZBibOr.
	
	self assert: (query1 value: entry).
	self assert: (query2 value: entry).
	self assert: (queryOr value: entry).
	
	query2 field: #toto.
	self deny: (query2 value: entry).
	self assert: (queryOr value: entry).
	
	query1 field: #toto.
	self deny: (query1 value: entry).
	self deny: (queryOr value: entry)
]
