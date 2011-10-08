Class {
	#name : #CZLocalisation,
	#superclass : #Object,
	#instVars : [
		'language'
	],
	#classVars : [
		'Book',
		'BookChapter',
		'English',
		'French',
		'HDR',
		'InternationalConference',
		'InternationalConferences',
		'InternationalReview',
		'InternationalReviewedJournal',
		'InternationalReviewedWorkshop',
		'InvitedPaper',
		'NationalReviewedConference',
		'NationalReviewedConferences',
		'NationalReviewedJournal',
		'PHDAndHdr',
		'PhD',
		'ToolDemo',
		'TopConferences',
		'Vulgarisation'
	],
	#pools : [
		'CZPool'
	],
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #initialize }
CZLocalisation class >> initialize [
	"self initialize"
	
	self initializeTypes.
	self initializeEnglishEntries.
	self initializeFrenchEntries.
]

{ #category : #initialize }
CZLocalisation class >> initializeEnglishEntries [
	"self initialize"
	
	English := Dictionary new.
	English at: InternationalReviewedJournal put: 'Refereed Articles in International Journals'.
	English at: TopConferences put: 'Refereed Articles in Top Conferences'.
	English at: NationalReviewedJournal put:  'Refereed Articles in French Journals'.
	English at: InternationalConference put: 'Refereed Articles in International Conferences'.
	English at: NationalReviewedConference put: 'Refereed Articles in National Conferences'.
 	English at: Book put: 'Books'.
	English at: BookChapter put: 'Book Chapters'.
	English at: InvitedPaper put: 'Invited Articles'.
	English at: Editor put: 'Editor'.
	English at: InternationalReviewedWorkshop put: 'Refereed Articles in International Workshops'.
	English at: PhD put: 'PhD'.
	English at: HDR put: 'Habilitation'.
	English at: PHDAndHdr put: 'PhD and Habilitation'.
	English at: ToolDemo put: 'Tool Demos'.
	English at: Vulgarisation put: 'Vulgarisation Articles'.
	
]

{ #category : #initialize }
CZLocalisation class >> initializeFrenchEntries [
	"self initializeFrenchEntries"
	
	French := Dictionary new.
	French at: InternationalReviewedJournal put: 'Revues internationales avec comit\''e de lecture'.
	French at: TopConferences put: 'Meilleures conf\''erences internationales'.
	French at: NationalReviewedJournal put:  'Revues nationales avec comit\''e de lecture'.
	French at: InternationalConference put: 'Conf\''erences internationales avec comit\''e de lecture'.
	French at: NationalReviewedConference put: 'Conf\''erences nationales avec comit\''e de lecture'.
 	French at: Book put: 'Livres'.
	French at: BookChapter put: 'Articles dans un ouvrage collectif'.
	French at: InvitedPaper put: 'Articles invit\''es'.
	French at: Editor put: 'Editeur'.
	French at: InternationalReviewedWorkshop put: 'Articles de workshop internationaux avec comit\''e de lecture'.
	French at: PhD put: 'Th\`ese'.
	French at: HDR put: 'Habilitation \''a diriger des recherches'.
	French at: PHDAndHdr put: 'Th\`ese et Habilitation \''a diriger des recherches'.
	French at: ToolDemo put: 'Demonstrations d''outils'.
	French at: Vulgarisation put: 'Articles de vulgarisation'.
	

]

{ #category : #initialize }
CZLocalisation class >> initializeTypes [
	"self initializeTypes"
	
	InternationalReviewedJournal := #internationReviewedJournal.
	NationalReviewedJournal := #nationalReviewedJournal.
	TopConferences := #topConferences.
	InternationalConference := #internationalConferences.
	NationalReviewedConference := #nationalConference.
	Book := #book.
	BookChapter := #bookChapter.
	InvitedPaper := #invitedPapers.
	Editor := #editor.
	InternationalReviewedWorkshop := #internationalWorkshop.
	PhD := #phd.
	HDR := #hdr.
	PHDAndHdr := #phdAndHdr.
	ToolDemo := #tooldemo.
	Vulgarisation := #vulgarisation.
]

{ #category : #accessing }
CZLocalisation >> book [

	^ language at: Book
]

{ #category : #accessing }
CZLocalisation >> bookChapter [

	^ language at: BookChapter
]

{ #category : #accessing }
CZLocalisation >> editor [

	^ language at: Editor
]

{ #category : #setting }
CZLocalisation >> english [

	language := English
]

{ #category : #setting }
CZLocalisation >> french [ 

	language := French
]

{ #category : #accessing }
CZLocalisation >> hdr [

	^ language at: HDR
]

{ #category : #initialize }
CZLocalisation >> initialize [

	super initialize.
	self english
]

{ #category : #accessing }
CZLocalisation >> internationalConference [

	^ language at: InternationalConference
]

{ #category : #accessing }
CZLocalisation >> internationalReviewedJournal [

	^ language at: InternationalReviewedJournal
]

{ #category : #accessing }
CZLocalisation >> invitedPapers [

	^ language at: InvitedPaper
]

{ #category : #accessing }
CZLocalisation >> nationalReviewedConference [

	^ language at: NationalReviewedConference
]

{ #category : #accessing }
CZLocalisation >> nationalReviewedJournal [

	^ language at: NationalReviewedJournal
]

{ #category : #accessing }
CZLocalisation >> phd [

	^ language at: PhD
]

{ #category : #accessing }
CZLocalisation >> phdAndHdr [

	^ language at: PHDAndHdr
]

{ #category : #accessing }
CZLocalisation >> toolDemo [

	^ language at: ToolDemo
]

{ #category : #accessing }
CZLocalisation >> topConferences [

	^ language at: TopConferences
]

{ #category : #accessing }
CZLocalisation >> vulgarisation [

	^ language at: Vulgarisation
]
