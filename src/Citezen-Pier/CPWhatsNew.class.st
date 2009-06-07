"
I list the new papers in the archive since the last timestamp.

Results are posted to the blog.

TO DO:
- run periodically as a sort of cron job

"
Class {
	#name : #CPWhatsNew,
	#superclass : #PRStructure,
	#instVars : [
		'timestamp',
		'modificationTime',
		'archive',
		'author',
		'bibFile',
		'blog'
	],
	#classVars : [
		'WhatsNewTimeStamp'
	],
	#category : #'Citezen-Pier'
}

{ #category : #constants }
CPWhatsNew class >> defaultArchiveDir [
	^ MAReferenceFileModel
		fromRio: (Rio new: '/home/scg/scg.unibe.ch/web/archive')
]

{ #category : #'accessing-description' }
CPWhatsNew class >> descriptionArchive [
	<ignoreForCoverage>
	self flag: 'is it a file or a directory?'.
	^ MAFileDescription new
		componentClass: MAServerFileChooserComponent;
		priority: 30;
		kind: MAReferenceFileModel;
		selectorAccessor: #archive;
		label: 'Archive directory to search';
		default: self defaultArchiveDir;
		beEditable;
		beRequired;
		yourself
]

{ #category : #'accessing-description' }
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

{ #category : #'accessing-description' }
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

{ #category : #'accessing-description' }
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

{ #category : #'accessing-description' }
CPWhatsNew class >> descriptionTimeStamp [
	<ignoreForCoverage>
	self flag: 'what should the kind be?'.
	^ MATimeStampDescription new
		componentClass: MATimeStampInputComponent;
		priority: 30;
		"kind: MAReferenceFileModel;" "what should this be?"
		selectorAccessor: #timestamp;
		label: 'Initial timestamp';
		default: TimeStamp now;
		beEditable;
		beRequired;
		yourself
]

{ #category : #testing }
CPWhatsNew class >> isAbstract [
	^ false
]

{ #category : #accessing }
CPWhatsNew >> archive [
	^ archive
]

{ #category : #accessing }
CPWhatsNew >> archive: dir [
	archive := dir
]

{ #category : #accessing }
CPWhatsNew >> author [
	^ author
]

{ #category : #accessing }
CPWhatsNew >> author: aString [
	author := aString
]

{ #category : #accessing }
CPWhatsNew >> bibFile [
	^ bibFile
]

{ #category : #accessing }
CPWhatsNew >> bibFile: aBibFile [
	bibFile := aBibFile
]

{ #category : #accessing }
CPWhatsNew >> blog [
	^ blog
]

{ #category : #accessing }
CPWhatsNew >> blog: aBlog [
	blog := aBlog
]

{ #category : #news }
CPWhatsNew >> generateNews [
	^ self generateNewsFor: self newItems
]

{ #category : #news }
CPWhatsNew >> generateNewsFor: queryResult [
	| post |
	queryResult bibList entries do:
		[ :entry | 
		post := PBPost named: (TimeStamp now asSortableString) , entry key asString.
		post
			title: (entry plainField: #title);
			contents: (entry pierContentsFor: queryResult);
			publication: TimeStamp now;
			author: self author.
		self blog addChild: post ].
	^ queryResult
	

]

{ #category : #testing }
CPWhatsNew >> invariant [
	^ self bibFile notNil
		and: [self timestamp notNil]
		and: [self archive notNil]
		and: [self blog notNil]
		and: [self author notEmpty]
]

{ #category : #news }
CPWhatsNew >> newItems [
	| lastTimestamp pdfs newFilenames entries |
	lastTimestamp := self timestamp.
	self updateTimestamp.
	pdfs := (Rio new: self archive filePath) beRecursive select: 
		[ :pdf |  pdf isFile 
			and: [ pdf fileName endsWith: '.pdf' ]
			and: [ (pdf parent asString endsWith: 'drafts') not ]
			and: [ pdf modificationTime > lastTimestamp ] ].
	newFilenames := pdfs collect: [ :pdf | pdf fileName ].
	entries := self bibFile bibList entries select: 
		[ :entry | 
		newFilenames anySatisfy: [ :fileName | entry containsKeyword: fileName ] ].
	^ CPQueryResult new
		querySpec: (CPQuerySpec default bibFile: self bibFile);
		bibList: (CPBibList entries: entries)
]

{ #category : #accessing }
CPWhatsNew >> timestamp [
	^ timestamp
]

{ #category : #accessing }
CPWhatsNew >> timestamp: aTimeStamp [
	timestamp := aTimeStamp

]

{ #category : #news }
CPWhatsNew >> updateTimestamp [
	timestamp := TimeStamp now.
]

{ #category : #accessing }
CPWhatsNew >> viewComponentClass [
	<ignoreForCoverage>
	^ CPWhatsNewView
]
