"
to generate something like that..... 


\begin{thebibliography}{100}[\RAbibAAname]
\small

% phdthesis
\bibitem[1]{anquetil:tel-01086785}\RAsc{N.~Anquetil},
\newblock {Supporting Software Evolution in the Organizations},
\newblock Accreditation to supervise research, {universite de Lille-1}, May
  2014,
\newblock \href {http://hal.inria.fr/tel-01086785} {\path{[hal:tel-01086785]
  }}.


| visitor bibset |
bibset := CZBibParser parse: (FileStream readOnlyFileNamed: 'rmod.bib') contents.
bibset scope: CZSet standardDefinitions.
visitor := CZBblGenerator new filename: 'rmod.bbl'.
visitor visit: bibset.

"
Class {
	#name : #CZBblGenerator,
	#superclass : #CZFileFormatGenerator,
	#instVars : [
		'currentNumber',
		'fieldEmbellishingTable'
	],
	#category : #'Citezen-Reborn-FormattingVisitors'
}

{ #category : #initialization }
CZBblGenerator >> defaultFieldOrder [
	"adding hal-id and doi in separate specs"
	^ {Author . Title . Chapter . Journal . BookTitle . Volume . Pages . Publisher . Year . ImpactFactor . Misc} 
			 
]

{ #category : #initialization }
CZBblGenerator >> doiAndHalFields [
	^ { DOI . HALID }
	
]

{ #category : #utils }
CZBblGenerator >> doiHrefForField: aDoiField [
	"Return the \href {http://dx.doi.org/10.1016/j.scico.2014.07.011}
  {\path{[doi:10.1016/j.scico.2014.07.011] }}, "
	^ '\href{http://dx.doi.org/', aDoiField value, '}{\path{[doi:', aDoiField value,']}}'
 
]

{ #category : #'header/footer hooks' }
CZBblGenerator >> emitEntryFooter: anEntry [

	self line ; line.

]

{ #category : #'header/footer hooks' }
CZBblGenerator >> emitEntryHeader: anEntry [
	"Add to the outputStream 
	\bibitem[1]{anquetil:tel-01086785}\RAsc{N.~Anquetil},"
	"the key is computed using hal convention for now."
	currentNumber := currentNumber + 1.
	self outputStream  
		nextPutAll: '\bibitem[', currentNumber printString, ']';
		nextPut: ${;
		nextPutAll: (self halKeyForEntry: anEntry);
		nextPut: $}.
	self outputStream nextPutAll: '\czauthors{', anEntry author rawValueObject shortenedName, '},'.
	self line.
	
]

{ #category : #utils }
CZBblGenerator >> halHrefForEntry: anEntry [
	"Return the http://hal.inria.fr/hal-00957695 in
	\bibitem[11]{abdeen:hal-00957695}\RAsc{H.~Abdeen, S.~Ducasse, D.~Pollet,
  I.~Alloui, J.-R. Falleri},
"
	|halid|
	halid := (anEntry at: HALID) value.
	^ '\href{http://hal.inria.fr/', halid, '}{\path{[hal:',halid,']}]'
 
]

{ #category : #utils }
CZBblGenerator >> halHrefForField: aHalField [
	"Return the http://hal.inria.fr/hal-00957695"
	^ '\href{http://hal.inria.fr/', aHalField value, '}{\path{[hal:', aHalField value,']}}'
 
]

{ #category : #utils }
CZBblGenerator >> halKeyForEntry: anEntry [
	"Return the author:halid
	for example: abdeen:hal-00957695 in
	\bibitem[11]{abdeen:hal-00957695}\RAsc{H.~Abdeen, S.~Ducasse, D.~Pollet,
  I.~Alloui, J.-R. Falleri},
"

	^ (anEntry author rawValueObject people first compactLastName asLowercase, ':', (anEntry at: HALID) value) 
]

{ #category : #utils }
CZBblGenerator >> halUrlForEntry: anEntry [
	"Return the author:halid
	for example: abdeen:hal-00957695 in
	\bibitem[11]{abdeen:hal-00957695}\RAsc{H.~Abdeen, S.~Ducasse, D.~Pollet,
  I.~Alloui, J.-R. Falleri},
"

	^ 'http://hal.inria.fr', (anEntry at: HALID) value
 
]

{ #category : #initialization }
CZBblGenerator >> initialize [

	super initialize.
	currentNumber := 0.
	self initializeFieldEmbellishingTable
	
]

{ #category : #initialization }
CZBblGenerator >> initializeFieldEmbellishingTable [
	"Rather ugly but it works!"
	
	fieldEmbellishingTable := Dictionary new. 
	fieldEmbellishingTable at: Author put: '\czauthors{'.
	fieldEmbellishingTable at: BookTitle put: 'In \czbooktitle{'.
	fieldEmbellishingTable at: Title put: '\cztitle{'.
	fieldEmbellishingTable at: Journal put: 'In \czjournal{'.

	
]

{ #category : #visiting }
CZBblGenerator >> newblock [
	self outputStream nextPutAll: '\newblock '. 
]

{ #category : #visiting }
CZBblGenerator >> visitEntry: anEntry [
	| fields |
	(anEntry hasFieldWithKey: Author)
		ifFalse: [ ^ self ].
	"we do not support non authored entry since the bibitem key is based on author."		
	fields := anEntry fieldSortedFollowingKeys: fieldOrder allButFirst.
	"remove authors because it is for the \bibitem and treated in EntryHeader"
	"default fields do not include "
	self emitEntryHeader: anEntry.
	self newblock.
	fields 
		do: [ :each | each acceptVisitor: self ] 
		separatedBy: [ self emitFieldSeparation ].
	self line.
	((anEntry hasFieldWithKey: DOI) or: [(anEntry hasFieldWithKey: HALID)])
		ifTrue: [  
			self newblock.
			(anEntry fieldSortedFollowingKeys: self doiAndHalFields)
					do: [ :each | each acceptVisitor: self ] 
					separatedBy: [ self emitFieldSeparation ] ].
	self emitEntryFooter: anEntry
]

{ #category : #visiting }
CZBblGenerator >> visitField: aField [
	"We should probably use phrases instead of doing everything ourselves."

	aField key = CZPool HALID ifTrue: [ ^ self outputStream nextPutAll: (self halHrefForField: aField) ].
	aField key = CZPool DOI ifTrue: [ ^ self outputStream nextPutAll: (self doiHrefForField: aField)].
	"we should not proceed again these values since they are fully transformed."
	
	"for the rest this is just adding nicer information so no return"
	aField key = CZPool volume ifTrue: [self outputStream nextPutAll: 'Volume '].
	aField key = CZPool pages ifTrue: [self outputStream nextPutAll: 'pp. '].
	fieldEmbellishingTable at: aField key ifPresent: [:t | self outputStream nextPutAll: ' ', t].
	aField dispatchVisitor: self.
	"One day I have to think about this dispatch ugly point"
	fieldEmbellishingTable at: aField key ifPresent: [:t | self outputStream nextPutAll: '}'].
	aField key = CZPool editor
		ifTrue: [ self outputStream nextPutAll: ' ed.'].
]

{ #category : #visiting }
CZBblGenerator >> visitPeople: aCZPeople [

	self outputStream nextPutAll: '\czauthors{'.
	aCZPeople perform: expandOption.
	outputStream nextPutAll: aCZPeople expanded.
	self outputStream nextPut: $}.
]
