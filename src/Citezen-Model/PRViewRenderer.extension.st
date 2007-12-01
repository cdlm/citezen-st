Extension { #name : #PRViewRenderer }

{ #category : #'*citezen-seaside' }
PRViewRenderer >> visitBibEntry: aBibEntry [

	(CZBibEntryHtmlRenderer html: html)
				library: BibPhraseLibrary default;
				render: aBibEntry entry
]
