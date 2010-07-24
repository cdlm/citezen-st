Class {
	#name : #CZRMODScript,
	#superclass : #Object,
	#instVars : [
		'document'
	],
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'basic scripts' }
CZRMODScript >> isTeamAuthor [
	"returns whether one member of our team is one of the author"
	
	^ CZFieldQuery named: #author checks: [ :value | '*Ducasse*' match: value ]
]
