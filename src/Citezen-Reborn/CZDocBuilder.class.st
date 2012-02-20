"
I'm responsible for building document. I work on a bib set and once all the filtering is done. Visitors can render them. 


"
Class {
	#name : #CZDocBuilder,
	#superclass : #Object,
	#instVars : [
		'author',
		'title',
		'bibset',
		'doc',
		'authorMatchingString',
		'originalBibSet',
		'workingBibSet'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #queries }
CZDocBuilder >> authorInternationalJournalQuery [

	^ (self authorQuery AND: CZQuery isInternationalJournalQuery)
]

{ #category : #accessing }
CZDocBuilder >> authorMatchingString [

	^ authorMatchingString
]

{ #category : #accessing }
CZDocBuilder >> authorMatchingString: aString [

	authorMatchingString := aString
]

{ #category : #queries }
CZDocBuilder >> authorQuery [

	^ CZFieldQuery 
		named: #author 
		checks: [ :value | self authorMatchingString match: value ]
]

{ #category : #accessing }
CZDocBuilder >> bibset: aBibSet [

	originalBibSet := aBibSet.
	workingBibSet := aBibSet copy.
]

{ #category : #queries }
CZDocBuilder >> bookQuery [

	^ CZTypeQuery checks: [ :each | each = #book] 
]

{ #category : #queries }
CZDocBuilder >> inSubmissionQuery [

	^ CZFieldQuery 
		named: #keywords 
		checks: [ :value | '*insubmission*' match: value ]
]

{ #category : #'initialize-release' }
CZDocBuilder >> initialize [

	super initialize.
	doc := CZDoc new.
	self authorMatchingString: '*'
	
]

{ #category : #queries }
CZDocBuilder >> journalQuery [

	^ CZQuery isInternationalJournalQuery
]

{ #category : #accessing }
CZDocBuilder >> journals [
	"remove the journals from the working set and return them"
	
	| dictionary |
	dictionary := workingBibSet groupedBy: self journalQuery.
	(dictionary at: false) do: [:each | workingBibSet removeEntry: each].
	^ dictionary at: true.			
	
]

{ #category : #accessing }
CZDocBuilder >> workingBibSet [ 
	
	^ workingBibSet
]
