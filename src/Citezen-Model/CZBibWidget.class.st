Class {
	#name : #CZBibWidget,
	#superclass : #CZBibliographyComponent,
	#category : 'Citezen-Seaside'
}

{ #category : #'as yet unclassified' }
CZBibWidget class >> label [
	^'Bib'
]

{ #category : #'as yet unclassified' }
CZBibWidget >> renderContentOn: html [ 
	| bibset sets restset |
	file ifNil: [^ self renderFileUnspecifiedOn: html].
	bibset _ CZBibParser parseStream: file readStream ascii.

	sets _ #(
		('internationaljournal' 'Journal publications')
		('invited' 'Invited publications')
		('articlebook' 'Book chapters')
		('internationalconference' 'Conference publications')
		('internationalworkshop' 'Workshop publications')
		('tooldemo' 'Tool demos')
		('phdthesis' 'Theses')
	).
	restset _ bibset.

	sets do: [:eachPair | | currentSet |
		currentSet _ bibset select: [:each |
			(each at: 'annote' ifAbsent: [nil]) value = eachPair first].
		currentSet sortBy: [:a :b | (a at: 'year' ifAbsent: ['0']) value > (b at: 'year' ifAbsent: ['0']) value].
		currentSet isEmpty ifFalse: [
			html heading level: 1; with: eachPair last .
			(html orderedList)
				class: 'bib';
				with: 
					[(CZBibHtmlRenderer2 html: html)
						library: BibPhraseLibrary default;
						render: currentSet].
		].
		restset _ restset \ currentSet.
	].
	restset sortBy: [:a :b | (a at: 'year' ifAbsent: ['0']) value > (b at: 'year' ifAbsent: ['0']) value].
	restset isEmpty ifFalse: [
		html heading level: 1; with: 'Other publications'.
		(html orderedList)
			class: 'bib';
			with: 
				[(CZBibHtmlRenderer2 html: html)
					library: BibPhraseLibrary default;
					render: restset].
	].

]
