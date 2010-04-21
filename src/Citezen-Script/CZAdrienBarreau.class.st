Class {
	#name : #CZAdrienBarreau,
	#superclass : #Object,
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZAdrienBarreau class >> bib [
	^ (CZScript new)
		sortByField: #annote;
		exportAsBib;
	"	query: ((field named: #year checks: (fieldValue <= 2005 OR: (fieldValue > 2005))) AND: (field named: #annote matches: '*ot*'));"
		query: self myquery;
		blackList: #(u2); 
		displayOrder: #(unpublished * article); 
		fieldsToRemove: #(year)
]

{ #category : #'as yet unclassified' }
CZAdrienBarreau class >> bib2 [
	^ (CZScript new)
		sortByField: #annote;
		exportAsBib;
		query: ((field named: #year checks: (fieldValue <= 2005 OR: (fieldValue > 2005))) AND: (field named: #annote matches: '*ot*'));
		blackList: #(u2); 
		displayOrder: #(unpublished * article)
]

{ #category : #'as yet unclassified' }
CZAdrienBarreau class >> myquery [
	^
	(CZBibTypeQuery checks: [:each | each = 'unpublished']) AND: 
	(CZBibFieldQuery named: #annote checks: [:each | each ~= ''])
]
