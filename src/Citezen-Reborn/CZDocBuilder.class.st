"
I'm responsible for building document. I work on a bib set and once all the filtering is done. Visitors such as CZBibTexGenerator can render them. 



So far having just a title and sections is just enough. In the future we should add paragraph and link 
to easily add a bibtex file synchronized with the entries.


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
		'keysOfBlackListedEntries',
		'fieldOrder'
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
	"adding a section just add a section and a list of entries following it."
	| entries |
	entries := (workingBibSet select: aQuery).
	(noEmptySection & entries size isZero)
		ifTrue: [^ self].
	entries sortByDateReverse.	
	self addSection: (CZSection new title: aString; yourself).
	
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

{ #category : #queries }
CZDocBuilder >> deliverableQuery [

	^ self annotationWithType:  '*deliverable*'
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

	^ ((CZFieldQuery named: #editor checks: [ :value | value containsTeamMember: CZEntry teamMemberPatterns ])
			OR: (self annotationWithType: '*workshopproceedings*') )
]

{ #category : #'configuration public api' }
CZDocBuilder >> english [

	localization english
]

{ #category : #'configuration public api' }
CZDocBuilder >> fieldOrder: aCol [
	"to specify the order and fields that should be displayed"
	
	fieldOrder := aCol 
]

{ #category : #'public api' }
CZDocBuilder >> fileNamed: aStringDotBib [
	
	| bibset2 | 
	bibset2 := CZBibParser parse: ((FileStream readOnlyFileNamed: aStringDotBib) contents).
	bibset2 scope: CZSet standardDefinitions.
	self bibset:  bibset2
	
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

	^ (self annotationWithType:  '*internationalconference*') AND: (self topConferenceQuery) NOT
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

	^ (CZFieldQuery 
			named: #annote 
			checks: [ :value | '*internationaljournal*' match: value ])
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

{ #category : #queries }
CZDocBuilder >> nationalWorkshopQuery [

	^ self annotationWithType:  'nationalworkshop*'
]

{ #category : #queries }
CZDocBuilder >> periodicalQuery [

	^ self annotationWithType:  '*periodical*'
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
CZDocBuilder >> teamEntryQuery [
	
	^ CZEntryQuery checks: [:each | each isTeamEntry]
]

{ #category : #queries }
CZDocBuilder >> technicalReportQuery [

	^ self annotationWithType:  '*technicalreport*'
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
