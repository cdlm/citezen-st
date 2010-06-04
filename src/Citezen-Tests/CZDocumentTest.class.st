Class {
	#name : #CZDocumentTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZDocumentTest >> setUp [
	bibset := CZBibParser parse: '
	@article{key1,
		author = {Barreau, Adrien},
		annote = {a},
		title = {article / key 1},
		year = 2000
	}
	
	@article{key2,
		author = {Barreau, Adrien},
		annote = {b},
		title = {article / key 2},
		year = 2002
	}
	
	@misc{key3,
		author = {Barreau, Adrien and Marcel, Robert},
		annote = {c},
		title = {misc / key 3},
		year = 2001
	}
	
	@misc{key4,
		author = {Barreau, Adrien and Marcel, Robert},
		annote = {d},
		title = {article},
		year = 2001
	}
	
	@misc{key5,
		author = {Chat, Le},
		annote = {choucroute},
		title = {Le chat aime la choucroute},
		year = 2001,
		note = {note}
	}
	'
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testAddCommentAndTitle [
	| generation |
	generation := 
		CZDocument new 
			addElement: (CZCommentElement newComment: 'Citezen power!');
			addElement: (CZTitleElement newTitle: 'Default script:');
			addElement: (CZCommentElement newComment: 'Another comment');
			bibsetInput: bibset;
			exportAsText;
			generate.
		
	self assert: generation =  
'(Citezen power!)

Default script:

(Another comment)

- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'

"The default script is removed only when another script is added.
But you can see that the comments (and titles) are displayed before this script."
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testAddCommentElement [
	| generation |
	generation := 
		CZDocument new 
			addElement: (CZCommentElement newComment: 'Citezen power!');
			bibsetInput: bibset;
			exportAsText;
			generate.
		
	self assert: generation =  
'(Citezen power!)

- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'

"The default script is removed only when another script is added.
But you can see that the comments (and titles) are displayed before this script."
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testAddMultipleScriptsWithAndWithoutDouble [
	| generation |
	generation := 
		CZDocument new 
			addElement: (CZScript new blackList: #(key1 key2));
			addElement: CZScript new;
			bibsetInput: bibset;
			exportAsText;
			withoutDoubles; "by default, the option is set to withoutDoubles, this line can be removed"
			generate.
		
	self assert: generation =  
'- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002'.

	generation := 
		CZDocument new 
			addElement: (CZScript new blackList: #(key1 key2));
			addElement: CZScript new;
			bibsetInput: bibset;
			exportAsText;
			withDoubles;
			generate.
		
	self assert: generation =  
'- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note 

- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'


]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testAddScript [
	| generation |
	generation := 
		CZDocument new 
			addElement: CZScript new;
			bibsetInput: bibset;
			exportAsText;
			generate.
		
	self assert: generation =  
'- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'

"As you can see, this is the same thing that
CZDocument new 
	bibsetInput: bibset;
	exportAsText;
	generate.
	
Take a look at testQuickGeneration
"
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testAddTitleElement [
	| generation |
	generation := 
		CZDocument new 
			addElement: (CZTitleElement newTitle: 'Default script:');
			bibsetInput: bibset;
			exportAsText;
			generate.
		
	self assert: generation =  
'Default script:

- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'

"The default script is removed only when another script is added.
But you can see that the comments (and titles) are displayed before this script."
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testHtmlHeaderAndFooter [
	| document |
	document := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibKeyQuery checks: [ :key | key = 'key1' ]));
			bibsetInput: bibset;
			exportAsHtml;
			withDoubles. "by default, the option is set to withDoubles, this line can be removed"
		
	self assert: document generate =  
'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
	<head>
		<title>default.html</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	</head>
<body>

<ul>
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ul>

</body>
</html>'.

"///"

	document := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibKeyQuery checks: [ :key | key = 'key1' ]));
			bibsetInput: bibset;
			exportAsHtml;
			header: '<html><head><title>Title</title></head><body>

';
			footer: '</body><!-- End of document --></html>'.
	
	self assert: document generate =  
'<html><head><title>Title</title></head><body>

<ul>
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ul>

</body><!-- End of document --></html>'.

"///"

	document := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibKeyQuery checks: [ :key | key = 'key1' ]));
			bibsetInput: bibset;
			exportAsHtml;
			withoutHeaderAndFooter.
	
	self assert: document generate =  
'<ul>
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ul>'.
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testHtmlList [
	| document |
	document := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibKeyQuery checks: [ :key | key = 'key1' ]));
			bibsetInput: bibset;
			withoutHeaderAndFooter;
			exportAsHtml;
			unorderedList. "by default, the option is set to unorderedList, this line can be removed"
		
	self assert: document generate =  
'<ul>
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ul>'.

	document := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibKeyQuery checks: [ :key | key = 'key1' ]));
			bibsetInput: bibset;
			withoutHeaderAndFooter;
			exportAsHtml;
			orderedList.

	self assert: document generate =  
'<ol start="1">
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ol>'.
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testHtmlRestartOrderedListIndex [
	| document |
	document := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibFieldQuery named: #year checks: [ :year | year = 2000 ]));
			addElement: (CZScript new query: (CZBibFieldQuery existingFieldNamed: #note));
			bibsetInput: bibset;
			withoutHeaderAndFooter;
			withDoubles;
			exportAsHtml;
			orderedList;
			restartOrderedListAtEachScript. "by default, the option is set to restartOrderedListAtEachScript, this line can be removed"
		
	self assert: document generate =  
'<ol start="1">
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ol>

<ol start="1">
<li> <span class="author">Le Chat</span> <span class="annote">choucroute</span> <span class="title">Le chat aime la choucroute</span> <span class="year">2001</span> <span class="note">note</span> </li>
</ol>'.

"///"

	document := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibFieldQuery named: #year checks: [ :year | year = 2000 ]));
			addElement: (CZScript new query: (CZBibFieldQuery existingFieldNamed: #note));
			bibsetInput: bibset;
			withoutHeaderAndFooter;
			withDoubles;
			exportAsHtml;
			orderedList;
			doNotRestartOrderedListAtEachScript. 
		
	self assert: document generate =  
'<ol start="1">
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ol>

<ol start="2">
<li> <span class="author">Le Chat</span> <span class="annote">choucroute</span> <span class="title">Le chat aime la choucroute</span> <span class="year">2001</span> <span class="note">note</span> </li>
</ol>'.
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testMultipleAddOfSameElement [
	| document script |
	script := CZScript new.
	document := 
		CZDocument new 
			addElement: script;
			addElement: script.
		
	self assert: document elements size = 1
	

]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testOrderedList [
	| generation |
	generation := 
		CZDocument new 
			addElement: (CZScript new query: (CZBibKeyQuery checks: [ :key | key = 'key1' ]));
			bibsetInput: bibset;
			withoutHeaderAndFooter;
			exportAsHtml;
			generate.
		
	self assert: generation =  
'<ul>
<li> <span class="author">Adrien Barreau</span> <span class="annote">a</span> <span class="title">article / key 1</span> <span class="year">2000</span> </li>
</ul>'
]

{ #category : #'as yet unclassified' }
CZDocumentTest >> testQuickGeneration [
	| generation |
	generation := 
		CZDocument new 
			bibsetInput: bibset;
			exportAsText;
			generate.
		
	self assert: generation =  
'- Adrien Barreau a article / key 1 2000 

- Adrien Barreau b article / key 2 2002 

- Adrien Barreau and Robert Marcel c misc / key 3 2001 

- Adrien Barreau and Robert Marcel d article 2001 

- Le Chat choucroute Le chat aime la choucroute 2001 note'
]
