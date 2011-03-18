Class {
	#name : #CZAnalysis,
	#superclass : #Object,
	#category : #'Citezen-Analysis'
}

{ #category : #'as yet unclassified' }
CZAnalysis >> loadAndViewAuthors [
	"self new loadAndViewAuthors"
	| stream set mooseSet entries authors mooseUnifiedSet view relevantAuthors |
	stream := UITheme builder
		fileOpen: 'Import model from MSE file' 
		extensions: #('bib').
		
	set := CZBibParser parse: stream contents.

	mooseSet := set select: [:each | 
		(each at: 'keywords' ifAbsent: ['aaa']) value matchesRegex: '.*moose-pub.*' ].

	entries := Set new.
	authors := Dictionary new.
	mooseUnifiedSet := mooseSet do: [:each | 
		| unifiedEntry entryAuthors unifiedAuthor |
		unifiedEntry := CZUnifiedEntry new rawEntry: each.
		entries add: unifiedEntry.
		entryAuthors := CZAuthorParser parse: (each at: 'author' ifAbsent: ['']) value.
		entryAuthors do: [:auth | 
			unifiedAuthor := authors at: auth normalizedName ifAbsentPut: [ 
				CZUnifiedAuthor new rawAuthor: auth ].
			unifiedEntry authors add: unifiedAuthor.
			unifiedAuthor entries add: unifiedEntry ] 
	].
	relevantAuthors := authors select: [:each | (each coAuthors size > 1) and: [each entries size > 2 ]].
	self viewCollaborationMapOfAuthors: relevantAuthors
]

{ #category : #'as yet unclassified' }
CZAnalysis >> viewCollaborationMapOfAuthors: relevantAuthors [

	| view | 
	view := MOViewRenderer new.
	self viewCollaborationMapOfAuthors: relevantAuthors on: view.  
	view open 
]

{ #category : #'as yet unclassified' }
CZAnalysis >> viewCollaborationMapOfAuthors: relevantAuthors on: view [
	view shape rectangle 
		text: [:each | each rawAuthor lastNames first]; 
		bigFont;
		fontColor: Color black;
		fillColor: ( (MONColorLinearNormalizer inContext: relevantAuthors withCommand: [ :each | each entries size ]) maxBrightness: 0.5; yourself);
		withoutBorder.
	view interaction on: MOKeyDown do: [:ann | 
			ann element incomingEdges do: [:each | 
				[each remove] on: Error do: []].
			ann element outgoingEdges do: [:each | [each remove] on: Error do: []].
			ann element remove.
			ann element updateOwner ].
"	view interaction menu: #mooseMenu."
	view nodes: relevantAuthors.
	view shape line color: Color veryLightGray.
	view edges: relevantAuthors from: #yourself toAll: #coAuthors.
	view graphvizLayout
]
