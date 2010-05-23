Class {
	#name : #IBib,
	#superclass : #WAComponent,
	#instVars : [
		'sort',
		'display',
		'czset',
		'info',
		'selectBlock',
		'newfield'
	],
	#classInstVars : [
		'file'
	],
	#category : #IBib
}

{ #category : #displaying }
IBib >> asAbstract [ 
	display := #Abstract
]

{ #category : #displaying }
IBib >> asBibtex [
	display := #Bibtex
]

{ #category : #displaying }
IBib >> asSummary [
	display := #Summary
]

{ #category : #displaying }
IBib >> byAuthor [
	sort := #Author
]

{ #category : #displaying }
IBib >> byYear [
	sort := #Year
]

{ #category : #displaying }
IBib >> display [
	^ display ifNil: [ display := #Summary ]
]

{ #category : #initialization }
IBib >> initialize [
	super initialize .
	listAdd := CZEntry types first .
]

{ #category : #rendering }
IBib >> renderAbstractViewOn: html with: czentry and: helpId [

	(czentry hasField: #abstract)
	ifTrue: [
		html div class: 'abstract' ; with: 'Abstract' .
		html paragraph class: 'abstract-content' ; with: [ html text: (czentry at: #abstract) value ]
	]
	ifFalse: [
		html div class: 'abstract' ; with: 'No Abstract'
	]
]

{ #category : #rendering }
IBib >> renderAddSearchOn: html [

	| tmp |
	html div class: 'div-top' ; with: [
		
		html table id: 'add_search' ; with: [
			
			html tableRow: [
				
				html tableData: [ html span class: 'entry_link' ; onClick: (html element id: 'div_add_entry' ; toggle) ; with: 'Add a new entry' . ] .
				
				html tableData: [
					
					html form: [
						html textInput
							id: 'input-search' ;
							style: 'color: #888;' ;
							callback: [ :value | selectBlock := value ] ;
							onClick: (html scriptaculous element id: 'input-search' ; removeAttribute: 'value') ;
							size: 30 ; value: 'Author, title, journal, booktitle...' .
						html submitButton
							callback: [
								html scriptaculous updater
									id: 'orderedlist' ;
									triggerForm: ( html scriptaculous element up: 'form' ) ;
									callback: [ :ajaxhtml | self renderListOn: ajaxhtml ]
							] ; value: 'Search' ] ] ] ] .
		
		html div
			id: 'div_add_entry' ;
			style: 'display:none' ;
			with: [
				self renderFormAddEntryOn: html .
				self renderFormAddFieldOn: html .
			]
		
	]
]

{ #category : #rendering }
IBib >> renderBibtexViewOn: html with: czentry [
	html div class: 'bibtex-view' ; with: [
		html text: '@' , czentry type , '{' , czentry key , ',' .
		html break .
		czentry do: [ :czfield |
			(czfield key = 'author')
			ifTrue: [
				czfield value do: [ :author |
					html space . html space . html space . html space . html space . html space .
					html text: (czfield key) .
					html text: ' = ' .
					html text: (author fullName) .
					html break .
				]
			]
			ifFalse: [
				(czfield key = 'editor')
				ifTrue: [
					czfield value do: [ :editor |
						html space . html space . html space . html space . html space . html space .
						html text: (czfield key) .
						html text: ' = ' .
						html text: (editor fullName) .
						html break .
					]
				]
				ifFalse: [
					html space . html space . html space . html space . html space . html space .
					html text: (czfield key) .
					html text: ' = ' .
					html text: (czfield value) .
					html break .
				]
			]
		] .
		html text: '}' .
	]
]

{ #category : #rendering }
IBib >> renderContentOn: html [

	self renderTitleOn: html .
		
		self renderUploadFileOn: html .
		
		html div class: 'main' ; with: [
			(czset isNil)
			ifFalse: [ self renderAddSearchOn: html ]	 .
									
			html div class: 'subtitle' ; with: [ html span: 'Publications' ] .
			
			(czset isNil)
			ifTrue: [ html div class: 'czset-nil' ; with: 'Import your file, its entries will appear here !' ]
			ifFalse: [
				
				html div class: 'submain' ; with: [
									
					self renderSortBarOn: html .
					
					(selectBlock isNil)
					ifFalse: [ html div id: 'search-text' ; with: 'Search : "' , selectBlock , '"' ] .
				
					self renderListOn: html .
					
					selectBlock := nil .
				
				] ] ]
]

{ #category : #rendering }
IBib >> renderFormAddEntryOn: html [
	
	| entry |
	
	entry := CZEntry new .

	html form id: 'form_add_entry' ; with: [
		html table id: 'list_fields_add' ; with: [
			html tableRow: [
				html tableData style: 'width: 130px;font-size: 0.8em;color:black;font-weight: bold;text-decoration:underline;' ; with: 'Choose a type : ' .
				html tableData: [
					html select
						list: (CZEntry types) ;
						selected: listAdd ;
						callback: [ :value | listAdd := value ] ;
						onChange: (	html scriptaculous updater
											id: 'form_add_entry' ;
											triggerForm: ( html scriptaculous element up: 'form' ) ;
											callback: [ :ajaxhtml | self renderFormAddEntryOn: ajaxhtml ] ) .
				]
			] .
			html tableRow: [
				html tableData: 'key : ' .
				html tableData: [ html textInput callback: [ :value | entry key: value ] ]
			] .
			(CZEntry requiredFieldsFor: listAdd) do: [ :i |
				html tableRow: [
					html tableData: [ html text: i , ' : ' ] .
					html tableData: [ html textInput callback: [ :value | (value isEmpty) ifFalse: [ entry key: i . entry at: i put: value ] ] ]
				] ] .
			html tableRow: [
				html tableData: [ html submitButton callback: [ entry type: listAdd . czset addEntry: entry ] ; with: 'Add an entry' ]
			] ] ] .
]

{ #category : #rendering }
IBib >> renderFormAddFieldOn: html [

	html form id: 'form_add_field' ; with: [
		html table: [
			html tableRow: [
				html tableData style: 'width: 130px;font-size: 0.8em;color:black;font-weight: bold;text-decoration:underline;' ; with: 'Add a field : ' .
				html tableData: [
					html select
						list: (CZEntry optionalFieldsFor: listAdd) ;
						callback: [ :value | newfield := value ] ;
						onChange: (html scriptaculous updater
										id: 'form_add_entry' ;
										insertion: 'bottom' ;
										callback: [ :x |
											x table: [
												x tableRow: [
													x tableData style: 'width: 130px;' ; with: 'newfield :' .
													x tableData: [ x textInput with: '' ] ] ] ] ) ] ] ] ]
]

{ #category : #rendering }
IBib >> renderListOn: html [

	| helpId inc authorAdd listAuthor listDel collectionAuthor deleteAuthor searchCzset |
	
	listDel := Bag new .
	listAuthor := '' .
	collectionAuthor := Bag new .
	deleteAuthor := Bag new .
	searchCzset := CZSet new .
	
	inc := 0 .
	
	(self sort = #Author)
		ifTrue: [ czset sortByAuthor ] .
	(self sort = #Year)
		ifTrue: [ czset sortByDateReverse ] .
	
	html div id: 'div_ord_list' ; with: [ 
		html orderedList id: 'orderedlist' ; class: 'czentry' ; with: [
			
			"if the search block has been specified"
			(selectBlock isNil)
			ifFalse: [
				(czset isNil)
				ifFalse: [
					czset do: [ :czentry |
						(czentry hasField: #author)
						ifTrue: [
							(czentry at: #author) value do: [ :author |
								(author fullName includesSubstring: selectBlock caseSensitive: false)
								ifTrue: [ czentry addToBibSet: searchCzset ]
							]
						] .
						(czentry hasField: #title)
						ifTrue: [
							((czentry at: #title) value includesSubstring: selectBlock caseSensitive: false)
							ifTrue: [ czentry addToBibSet: searchCzset ]
						] .
						(czentry hasField: #journal)
						ifTrue: [
							((czentry at: #journal) value includesSubstring: selectBlock caseSensitive: false)
							ifTrue: [ czentry addToBibSet: searchCzset ]
						] .
						(czentry hasField: #booktitle)
						ifTrue: [
							((czentry at: #booktitle) value includesSubstring: selectBlock caseSensitive: false)
							ifTrue: [ czentry addToBibSet: searchCzset ]
						]
					]
				]
			]
			ifTrue: [ searchCzset := czset ] .
			
			(searchCzset isNil) ifFalse:
				[ searchCzset do: [ :czentry |
					
					helpId := html nextId .

					html listItem with: [
						html div class: 'div-list' ; with: [
						(display = #Bibtex)
						ifTrue: [ self renderBibtexViewOn: html with: czentry ]
						ifFalse: [ self renderSummaryViewOn: html with: czentry and: helpId ] .
						
					html div id: helpId ; class: 'form-edit' ; style: 'display: none' ; with: [
							html form: [
								html table id: 'edit-form' ; class: 'table-edit' ; with: [
									html tableHead: [
										html tableData align: 'right' ; with: 'key' .
										html tableData align: 'center' ; with: 'value' .
										html tableData align: 'center' ; with: 'delete ?' .
									] .
							
									czentry do: [ :czfield |
										(czfield key = 'author')
										ifTrue: [
											czfield value do: [ :author |
												html tableRow: [
													html tableData
														style: 'width: 150px;font-weight:bold' ;
														align: 'right' ;
														with: (czfield key) , ' : '  .
													html tableData
														style: 'width: 380px;' ;
														align: 'center' ;
														with: [
															html textInput
																callback: [ :value | authorAdd := value . collectionAuthor add: authorAdd ] ;
																size: 45 ;
																with: (author fullName)
														] .
													html tableData
														style: 'width: 70px;' ;
														align: 'center' ;
														with: [ html checkbox value: false ; callback: [ :value | value ifTrue: [ deleteAuthor add: authorAdd . authorAdd := '' ] ] ] ] ] ]
										ifFalse: [
											html tableRow: [
												html tableData
													style: 'width: 150px;font-weight:bold' ;
													align: 'right' ;
													with: (czfield key) , ' : '  .
											(czfield key = 'abstract')
												ifTrue: [
													html tableData
														style: 'width: 380px;' ;
														align: 'center' ;
														with: [ html textArea callback: [ :value | czentry at: czfield key put: value ] ; columns: 41 ; rows: 10 ; with: (czfield value)  ] .
												]
												ifFalse: [
													html tableData
														style: 'width: 380px;' ;
														align: 'center' ;
														with: [ html textInput callback: [ :value | czentry at: czfield key put: value ] ; size: 45 ; with: (czfield value)  ] .
												] .
												html tableData
													style: 'width: 70px;' ;
													align: 'center' ;
													with: [ html checkbox value: false ; callback: [ :value | value ifTrue: [ listDel add: (czfield key) ] ] ]
											]]]] .
														
									html table: [
										html tableRow: [
											html tableData style: 'width: 150px;' ; align: 'center' ; with: [
												html span
													class: 'entry_link' ;
													onClick: (html scriptaculous updater
														id: helpId ;
														insertion: 'bottom' ;
														callback: [ :x |
															x tableRow: [
																x tableData
																	style: 'width: 150px;font-weight:bold' ;
																	align: 'right' ;
																	with: 'bla' .
																x tableData
																	style: 'width: 380px;' ;
																	align: 'center' ;
																	with: [ x textInput size: 45 ; with: 'bla' ] .
																x tableData
																	style: 'width: 70px;' ;
																	align: 'center' ;
																	with: [ x checkbox value: false ; callback: [ :value |  ] ] ] ] ) ;
													with: 'Add a field' . ] .
										html tableData
											align: 'center' ;
											with: [	html submitButton
															callback: [
																collectionAuthor := collectionAuthor reject: [ :e | deleteAuthor includes: e ] .
																collectionAuthor do: [ : val |
																	listAuthor := listAuthor , val .
																	inc := inc + 1 .
																	(inc < collectionAuthor size)
																	ifTrue: [ listAuthor := listAuthor , ' and ' ]
																] .
																(collectionAuthor isEmpty)
																ifFalse: [ czentry at: #author put: listAuthor ] .
																czentry fields: (czentry fields reject: [ :each | listDel includes: each key])
															] ;
															with: 'Save' ]
										]
									]
								]
							]
						]
					]
				]
			] 
		]
	]
]

{ #category : #rendering }
IBib >> renderSortBarOn: html [

	"Render sort bar"
		
	html div id: 'sort-bar' ; with: [
					
		html form id: 'form-id' ; with: [

			html text: 'Sort by: ' .
			html select 
				list: #(#none #Author #Year) ;
				selected: self sort ;
				onChange: ( html scriptaculous updater
								id: 'div_ord_list' ;
								triggerForm: ( html scriptaculous element up: 'form' ) ;
								callback: [ :ajaxhtml | self renderListOn: ajaxhtml ] ) ;
				callback: [ :sortValue |
					(sortValue = #none)
					ifFalse: [
						(sortValue = #Author)
							ifTrue: [ self byAuthor ] 
							ifFalse: [ self byYear ] ] ] .
			html text: ' Display: ' .
			html select 
				list: #(#Summary #Abstract #Bibtex) ;
				selected: self display ;
				onChange: ( html scriptaculous updater
								id: 'div_ord_list' ;
								triggerForm: ( html scriptaculous element up: 'form' ) ;
								callback: [ :ajaxhtml | self renderListOn: ajaxhtml ] ) ;
				callback: [ :displayValue |
					(displayValue = #Summary)
						ifTrue: [ self asSummary ]
						ifFalse: [
							(displayValue = #Abstract)
							ifTrue: [ self asAbstract ]
							ifFalse: [ self asBibtex ] ]] .
				
				html text: ' Hide controls: ' .
				html checkbox value: false ; onChange: ( html scriptaculous effect id: 'sort-bar' ; toggleAppear ) ] ]
]

{ #category : #rendering }
IBib >> renderSummaryViewOn: html with: czentry and: helpId [

		(czentry hasField: #author)
		ifTrue: [
			(czentry at: #author) value do: [ :author | html span class: 'author-name' ; with: author fullName , ' / ' ]
		] .
	
		(czentry hasField: #url)
			ifTrue: [
				(czentry hasField: #title)
				ifTrue: [
					html anchor
						class: 'link_title' ;
						url: (czentry at: #url) value ;
						with: (czentry at: #title) value
				]
				ifFalse: [
					html anchor
						class: 'link_title' ;
						url: (czentry at: #url) value ;
						with: (czentry at: #url) value
				] .
			] 
			ifFalse: [
				(czentry hasField: #title)
				ifTrue: [ html span: (czentry at: #title) value ]
			] .
								
			(czentry hasField: #year)
				ifTrue: [
				(czentry hasField: #title)
				ifTrue: [ html text: ', ' , (czentry at: #year) value , '. ' ]
				ifFalse: [
					(czentry hasField: #url)
					ifTrue: [ html text: ', ' , (czentry at: #year) value , '. ' ]
					ifFalse: [ html text: (czentry at: #year) value , '. ' ]
				]
			]
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
				
			(display = #Abstract)
			ifTrue: [ self renderAbstractViewOn: html with: czentry and: helpId ]
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
							czset scope: CZSet months .
							czset scope withStandardDefinitions .
							info := value fileName , ' : The file has been imported correctly' .
						]
						ifFalse: [ info := value fileName , ' : File format is incorrect' ] ] .
				html submitButton: 'Parse it !' ]
		] .
		html div class: 'uploadInfo' ; with: info .
	]
]

{ #category : #displaying }
IBib >> sort [
	^ sort ifNil: [ ]
]

{ #category : #rendering }
IBib >> style [
	^ '
	body {
		margin: 0;
		padding: 0;
		color: #444;
		font-family: serif;
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
	
	.uploadBloc{
		border: 1px #AAA dashed;
		width: 620px;
		margin: 20px;
	}
	
	.div-top{
		width: 620px;
	}
	
	#list_fields_add td{
		width: 130px;
	}
	
	#add_search{
		background-color: #F8F8F8;
		width: 620px;
		margin-bottom: 20px;
	}
	
	#add_search td{
		text-align: center;
	}
	
	.author-name{
		font-weight: bold;
		font-style: italic;
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
	
	#search-text{
		background-color: #987;
		width: 600px;
		padding: 5px;
		color: #FEFEFE;
		font-weight: bold;
	}
	
	.div-list{
		width: 550px;
		text-align: justify;
		line-height: 20px;
	}
	
	.abstract{
		font-weight: bold;
		color: #888;
		font-style:italic;
		margin-top: 10px;
	}
		
	.abstract-content{
		font-style: italic;
	}
	
	#div_add_entry{
		margin-bottom: 20px;
		padding: 5px;
	}
	
	.main {
		margin: 20px;
		padding: 0px;
		border-left: 1px #EEE solid;
	}
	
	.submain {
		margin: 10px;
	}
	
	.bibtex-view{
		background-color: #F5F5F5;
		color: #444;
		padding: 10px;
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
		
	.form-edit{
		border: 1px #CCC dashed;
		margin-top: 10px;
		padding: 10px;
		width: 530px;
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
