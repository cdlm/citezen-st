"
I'm responsible for building document. I work on a bib set and once all the filtering is done. Visitors can render them. 


"
Class {
	#name : #CZDocBuilder,
	#superclass : #Object,
	#instVars : [
		'doc',
		'authorMatchingString',
		'originalBibSet',
		'workingBibSet',
		'localization',
		'noEmptySection',
		'shouldFilterNonPublic',
		'keysOfBlackListedEntries'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #queries }
CZDocBuilder >> PhDAndHabilitationQuery [

	^(CZTypeQuery checks: [ :each | each = #phdthesis]) 
			OR: (self annotationWithType:  '*habilitation*')
]

{ #category : #building }
CZDocBuilder >> addBibSection: aQuery withTitle: aString [
	
	| entries |
	entries := (workingBibSet select: aQuery).
	(noEmptySection & entries size isZero)
		ifTrue: [^ self].
	entries sortByDateReverse.	
	self addSection: (CZSection new name: aString; yourself).
	
	self document add:  (CZSet new addAll: entries ; yourself)
	"we recreate a CZ so that we can manage groups of bib in the outputers"
	"may be the sorting should be an option"
]

{ #category : #building }
CZDocBuilder >> addFooter [

	
]

{ #category : #building }
CZDocBuilder >> addHeader [
]

{ #category : #building }
CZDocBuilder >> addSection: aSection [

	doc add: aSection
]

{ #category : #building }
CZDocBuilder >> addTitle: aTitle [

	doc add: aTitle
]

{ #category : #'configuration public api' }
CZDocBuilder >> allowEmptySections [
	
	noEmptySection := false
]

{ #category : #'utility-queries' }
CZDocBuilder >> annotationWithType: aString [

	^  CZFieldQuery 
			named: #annote 
			checks: [ :value | aString match: value ]
]

{ #category : #accessing }
CZDocBuilder >> authorMatchingString [

	^ authorMatchingString
]

{ #category : #'public api' }
CZDocBuilder >> authorMatchingString: aString [

	authorMatchingString := aString
]

{ #category : #queries }
CZDocBuilder >> authorQuery [

	^ CZFieldQuery 
		named: #author 
		checks: [ :value | self authorMatchingString match: value ]
]

{ #category : #'public api' }
CZDocBuilder >> bibset: aBibSet [

	originalBibSet := aBibSet.
	workingBibSet := aBibSet copy.
]

{ #category : #queries }
CZDocBuilder >> bookChapterQuery [
	
	^ CZFieldQuery 
			named: #annote 
			checks: [ :value | '*articlebook*' match: value ]
]

{ #category : #queries }
CZDocBuilder >> bookQuery [

	^ (CZTypeQuery checks: [ :each | each = #book] )
]

{ #category : #'public api' }
CZDocBuilder >> build [
	"public API"
	
	self addHeader.
	self filter.
	self buildBody.
	self addFooter.
]

{ #category : #'public api' }
CZDocBuilder >> buildBody [
	"empty hook"
]

{ #category : #initialize }
CZDocBuilder >> defaultKeysOfBlackListedEntries [ 

	^ #()
]

{ #category : #'configuration public api' }
CZDocBuilder >> doNotAllowEmptySections [
	
	noEmptySection := true
]

{ #category : #'configuration public api' }
CZDocBuilder >> doNotRestartNumberingAfterSection [

	self flag: #youpi
]

{ #category : #'public api' }
CZDocBuilder >> document [
	"public API"
	^ doc
]

{ #category : #queries }
CZDocBuilder >> editorQuery [

	^ ((CZFieldQuery named: #editor checks: [ :value | self authorMatchingString match: value ])
					"AND: (CZBibFieldQuery 
								named: #annote 
								checks: [ :value | '*editor*' match: value ])"
			OR: (self annotationWithType: '*workshopproceedings*') )
]

{ #category : #'configuration public api' }
CZDocBuilder >> english [

	localization english
]

{ #category : #building }
CZDocBuilder >> filter [
	"Filter insubmission and other not blacklisted entries"
	
	self shouldFilterNonPublic ifFalse: [^ self].
	workingBibSet := workingBibSet reject: self inSubmissionQuery.
	workingBibSet := workingBibSet reject: [:each | keysOfBlackListedEntries includes: each key] 
	
	
]

{ #category : #'configuration public api' }
CZDocBuilder >> french [

	localization french.
]

{ #category : #queries }
CZDocBuilder >> inSubmissionQuery [

	^ (CZFieldQuery 
			named: #keywords 
			checks: [ :value | '*insubmission*' match: value ])
]

{ #category : #initialize }
CZDocBuilder >> initialize [

	super initialize.
	doc := CZDoc new.
	self authorMatchingString: '*'.
	localization := CZLocalisation new.
	self doNotAllowEmptySections.
	self setFilteringOn.
	self keysOfBlackListedEntries: self defaultKeysOfBlackListedEntries 
]

{ #category : #queries }
CZDocBuilder >> internationalConferenceQuery [

	^ self annotationWithType:  '*internationalconference*'
]

{ #category : #queries }
CZDocBuilder >> internationalWorkshopQuery [

	^ self annotationWithType:  '*internationalworkshop*'
]

{ #category : #queries }
CZDocBuilder >> invitedQuery [

	^ self annotationWithType:  '*invited*'
]

{ #category : #queries }
CZDocBuilder >> journalQuery [

	^ CZQuery isInternationalJournalQuery
]

{ #category : #junk }
CZDocBuilder >> journals [
	"remove the journals from the working set and return them"
	
	| dictionary |
	dictionary := workingBibSet groupedBy: self journalQuery.
	(dictionary at: false) do: [:each | workingBibSet removeEntry: each].
	^ dictionary at: true.			
	
]

{ #category : #accessing }
CZDocBuilder >> keysOfBlackListedEntries [

	^ keysOfBlackListedEntries
]

{ #category : #'public api' }
CZDocBuilder >> keysOfBlackListedEntries: aCol [ 

	keysOfBlackListedEntries := aCol
]

{ #category : #queries }
CZDocBuilder >> nationalConferenceQuery [

	"pay attention not to put a star else internationalconference will be matched too"
	^ self annotationWithType:  'nationalconference*'
]

{ #category : #queries }
CZDocBuilder >> nationalJournalQuery [

	^ (CZFieldQuery 
			named: #annote 
			checks: [ :value | ('*nationaljournal*' match: value) and: [('*internationaljournal*' match: value) not] ])
]

{ #category : #'configuration public api' }
CZDocBuilder >> setFilteringOff [

	shouldFilterNonPublic := false
]

{ #category : #'configuration public api' }
CZDocBuilder >> setFilteringOn [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := true
]

{ #category : #testing }
CZDocBuilder >> shouldFilterNonPublic [

	^ shouldFilterNonPublic
]

{ #category : #queries }
CZDocBuilder >> toolDemoQuery [

	^ self annotationWithType:  '*tooldemo*'
]

{ #category : #queries }
CZDocBuilder >> topConferenceQuery [
	
	^ self annotationWithType:  '*topconference*'
]

{ #category : #queries }
CZDocBuilder >> vulgarisationQuery [
	
	^ self annotationWithType:  '*vulgarisation*'
]

{ #category : #accessing }
CZDocBuilder >> workingBibSet [ 
	
	^ workingBibSet
]
