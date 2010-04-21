Class {
	#name : #BibentryView,
	#superclass : #WAComponent,
	#instVars : [
		'bibentry'
	],
	#category : #IBib
}

{ #category : #'as yet unclassified' }
BibentryView >> bibentry [
	^ bibentry ifNil: [ bibentry := Bibentry bibentries first ]
]

{ #category : #'as yet unclassified' }
BibentryView >> bibentry: aBibentry [
	bibentry := aBibentry
]

{ #category : #'as yet unclassified' }
BibentryView >> cancel [
	self answer: false .
]

{ #category : #'as yet unclassified' }
BibentryView >> renderContentOn: html [
	html form: [
		html table class: 'table-edit' ; with: [
				html tableRow: [
					html tableData align: 'center' ; with: 'Title: '  .
					html tableData align: 'center' ; with: [ html textInput on: #title of: self bibentry ]
				] .
				html tableRow: [
					html tableData align: 'center' ; with: 'Author: '  .
					html tableData align: 'center' ; with: [ html textInput on: #author of: self bibentry ]
				] .
				html tableRow: [
					html tableData align: 'center' ; with: 'Year: '  .
					html tableData align: 'center' ; with: [ html textInput on: #year of: self bibentry ]
				] .
				html tableRow: [
					html tableData align: 'center' ; with: [ html cancelButton on: #cancel of: self ] .
					html tableData align: 'center' ; with: [ html submitButton on: #save of: self ]
				] .
		] .
	]
]

{ #category : #'as yet unclassified' }
BibentryView >> save [
	self answer: true .
]
