"
A CZSection is a document section  with a title, items and text.
This way we can manage

\begin{thebibliography}{100}[PhDs ]
\small

\bibitem[1]{anquetil:tel-01086785}\RAsc{N.~Anquetil},
\newblock {Supporting Software Evolution in the Organizations},
\newblock Accreditation to supervise research, {universite de Lille-1}, May
  2014,
\newblock \href {http://hal.inria.fr/tel-01086785} {\path{[hal:tel-01086785]
  }}.
...

\end{thebibliography}

The closing is forcing to get items attached to the section. 

"
Class {
	#name : #CZSection,
	#superclass : #CZDocElement,
	#instVars : [
		'text',
		'items',
		'title'
	],
	#category : 'Citezen-Reborn-DocModel'
}

{ #category : #visiting }
CZSection >> acceptVisitor: aVisitor [

	aVisitor visitSection: self
]

{ #category : #initialization }
CZSection >> initialize [
	super initialize.
	title := CZString new setValue: ''.
	text := CZText new text: ''.
	items := CZSet new
]

{ #category : #accessing }
CZSection >> items [
	^ items
]

{ #category : #accessing }
CZSection >> items: aBibset [
	items := aBibset
]

{ #category : #printing }
CZSection >> printOn: aStream [

	super printOn: aStream.
	title ifNotNil: [aStream nextPutAll: '('; nextPutAll: title expanded; nextPutAll: ')']
]

{ #category : #accessing }
CZSection >> text [
	^ text 
]

{ #category : #accessing }
CZSection >> text: aText [
	text := aText
]

{ #category : #accessing }
CZSection >> title [
	
	^ title
]

{ #category : #accessing }
CZSection >> title: aString [
	
	title := aString
]
