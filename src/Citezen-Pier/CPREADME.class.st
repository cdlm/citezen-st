"
These classes (all starting with CP -- we elide the prefix here for readability) are intended to replace the scgbib.cgi script with a pure Pier/Seaside solution.

Requirements are here: http://scg.unibe.ch/wiki/scgjoblist/scgpier/pierbib

The key class is BibFile, which points to a local bib file (e.g., scg.bib). It keeps track of the timestamp and reloads the file whenever it changes. It splits the file into a BibList of BibEntry objects. Each BibEntry holds the text of a bibtext entry, and lazily parses it only if needed (i.e., for rendering). BibFileView generates the interface for ad hoc queries.

BibFileView, FixedQuery and QueryBox are the three interfaces available. The first is a View on the BibFile, so it cannot be embedded. The other two are Widgets, so thay can. FixedQuery points to a BibFile and encapsulates a fixed query. It caches its result and updates it only if the BibFile timestamp changes.

QuerySpec is used to encapsulate all the parameters to a query and the display options.
"
Class {
	#name : #CPREADME,
	#superclass : #Object,
	#category : #'Citezen-Pier'
}
