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

.bibliography .entry {
	margin-bottom: 1ex;
}

.bibliography .entry > a {
	margin-left: 0.5em;
}

.bibliography .entry a:first-child { margin: 0; }

/* entries */
/* .bibliography .inproceedings {} etc */

/* blocks */

.bibliography .title {
	font-weight: bold;
}

.bibliography .note {
	margin-left: .5em;
	font-style: italic;
}
'
]

{ #category : #accessing }
CZFileLibrary >> selectorsToInclude [
	^ #( bibCss )
]
