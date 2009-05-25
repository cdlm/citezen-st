"
I list the new papers in the archive since the last timestamp.

Results are posted to the blog.

TO DO:
- run periodically as a sort of cron job

"
Class {
	#name : #CPWhatsNew,
	#superclass : #PRWidget,
	#instVars : [
		'timestamp',
		'modificationTime',
		'queryResult'
	],
	#classVars : [
		'WhatsNewTimeStamp'
	],
	#category : #'Citezen-Pier'
}

{ #category : #constants }
CPWhatsNew class >> archiveDir [
	^ '/home/scg/scg.unibe.ch/web/archive'
]

{ #category : #nil }
CPWhatsNew class >> defaultTimeStampFile [
	^ WhatsNewTimeStamp
		ifNil:
			[WhatsNewTimeStamp := MAReferenceFileModel
				fromRio: (Rio new: '/home/scg/scg.unibe.ch/web/archive/papers/Deza08bEvolvingObjects.pdf')]
]

{ #category : #accessing }
CPWhatsNew class >> descriptionAuthor [
	<ignoreForCoverage>
	^ MAStringDescription new
		comment: 'The news author';
		parameterName: 'author';
		accessor: #author;
		label: 'Author';
		priority: 40;
		default: '';
		beEditable;
		beRequired;
		yourself
]

{ #category : #accessing }
CPWhatsNew class >> descriptionBibFile [
	^ PRStructureDescription new
		addCondition: (MACondition selector: #isKindOf: argument: CPBibFile)
			labelled: 'Select an existing Bib File';
		accessor: #bibFile;
		label: 'Bib File';
		priority: 10;
		default: CPBibFile singleInstanceOrNil;
		beEditable;
		beRequired;
		yourself
]

{ #category : #accessing }
CPWhatsNew class >> descriptionBlog [
	^ PRStructureDescription new
		addCondition: (MACondition selector: #isKindOf: argument: PBBlog)
			labelled: 'Select a Blog';
		accessor: #blog;
		label: 'Blog';
		priority: 20;
		default: (PBBlog allInstances ifNotEmptyDo: [: all | all size = 1 ifTrue: [all first]]);
		beEditable;
		beRequired;
		yourself
]

{ #category : #accessing }
CPWhatsNew class >> descriptionTimeStampFile [
	<ignoreForCoverage>
	^ MAFileDescription new
		componentClass: MAServerFileChooserComponent;
		priority: 30;
		kind: MAReferenceFileModel;
		selectorAccessor: #file;
		label: 'Initial timestamp File';
		default: self defaultTimeStampFile;
		beEditable;
		beRequired;
		yourself
]

{ #category : #accessing }
CPWhatsNew class >> groupLabel [
	^ 'Pier Bibliography'
]

{ #category : #accessing }
CPWhatsNew class >> isAbstract [
	^ false
]

{ #category : #accessing }
CPWhatsNew class >> label [
	^ 'What''s new blog'
]

{ #category : #accessing }
CPWhatsNew >> author [
	^ self read: #descriptionAuthor
]

{ #category : #accessing }
CPWhatsNew >> bibFile [
	^ self read: #descriptionBibFile
]

{ #category : #accessing }
CPWhatsNew >> blog [
	^ self read: #descriptionBlog
]

{ #category : #seaside }
CPWhatsNew >> children [
	^ Array with: queryResult
]

{ #category : #news }
CPWhatsNew >> generateNewsItems [
	| post |
	
	self flag: 'This should be run periodically as a sort of cron job.'.
	
	queryResult := self whatsNew.
	queryResult bibList entries do: 
		[ :entry | 
		post := PBPost named: (TimeStamp now asSortableString) , entry key asString.
		post
			title: (entry plainField: #title);
			contents: entry pierContents;
			publication: TimeStamp now;
			author: self author.
		self blog addChild: post ].
	

]

{ #category : #initialization }
CPWhatsNew >> initialize [
	super initialize.
]

{ #category : #initialization }
CPWhatsNew >> initializeTimestamp [
	timestamp ifNil: [timestamp := self timestampFile modificationTime]
]

{ #category : #testing }
CPWhatsNew >> invariant [
	^ self bibFile notNil
		and: [self timestampFile notNil]
		and: [self timestampFile exists]
		and: [self blog notNil]
		and: [self author notEmpty]
]

{ #category : #seaside }
CPWhatsNew >> renderContentOn: html [
	self invariant
		ifTrue: [
			self initializeTimestamp.
			html paragraph: [ html text: 'Last timestamp: ', timestamp printString ].
			self renderFormOn: html.
			queryResult ifNotNil: [ html render: queryResult ]]
		ifFalse: [
			html paragraph: [html strong: 'Required fields undefined. Please edit and and save.']]
	
]

{ #category : #seaside }
CPWhatsNew >> renderFormOn: html [
	html form: 
		[
		"html submitButton
			text: 'update';
			callback: [ queryResult := self whatsNew ]."
		html submitButton
			text: 'generate news';
			callback: [ self generateNewsItems ].
		"html submitButton
			text: 'back to March 2009';
			callback: [ self initializeBackToMarch2005. queryResult := nil ]."
		"html submitButton
			text: 'back to 2005';
			callback: [ self initializeBackTo2005. queryResult := nil ]"
			].
]

{ #category : #accessing }
CPWhatsNew >> timestampFile [
	^ Rio new: (self read: #descriptionTimeStampFile) filePath
]

{ #category : #initialization }
CPWhatsNew >> updateTimestamp [
	timestamp := TimeStamp now.
]

{ #category : #evaluation }
CPWhatsNew >> whatsNew [
	| lastTimestamp pdfs newFilenames entries |
	lastTimestamp := timestamp.
	self updateTimestamp.
	pdfs := (Rio new: self class archiveDir) beRecursive select: 
		[ :pdf |  pdf isFile 
			and: [ pdf fileName endsWith: '.pdf' ]
			and: [ pdf modificationTime > lastTimestamp ] ].
	newFilenames := pdfs collect: [ :pdf | pdf fileName ].
	entries := self bibFile bibList entries select: 
		[ :entry | 
		newFilenames anySatisfy: [ :fileName | entry containsKeyword: fileName ] ].
	^ CPQueryResult new
		querySpec: (CPQuerySpec default bibFile: self bibFile);
		bibList: (CPBibList entries: entries)
]
