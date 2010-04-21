Class {
	#name : #IBib,
	#superclass : #WAComponent,
	#instVars : [
		'sort',
		'display',
		'editor'
	],
	#category : #IBib
}

{ #category : #updating }
IBib >> addBibentry: aBibentry [
	Bibentry addBibentry: aBibentry
]

{ #category : #displaying }
IBib >> asBibtex [
	display := #Bibtex
]

{ #category : #displaying }
IBib >> asSummary [
	display := #Summary
]

{ #category : #updating }
IBib >> askAndCreateBibentry [
	| title author year |
	title := self request: 'Title: ' .
	author := self request: 'Author: ' .
	year := self request: 'Year: ' .
	self addBibentry: ( Bibentry title: title author: author year: year )
]

{ #category : #initialization }
IBib >> bibentries [
	^ Bibentry bibentries
]

{ #category : #displaying }
IBib >> byAuthor [
	sort := #Author
]

{ #category : #displaying }
IBib >> byCategory [
	sort := #Category
]

{ #category : #displaying }
IBib >> byYear [
	sort := #Year
]

{ #category : #initialization }
IBib >> children [
	^ Array with: editor
]

{ #category : #displaying }
IBib >> display [
	^ display ifNil: [ display := #Summary ]
]

{ #category : #updating }
IBib >> editBibentry: aBibentry [
	editor bibentry: aBibentry .
]

{ #category : #initialization }
IBib >> initialize [
	super initialize .	
	editor := BibentryView new .
	editor bibentry: self bibentries first .
]

{ #category : #updating }
IBib >> removeBibentry: aBibentry [
	( self confirm: 'Voulez-vous vraiment supprimer l''entree ' , aBibentry title printString , ' ?' )
		ifTrue: [ Bibentry removeBibentry: aBibentry ]
]

{ #category : #rendering }
IBib >> renderArticleOn: html with: aBibentry [
	
	html div class: 'article' ; with: [
		
		( self display = #Summary )
			ifTrue: [
				"AFFICHER LES ARTICLES EN MODE SOMMAIRE"
				html text: 'summary ' .
			]
			ifFalse: [
				"AFFICHER LES ARTICLES EN MODE BIBTEX"
				html text: 'bibtex ' .
			] .
		
		html text: '[' , aBibentry year , ']' .
		html space .
		html text: aBibentry author .
		html space .
		html text: aBibentry title .
		html space .
		
		html anchor 
			callback: [ self editBibentry: aBibentry ] ;
			with: 'edit' .
		
		html space .
			
		html anchor 
			callback: [ self removeBibentry: aBibentry ] ;
			with: 'remove' .
					
	]
]

{ #category : #rendering }
IBib >> renderContentOn: html [

		self renderTitleOn: html .
		
		html div class: 'main' ; with: [
			
			html div class: 'subtitle' ; with: [ html span: 'Publications' ] .
			
			html div class: 'submain' ; with: [
					
				self renderSortBarOn: html .
				
				html anchor
					callback: [ self askAndCreateBibentry ] ;
					with: 'Add a new entry' .
				
				html table cellpadding: 10 ; class: 'table-main' ; with: [
					html tableRow: [
						html tableData id: 'td-border' ;verticalAlign: 'top' ; with: [ self renderTableListOn: html ] .
						html tableData verticalAlign: 'top' ; with: [ html render: editor . ]
					]
				]
			]
		]
]

{ #category : #rendering }
IBib >> renderSortBarOn: html [

	"Render sort bar and link to add a new entry"
		
	html div class: 'sort-bar' ; with: [
		html form: [
			html text: 'Sort by: ' .
			html select 
				list: #(#Category #Author #Year) ;
				selected: self sort ;
				onChange: ( html scriptaculous updater
								id: 'listId' ;
								triggerForm: ( html scriptaculous element up: 'form' ) ;
								callback: [ :ajaxhtml | self renderTableListOn: ajaxhtml ] ) ;
				callback: [ :sortValue |
					(sortValue = #Category)
						ifTrue: [ self byCategory ] 
						ifFalse: [ (sortValue = #Author)
									ifTrue: [ self byAuthor ]
									ifFalse: [ self byYear ] ] ] .
		
			html text: ' Display: ' .
			html select 
				list: #(#Summary #Bibtex) ;
				selected: self display ;
				onChange: ( html scriptaculous updater
								id: 'listId' ;
								triggerForm: ( html scriptaculous element up: 'form' ) ;
								callback: [ :ajaxhtml | self renderTableListOn: ajaxhtml ] ) ;
				callback: [ :displayValue |
					(displayValue = #Summary)
						ifTrue: [ self asSummary ]
						ifFalse: [ self asBibtex ] ] ] ] .
]

{ #category : #rendering }
IBib >> renderTableListOn: html [
	
	| id sortedBibs |
	
	id := 1 . "id de l'article TODO"
	
	html table cellpadding: 5 ; class: 'table-list' ; id:'listId' ; with: [
	
	sortedBibs := SortedCollection new .
	
	(self sort = #Category)
		ifTrue: [ sortedBibs sortBlock: [ :a :b | a author  <= b author ] ] . "A CHANGER QUAND LA CATEGORIE DE L'ARTICLE SERA PRIS EN COMPTE (remplacer author par category)'"
	(self sort = #Author)
		ifTrue: [ sortedBibs sortBlock: [ :a :b | a author  <= b author ] ] .
	(self sort = #Year)
		ifTrue: [ sortedBibs sortBlock: [ :a :b | a year  <= b year ] ] .
	
	sortedBibs addAll: self bibentries .
	
	sortedBibs do: [ :bibentry |
	
		html tableRow: [
			
			html tableData verticalAlign: 'top' ; with: [
				html text: id . id := id + 1 .
				html text: '.' .
			] .
			
			html tableData: [ self renderArticleOn: html with: bibentry ] .
		
		] .	
	] .

	] .
]

{ #category : #rendering }
IBib >> renderTitleOn: html [
	
	"Render title"
	
	html div class: 'title' ; with: [
		html heading level: 1 ; with: 'WebibTex' .
		html heading level: 3 ; with: 'Edition of Bibtex files Wizard' .
	] .
]

{ #category : #displaying }
IBib >> sort [
	^ sort ifNil: [ sort := #Category ]
]

{ #category : #rendering }
IBib >> style [
	^ '
	body {
		margin: 0;
		padding: 0;
		color: #444;
		font-family: sans-serif;
	}
		
	h1, h2, h3, h4, h5, h6 { margin: 0; padding: 0; }
	
	.title {
		color: #FFFFFF;
		background-color: #084B8A;
		padding: 10px;
		border-bottom: 5px #AAA solid;
	}
	
	.subtitle {
		color: #111;
		width: 600px;
		font-size: 2em;
		font-weight: normal;
		padding: 10px;
		background-color: #EEE;
		border-radius: 0 30px;
	}
	
	.subtitle span {
		margin-left: 20px;
	}
	
	.main {
		margin: 20px;
		padding: 0px;
		border-left: 1px #EEE solid;
	}
	
	.submain {
		margin: 10px;
	}
	
	.table-main #td-border {
		border-right: 1px #EEE solid;
	}
	
	.table-list {
		width: 600px;
		font-size: 0.75em;
	}
	
	.table-list-article {
		border: 1px red solid;
	}
	
	.table-edit {
		width: 500px;
	}
	
	.sort-bar {
		margin: 20px 0;
	}
	
	'
]
