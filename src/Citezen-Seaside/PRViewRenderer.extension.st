Extension { #name : #PRViewRenderer }

{ #category : #'*citezen-seaside' }
PRViewRenderer >> visitBibEntry: aBibEntry [

	(CZHtmlRenderer html: html)
				library: BibPhraseLibrary default;
				render: aBibEntry entry
]
