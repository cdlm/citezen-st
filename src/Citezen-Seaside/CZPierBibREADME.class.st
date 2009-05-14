"
This is work in progress.
--TO DO--
*** Write some tests!
CZPierBibFile
- add auto-regex recognition
- add view controls
*** Queries
- sets of keywords
- or regex
CZPierBibQueryOptions
- ignoreCase = y/n
- useRegex = n/y [auto-recognize regexes containing: []*^$\ ]
- sortBy = author/year/category
- display = plain/abstract/bibtex
- showControls = y/n
CZPierBibQuery
- stores a fixed query with query options
- cache query result
- timestamp invalidated when source file modified


--ABOUT--
These classes (CZPier*) are intended to replace the scgbib.cgi script with a pure Pier/Seaside solution.
Requirements are here: http://scg.unibe.ch/wiki/scgjoblist/scgpier/pierbib

The key class is CZPierBibFile, which points to a local bib file (e.g., scg.bib). It keeps track of the timestamp and reloads the file whenever it changes. It splits the file into a BibList (for ease of reading, we omit the ""CZPier"" prefix) of BibEntry objects. Each BibEntry holds the text of a bibtext entry, and lazily parses it only if needed (i.e., for rendering). BibFileView generates the interface for ad hoc queries.

BibFile and BibQuery are PRStructures, so they can reside at a fixed URL. BibQuery points to a BibFile and encapsulates a fixed query. It caches its result and updates it only if the BibFile timestamp changes.

BibQuerySpec is used to encapsulate all the parameters to a query and the display options.
"
Class {
	#name : #CZPierBibREADME,
	#superclass : #Object,
	#category : #'Citezen-Seaside'
}
