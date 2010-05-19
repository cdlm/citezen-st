Class {
	#name : #CZAdrienBarreau,
	#superclass : #CZPersonalScript,
	#category : #'Citezen-Script'
}

{ #category : #script }
CZAdrienBarreau class >> bib [
	^ (CZScript new)
		sortByField: #year;
		reversedSortByField: #annote
	"	query: ((field named: #year checks: (fieldValue <= 2005 OR: (fieldValue > 2005))) AND: (field named: #annote matches: '*ot*'));"
		"query: self myquery;"
		"blackList: #(u2); "
		"displayOrder: #(article *)" 
		"displayPattern: (CZDisplayPattern new field: #year)"
		"fieldsToRemove: #(year)" 
]

{ #category : #script }
CZAdrienBarreau class >> bib2 [
	^ (CZScript new)
		sortByField: #annote;
		exportAsBib;
		query: ((field named: #year checks: (fieldValue <= 2005 OR: (fieldValue > 2005))) AND: (field named: #annote matches: '*ot*'));
		blackList: #(u2); 
		displayOrder: #(unpublished * article)
]

{ #category : #script }
CZAdrienBarreau class >> html [
	^ (CZScript new)
"		sortByField: #annote;"
	"	query: ((field named: #year checks: (fieldValue <= 2005 OR: (fieldValue > 2005))) AND: (field named: #annote matches: '*ot*'));"
		query: self myquery;
"		blackList: #(u2); "
"		displayOrder: #(unpublished *); "
		displayPattern: (CZDisplayPattern new field: #author ; field: #title ; separator: ', In' ; field: #journal ; field: #year; defaultSeparator: ', ')
	"	fieldsToRemove: #(year)"
]

{ #category : #script }
CZAdrienBarreau class >> html2 [
	^ (CZScript new)
		displayPattern: (CZDisplayPattern new field: #*; separator: ', '; field: #annote; beginsWith: ' -> '; endWith: ' <- ');
		defaultSeparator: ', '

]

{ #category : #'as yet unclassified' }
CZAdrienBarreau class >> me [
	^ 'barreau'
]

{ #category : #'as yet unclassified' }
CZAdrienBarreau class >> myquery [
	^
	(CZBibFieldQuery named: #journal checks: [:each | each ~= '']) AND: 
	(CZBibFieldQuery named: #author checks: [:each | '*ducasse*' match: each])
]
