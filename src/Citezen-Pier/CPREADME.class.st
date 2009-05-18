"
This is work in progress. Initial description follows. To be updated ...

--ABOUT--
These classes (all starting with CP -- we elide the prefix here for readability) are intended to replace the scgbib.cgi script with a pure Pier/Seaside solution.

Requirements are here: http://scg.unibe.ch/wiki/scgjoblist/scgpier/pierbib

The key class is BibFilePage, which points to a local bib file (e.g., scg.bib). It keeps track of the timestamp and reloads the file whenever it changes. It splits the file into a BibList of BibEntry objects. Each BibEntry holds the text of a bibtext entry, and lazily parses it only if needed (i.e., for rendering). BibFileView generates the interface for ad hoc queries.

BibFilePage and BibQueryPage are PRStructures, so they can reside at a fixed URL. BibQueryPage points to a BibFilePage and encapsulates a fixed query. It caches its result and updates it only if the BibFile timestamp changes.

BibQuerySpec is used to encapsulate all the parameters to a query and the display options.
"
Class {
	#name : #CPREADME,
	#superclass : #Object,
	#category : #'Citezen-Pier'
}
