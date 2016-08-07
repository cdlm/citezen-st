"
I'm a special builder that generates tagged-based sections.

I create a section with a title and a list of items each item is 
one of the following items where the items are matched against the third element.


Given a specification following this pattern: 


	^ #(
		
		#('Editor' 'Workshop Proceedings ' 
		'Here are some of the proceedings of workshops and other activities I got over the year.' 
		'*kzEditor*') 
		
		#('Education' 'Teaching and Educative Support' 
		'I''m interested in how to teach computer sciences. I supervized Hilaire Fernandes on how computer sciences can support math teaching.' 
		'*kzTeaching*')
		
		#('Vulgarisation' 'Computer Science Vulgarisation' 
		'I wrote several articles around programming language topics for mass journals.' 
		'*kzVulgarisation*')
		)
		
	
{ ""title"" : 	""Editorial and Others"",
	""items "" : [  
	{ ""fileName"" : ""Vulgarisation"",
	  ""title"" : ""Computer Science Vulgarisation"",
 	  ""description"" : ""I wrote several articles around programming language topics for mass journals."",
	""matcher"" : '*kzVulgarisation*'}
		]
	}




"
Class {
	#name : #CZSmartSectionBuilder,
	#superclass : #CZPillarDocBuilder,
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #'as yet unclassified' }
CZSmartSectionBuilder >> createSubTopic: file title: name text: text bibTag: bibTag [

	|  ndoc |
	ndoc := CZDoc title: name.
	ndoc add: (CZText text: text).
	ndoc add: 
			(CZSection new
				title: name;				
				text: text;
				yourself).
	^ ndoc
]

{ #category : #'as yet unclassified' }
CZSmartSectionBuilder >> defaultSmartSpecification [ 

	^ #(
		
		#('Editor' 'Workshop Proceedings ' 
		'Here are some of the proceedings of workshops and other activities I got over the year.' 
		'*kzEditor*') 
		
		#('Education' 'Teaching and Educative Support' 
		'I''m interested in how to teach computer sciences. I supervized Hilaire Fernandes on how computer sciences can support math teaching.' 
		'*kzTeaching*')
		
		#('Vulgarisation' 'Computer Science Vulgarisation' 
		'I wrote several articles around programming language topics for mass journals.' 
		'*kzVulgarisation*')
		)
]

{ #category : #'as yet unclassified' }
CZSmartSectionBuilder >> filter [

	super filter.
	"here we do not want to remove from the working set so that 
	the articles can have multiple categories"
	workingBibSet := originalBibSet select: self authorQuery
]

{ #category : #'as yet unclassified' }
CZSmartSectionBuilder >> generate [
	"self new generate"
	
	self defaultSmartSpecification 
		do: [ :each | 
			self
				createSubTopic: each first
				title: each second
				text: each third
				bibTag: each fourth.
			 ].
]

{ #category : #'as yet unclassified' }
CZSmartSectionBuilder >> generateFor: aDoc on: aStream [ 

	self generateTopicSectionOn: aStream. 
	self generateTopics.
	
]

{ #category : #'as yet unclassified' }
CZSmartSectionBuilder >> generateTopicSectionOn: aStream [
	
	
	| itemList |
	self flag: #here. 
	doc addSection:  (CZSection new title: 'Bla'; yourself).
	itemList := (CZItemList new).
	doc add: itemList. 
	self defaultSmartSpecification 
		do: [ :each | 
				itemList add: (CZLinkItem link: '....')
				
				
				]
				 
]

{ #category : #'as yet unclassified' }
CZSmartSectionBuilder >> queryForKozenTag: aTag [

	^ CZFieldQuery named: #keywords checks: [ :value | aTag match: value ]
]
