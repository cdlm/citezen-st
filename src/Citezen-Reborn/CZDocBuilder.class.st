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
		'workingBibSet',
		'localization'
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

	(workingBib select: aQuery)
]

{ #category : #building }
CZDocBuilder >> addTitle: aTitle [

	doc add: aTitle
]

{ #category : #'utility-queries' }
CZDocBuilder >> annotationWithType: aString [

	^  CZFieldQuery 
			named: #annote 
			checks: [ :value | aString match: value ]
]

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
CZDocBuilder >> bookChapterConferenceQuery [
	
	^ CZFieldQuery 
			named: #annote 
			checks: [ :value | '*articlebook*' match: value ]
]

{ #category : #queries }
CZDocBuilder >> bookQuery [

	^ (CZTypeQuery checks: [ :each | each = #book] )
]

{ #category : #building }
CZDocBuilder >> build [
]

{ #category : #queries }
CZDocBuilder >> conferencesQuery [

	^ (CZFieldQuery named: #editor checks: [ :value | self authorMatchingString match: value ])
					"AND: (CZBibFieldQuery 
								named: #annote 
								checks: [ :value | '*editor*' match: value ])"
					OR: (self annotationWithType:  '*workshopproceedings*')
]

{ #category : #building }
CZDocBuilder >> doNotRestartNumberingAfterSection [
]

{ #category : #building }
CZDocBuilder >> document [

	self build.
	^ doc
]

{ #category : #initialize }
CZDocBuilder >> english [

	localization english
]

{ #category : #initialize }
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

{ #category : #accessing }
CZDocBuilder >> journals [
	"remove the journals from the working set and return them"
	
	| dictionary |
	dictionary := workingBibSet groupedBy: self journalQuery.
	(dictionary at: false) do: [:each | workingBibSet removeEntry: each].
	^ dictionary at: true.			
	
]

{ #category : #queries }
CZDocBuilder >> nationalConferenceQuery [

	^ self annotationWithType:  '*nationalconference*'
]

{ #category : #queries }
CZDocBuilder >> nationalJournalQuery [

	^ (CZFieldQuery 
			named: #annote 
			checks: [ :value | ('*nationaljournal*' match: value) and: [('*internationaljournal*' match: value) not] ])
]

{ #category : #queries }
CZDocBuilder >> toolDemoQuery [

	^ self annotationWithType:  '*tooldemo*'
]

{ #category : #queries }
CZDocBuilder >> topConferenceQuery [
	
	^ self withAnnotationType:  '*topconference*'
]

{ #category : #queries }
CZDocBuilder >> vulgarisationQuery [
	
	^ self withAnnotationType:  '*vulgarisation*'
]

{ #category : #accessing }
CZDocBuilder >> workingBibSet [ 
	
	^ workingBibSet
]
