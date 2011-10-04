Class {
	#name : #CZLocalisation,
	#superclass : #Object,
	#classVars : [
		'English',
		'French',
		'InternationalReview',
		'Language'
	],
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'as yet unclassified' }
CZLocalisation class >> initialize [
	"self initialize"
	
	InternationalReview := #internationReview.
	
	English := Dictionary new.
	English at: InternationalReview put: 'Refereed Articles in International Journals'.


	French := Dictionary new.
	French at: InternationalReview put: 'Revues internationales avec comit\''e de lecture'.	.
	
]

{ #category : #accessing }
CZLocalisation class >> internationalReviewTitle [

	^ Language at: InternationalReview
]

{ #category : #'as yet unclassified' }
CZLocalisation >> internationalReviewTitle [

	^ Language at: InternationalReview
]
