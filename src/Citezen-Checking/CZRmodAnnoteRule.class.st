Class {
	#name : #CZRmodAnnoteRule,
	#superclass : #CZRmodRule,
	#category : #'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodAnnoteRule >> condition: aCZEntry [
	^ (aCZEntry hasField: #annote)
		ifFalse: [ false ]
		ifTrue: [ #(master internationalconference nationalconference topconference internationaljournal nationaljournal shortpaper internationalworkshop nationalworkshop lectures book tooldemo notrefereed technicalreport report workshopproceedings tutorial insubmission presentation) includes: (aCZEntry at: #annote) rawValue ]
]

{ #category : #'as yet unclassified' }
CZRmodAnnoteRule >> explanation [
	^ '(Inria) Must have field #annote with value in: [master internationalconference nationalconference topconference internationaljournal nationaljournal shortpaper internationalworkshop nationalworkshop lectures book tooldemo notrefereed technicalreport report workshopproceedings tutorial insubmission presentation]'
]
