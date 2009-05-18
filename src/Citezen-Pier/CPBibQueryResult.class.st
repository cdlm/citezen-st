"
I am a BibList that results from evaluating a query. I know my QuerySpec, so I can render myself accordingly.

I also know the BibFile that I come from so I know when I need to be refreshed.

"
Class {
	#name : #CPBibQueryResult,
	#superclass : #CPBibList,
	#instVars : [
		'querySpec'
	],
	#category : #'Citezen-Pier'
}
