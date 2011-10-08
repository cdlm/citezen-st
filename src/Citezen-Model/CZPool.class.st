"
Defines all the constants for fields and types of entries.
"
Class {
	#name : #CZPool,
	#superclass : #SharedPool,
	#classVars : [
		'Author',
		'BookTitle',
		'Chapter',
		'Editor',
		'Institution',
		'Journal',
		'Note',
		'Number',
		'Pages',
		'Publisher',
		'RequiredFields',
		'School',
		'Series',
		'Title',
		'Volume',
		'Year'
	],
	#category : #'Citezen-Model'
}

{ #category : #initialize }
CZPool class >> initialize [
	"self initialize"
	
	Author := #author.
	BookTitle := #booktitle.
	Chapter :=  #chapter.
	Editor := #editor.
	Institution :=  #institution.
	Journal := #journal.
	Note := #note.
	Pages :=  #pages.
	Publisher :=  #publisher.
	School :=  #school.
	Title := #title.
	Volume := #volume.
	Series := #series.
	Number := #number.
	Year :=  #year.
	RequiredFields := {Author . BookTitle . Chapter . Editor . Institution . Journal . Note . Number . Pages . Publisher .  School . Series. Volume . Title}
	
]
