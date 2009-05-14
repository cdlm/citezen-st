"
I hold all the information relevant to either an ad hoc query or a fixed query.

I can be used to parse query information hiding in a URL, I can generate the query part ofa URL, and I can be used to store the spec of a fixed query.

I am consulted by a [CZPier]BibList or a BibEntry so they know how to render themselves (sort order etc.).

I am basically a data holder with just a few smarts.
"
Class {
	#name : #CZPierBibQuerySpec,
	#superclass : #Object,
	#category : #'Citezen-Seaside'
}
