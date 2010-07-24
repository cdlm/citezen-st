"
A CZBibSetGatherer is collecting entries that are contained in a document.
It is handy to build for example the bibtex file associated with a given document (page html).
"
Class {
	#name : #CZBibSetGatherer,
	#superclass : #CZDocumentVisitor,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Outputers'
}
