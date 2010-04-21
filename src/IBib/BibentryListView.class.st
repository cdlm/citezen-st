Class {
	#name : #BibentryListView,
	#superclass : #WAComponent,
	#category : #IBib
}

{ #category : #'as yet unclassified' }
BibentryListView >> addBibentry [
	| title |
	title := self request: 'Title: ' .
	Bibentry addBibentry: ( Bibentry title: title )
]

{ #category : #'as yet unclassified' }
BibentryListView >> editBibentry: aBibentry [
	| view copy |
	view := BibentryView new .
	copy := aBibentry copy .
	view bibentry: copy .
	( self call: view ) ifTrue: [ Bibentry removeBibentry: aBibentry ; addBibentry: copy ]
]

{ #category : #'as yet unclassified' }
BibentryListView >> removeBibentry: aBibentry [
	( self confirm: 'Voulez-vous supprimer cette entree ?' )
	ifTrue: [ Bibentry removeBibentry: aBibentry  ] .
]

{ #category : #'as yet unclassified' }
BibentryListView >> renderBibentry: aBibentry on: html [
	html render: aBibentry title .
	html text: '(' .
	html anchor 
		callback: [ self editBibentry: aBibentry ] ;
		with: 'edit' .
	html space .
	html anchor
		callback: [ self removeBibentry: aBibentry ] ;
		with: 'remove' .
	html text: ')' .
]

{ #category : #'as yet unclassified' }
BibentryListView >> renderContentOn: html [
	html anchor
		callback: [ self addBibentry ] ;
		with: 'Add a new entry' .
	html unorderedList: [
		Bibentry bibentries do: [ :bibentry |
			html listItem: [ self renderBibentry: bibentry on: html ]
		]
	]
]
