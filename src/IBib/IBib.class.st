Class {
	#name : #IBib,
	#superclass : #WAComponent,
	#instVars : [
		'sort',
		'display',
		'editor',
		'czset',
		'info',
		'selectBlock'
	],
	#classInstVars : [
		'file'
	],
	#category : #IBib
}

{ #category : #rendering }
IBib >> EXrenderSortBarOn: html [

	"Render sort bar and link to add a new entry"
		
	html div id: 'sort-bar' ; with: [
					
		html form id: 'form-id' ; with: [

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
						ifFalse: [ self asBibtex ]] .
				
				html text: ' Hide controls: ' .
				html checkbox value: false ; onChange: ( html scriptaculous effect id: 'sort-bar' ; toggleAppear )
			
			
			]]
]

{ #category : #rendering }
IBib >> EXrenderTableListOn: html [
	
	| id sortedBibs |
	
	id := 1 . "id de l'article TODO"
	
	html div id: 'listId' ; with: [

		html table cellpadding: 5 ; class: 'table-list' ; with: [
		
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
	
	] .
]

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

{ #category : #rendering }
IBib >> askAndCreateBibentry [
	| bibentry |
	bibentry := self call: (Bibentry new asComponent addMessage: 'Add a new entry' ; addValidatedForm) .
	bibentry ifNotNil: [ self addBibentry: bibentry ]
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

{ #category : #updating }
IBib >> cancel [
	self answer: false .
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
		
		self renderUploadFileOn: html .
		
		html div class: 'main' ; with: [
									
			html div class: 'subtitle' ; with: [ html span: 'Publications' ] .
			
			(czset isNil)
			ifTrue: [ html div class: 'czset-nil' ; with: 'Import your file, its entries will appear here !' ]
			ifFalse: [
				
				html div class: 'submain' ; with: [
				
					html div class: 'div-top' ; with: [
						html anchor
							callback: [ self askAndCreateBibentry ] ;
							with: 'Add a new entry' .
						
						html form: [
							html textInput callback: [ :value | selectBlock := value ] ; value: 'Search...' .
							html submitButton
								callback: [
									html scriptaculous updater
										id: 'orderedlist' ;
										triggerForm: ( html scriptaculous element up: 'form' ) ;
										callback: [ :ajaxhtml | self renderListOn: ajaxhtml ]
								] ;
								value: 'Ok'
						]
					] .
				
					self renderSortBarOn: html .
				
					html table cellpadding: 10 ; class: 'table-main' ; with: [
						html tableRow: [
							html tableData id: 'td-border' ;verticalAlign: 'top' ; with: [
								
								self renderTableListOn: html . "à remplacer par celle du dessous..."
							
								self renderListOn: html .
								
							] .
						
							html tableData verticalAlign: 'top' ; with: [ html render: editor . ] ] ] ] ] ]
]

{ #category : #rendering }
IBib >> renderListOn: html [

	| helpId |
	"
	(self sort = #Category)
		ifTrue: [ (czset isNil) ifFalse: [ czset sortByAuthor ] ] .
	(self sort = #Author)
		ifTrue: [ czset sortByAuthor ] .
	(self sort = #Year)
		ifTrue: [ czset sortByAuthor ] .
	"
		
	html orderedList id: 'orderedlist' ; class: 'czentry' ; with: [
		(czset isNil) ifFalse:
			[ czset do: [ :czentry |
				
				helpId := html nextId .

				html listItem with: [
					(czentry hasField: #author)
					ifTrue: [ (czentry at: #author ifAbsent: ["do nothing"]) value do: [ :author | html text: author fullName , ' ; ' ] ] .
					
					(czentry hasField: #url)
					ifTrue: [
						html anchor
							class: 'link_title' ;
							url: (czentry at: #url) value ;
							with: (czentry at: #title) value ] 
					ifFalse: [ html span: (czentry at: #title ifAbsent: ["do nothing"]) value ] .
										
					(czentry hasField: #year)
					ifTrue: [ html text: ', ' , (czentry at: #year) value , '. ' ]
					ifFalse: [ html text: '. ' ] .
					
					html span
						class: 'entry_link' ;
						onClick: (html element id: helpId ; toggle) ;
						with: 'edit' .
					
					html space .
					
					html anchor
						class: 'entry_link' ;
						callback: [ czset removeEntry: czentry ] ;
						with: 'remove' .
					
					html space .
					
					html anchor
						class: 'entry_link' ;
						callback: [ czentry addToBibSet: czset ] ;
						with: 'duplicate' .
					
					html div id: helpId ; class: 'form-edit' ; style: 'display: none' ; with: [
						html form: [
							html table style: 'border:1px green solid' ; id: 'edit-form' ; class: 'table-edit' ; with: [
								html tableHead: [
									html tableData align: 'right' ; with: 'key' .
									html tableData align: 'center' ; with: 'value' .
									html tableData align: 'center' ; with: 'delete ?' .
								] .
								czentry do: [ :czfield |
									html tableRow: [
										html tableData style: 'width: 150px;font-weight:bold' ; align: 'right' ; with: (czfield key) , ' : '  .
										html tableData style: 'width: 380px;' ; align: 'center' ; with: [ html textInput size: 45 ; with: (czfield value)  ] .
										html tableData style: 'width: 70px;' ; align: 'center' ; with: [ html checkbox value:false; callback: [ :value | czentry removeFields: #(author) ]]]]].
								html table: [
									html tableRow: [
										html tableData align: 'center' ; with: [
											html span
												class: 'entry_link' ;
												onClick: (html scriptaculous updater
													id: 'edit-form' ;
													insertion: 'bottom' ;
													callback: [ :x |
														x tableRow: [
															x tableData
																style: 'width: 150px;font-weight:bold' ;
																align: 'right' ; with: 'bla : ' .
															x tableData
																style: 'width: 380px;' ;
																align: 'center' ;
																with: [ x textInput size: 45 ; with: 'bla' ] .
															x tableData
																style: 'width: 70px;' ;
																align: 'center' ;
																with: [ x checkbox value:false; callback: [ :value | czentry removeFields: #(author) ]]]] ) ;
												with: 'Add a field' .
									html tableData align: 'center' ; with: [ html submitButton on: #save of: self ] ] ] ] ]
					] ] ] ] ]
]

{ #category : #rendering }
IBib >> renderSortBarOn: html [

	"Render sort bar"
		
	html div id: 'sort-bar' ; with: [
					
		html form id: 'form-id' ; with: [

			html text: 'Sort by: ' .
			html select 
				list: #(#Category #Author #Year) ;
				selected: self sort ;
				onChange: ( html scriptaculous updater
								id: 'orderedlist' ;
								triggerForm: ( html scriptaculous element up: 'form' ) ;
								callback: [ :ajaxhtml | self renderListOn: ajaxhtml ] ) ;
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
								id: 'orderedlist' ;
								triggerForm: ( html scriptaculous element up: 'form' ) ;
								callback: [ :ajaxhtml | self renderListOn: ajaxhtml ] ) ;
				callback: [ :displayValue |
					(displayValue = #Summary)
						ifTrue: [ self asSummary ]
						ifFalse: [ self asBibtex ]] .
				
				html text: ' Hide controls: ' .
				html checkbox value: false ; onChange: ( html scriptaculous effect id: 'sort-bar' ; toggleAppear ) ] ]
]

{ #category : #rendering }
IBib >> renderTableListOn: html [
	
	| id sortedBibs |
	
	id := 1 . "id de l'article TODO"
	
	html div id: 'listId' ; with: [

		html table cellpadding: 5 ; class: 'table-list' ; with: [
		
		sortedBibs := SortedCollection new .
		
		(self sort = #Category)
			ifTrue: [ sortedBibs sortBlock: [ :a :b | a author  <= b author ] ] . "A CHANGER QUAND LA CATEGORIE DE L'ARTICLE SERA PRIS EN COMPTE (remplacer author par category)'"
		(self sort = #Author)
			ifTrue: [ sortedBibs sortBlock: [ :a :b | a author  <= b author ] ] .
		(self sort = #Year)
			ifTrue: [ sortedBibs sortBlock: [ :a :b | a author  <= b author ] ] .
		
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

{ #category : #rendering }
IBib >> renderUploadFileOn: html [
	
	"Champ permettant d'importer un fichier BibText"
	
	| tmp |
	html div class: 'uploadBloc' ; with: [
		html div class: 'uploadFile' ; with: [
			html text: 'Choose a Bibtex File :' .
			html form multipart; with: [
				html fileUpload callback: [ :value |
						(value contentType sub = 'x-bibtex')
						ifTrue: [
							czset := CZBibParser parse: value contents .
							info := value fileName , ' : The file has been imported correctly' .
						]
						ifFalse: [ info := value fileName , ' : File format is incorrect' ] ] .
				html submitButton: 'Parse it !' ]
		] .
		html div class: 'uploadInfo' ; with: info .
	]
]

{ #category : #updating }
IBib >> save [
	
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
		width: 800px;
		font-size: 2em;
		font-weight: normal;
		padding: 10px;
		background-color: #EEE;
		border-radius: 0 30px;
	}
	
	.subtitle span {
		margin-left: 20px;
	}
	
	.uploadBloc{
		border: 1px #AAA dashed;
		width: 820px;
		margin: 20px;
	}
	
	.uploadFile{
		padding: 10px;
	}
	
	.uploadInfo{
		padding: 5px;
		text-align: center;
		background-color: #fafafa;
		color: #007;
	}
	
	.main {
		margin: 20px;
		padding: 0px;
		border-left: 1px #EEE solid;
	}
	
	.submain {
		margin: 10px;
	}
	
	.link_title{
		text-decoration: none;
		color: #704512;
		font-size: 1.1em;
	}
	
	.link_title:hover{
		background-color: #EFEFEF;
		font-size: 1.1em;
	}
	
	.table-list {
		width: 800px;
		font-size: 12px;
	}
	
	.table-edit{
		width: 100%;
	}
	
	.____table-edit tr:first-child{
		background: #F5F5F5;
		height: 20px;
		text-decoration: underline;
	}
		
	.form-edit{
		border: 1px #CCC dashed;
		margin-top: 10px;
		padding: 10px;
		width: 600px;
	}
	
	#sort-bar {
		margin: 10px 0;
	}
	
	#sort-bar span:first-child {
		font-size: 10px;
		cursor: pointer;
	}
		
	.czentry li{
		width: 700px;
		font-size: 12px;
		margin-bottom: 10px;
		padding: 10px;
		list-style-type: decimal
	}
	
	.entry_link{
		color: blue;
		text-decoration: underline;
		cursor: pointer;
	}
	
	.czset-nil{
		margin: 10px;
		padding: 10px;
		font-size: 18px;
		color: #007;
	}
	
	'
]
