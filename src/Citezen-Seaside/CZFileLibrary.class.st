Class {
	#name : #CZFileLibrary,
	#superclass : #WAFileLibrary,
	#category : #'Citezen-Seaside'
}

{ #category : #'accessing-styles' }
CZFileLibrary >> bibCss [
	^ '/* Citezen
	
	Copyright (c) 2007 Damien Pollet
*/

#bibliography { }

/* entries */

#bibliography span.inproceedings,
#bibliography span.misc,
#bibliography span.phdthesis {
	display: block;
	margin-bottom: 1em;
}

/* blocks */

#bibliography .author {
	display: inline;
}

#bibliography .title {
	display: inline;
	font-weight: bold;
}

#bibliography .publishing {
	display: inline;
}

#bibliography .note {
	margin-right: 2em;
	margin-left: 2em;
	font-style: italic;
}
'
]

{ #category : #accessing }
CZFileLibrary >> selectorsToInclude [
	^ #( bibCss )
]
