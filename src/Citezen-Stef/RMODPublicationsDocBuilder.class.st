"
Silly for now to subclass from singleAuthorDocBuilder (but probably SingleAuthorDocBuilder should be renamed since it has all the entries to build team report)

	self generateLatexForEval2008to2012

How to use me for evaluation report helping. 

	self  query20112016
		generateBibTeX;
		statistics

	we should get three left: unpublished, and two tooldemos. 
	
	
		
"
Class {
	#name : #RMODPublicationsDocBuilder,
	#superclass : #CZSingleAuthorDocBuilder,
	#instVars : [
		'startingYear',
		'endingYear',
		'teamMembers'
	],
	#category : #'Citezen-Stef'
}

{ #category : #generation }
RMODPublicationsDocBuilder class >> generateLatexForEval2008to2012 [
	"normally this is four years so we should stop in 2011 but there are fuzy so let us go until 2012"

	"self generateLatexForEval2008to2012"

	| builder |
	builder := self new
		toLatex;
		english;
		fileNamed: 'rmod.bib';
		fieldOrder:
			#(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #impactfactor #misc #url #doi);
		startingYear: 2008;
		setFilteringOn;
		yourself.
	builder generateLatexFile
]

{ #category : #generation }
RMODPublicationsDocBuilder class >> query20112016 [
	"normally this is four years so we should stop in 2011 but there are fuzy so let us go until 2012"

	"self query20112016"

	| builder |
	builder := self new
		fileNamed: 'rmod.bib';
		startingYear: 2012;
		endingYear: 2016;
		teamMembers: self teamFor20112016;
		keysOfBlackListedEntries: #(Stein12a Stein12b);
		setFilteringOn;
		yourself.
	builder filter.
	^ builder
]

{ #category : #generation }
RMODPublicationsDocBuilder class >> teamFor20112016 [
	^ #('*Ducasse*S*' '*Denker*M*' '*Auverlot*' '*Larcheveque*' '*Anquetil*' '*Govin*' '*Pollet*' '*Abdeen*' '*Laval*' '*Peirs*' '*Falleri*' '*Denier*' '*Marr*' '*Hora*' '*Etien*' '*Blondeau*' '*Casaccio*' '*Bruni*' '*Tesone*' '*Teruel*' '*Polito*' '*Martinez*Peck*' '*Uquillas*' '*Arnaud*' '*Bhatti*U*' '*Fernandes*' '*Razavizadeh*' '*Uquilla*' '*Dias*' '*Cassou*' '*Ryseghem*' '*Papoulias*' '*Demarey*' '*Bera*' '*Santos*')
]

{ #category : #utils }
RMODPublicationsDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #accessing }
RMODPublicationsDocBuilder >> endingYear: anInteger [
	
	endingYear := anInteger
]

{ #category : #building }
RMODPublicationsDocBuilder >> filter [

	super filter.
	workingBibSet := workingBibSet select: self validTeamQuery  "could be also teamEntry"
]

{ #category : #building }
RMODPublicationsDocBuilder >> generateBibTeX [
	"with this we will be able to do a nocite{*} and get all the references in our lovely report"
	| visitor |
	visitor := CZBibTexGenerator new.
	visitor
		fieldOrder:
			#(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #impactfactor #misc #url #doi).
	visitor outputStream: (FileStream newFileNamed: self bibtexFileName).
	visitor visit: workingBibSet
]

{ #category : #initialize }
RMODPublicationsDocBuilder >> initialize [
	super initialize.
	startingYear := 2011.
	endingYear := 2016.	"normally inria report are for 4 years period"
	self teamMembers: #('*Ducasse*S*' '*Denker*M*' '*Auverlot*' '*Larcheveque*' '*Anquetil*' '*Govin*' '*Pollet*' '*Abdeen*' '*Laval*' '*Peirs*' '*Falleri*' '*Denier*' '*Marr*' '*Hora*' '*Etien*' '*Blondeau*' '*Casaccio*' '*Bruni*' '*Tesone*' '*Teruel*' '*Polito*' '*Martinez*Peck*' '*Uquillas*' '*Arnaud*' '*Bhatti*U*' '*Fernandes*' '*Razavizadeh*' '*Uquilla*' '*Dias*' '*Cassou*' '*Ryseghem*' '*Papoulias*' '*Demarey*' '*Bera*' '*Santos*')
]

{ #category : #testing }
RMODPublicationsDocBuilder >> isFromWithinReportingPeriod: anIntegerRepresentingAYear [
	"we could check also and remove too recent paper - but inria is fuzzy about that"
	^  anIntegerRepresentingAYear between: startingYear and: endingYear  
]

{ #category : #utils }
RMODPublicationsDocBuilder >> latexName [

	^ 'RMOD Publications'
]

{ #category : #building }
RMODPublicationsDocBuilder >> lineFor: selector into: aStream [
	| dict |
	dict := (workingBibSet select: (CZQuery perform: selector)) groupedBy: CZQuery year.
	workingBibSet := workingBibSet reject: (CZQuery perform: selector).
	"so that we do not count twice the top conferences that are tagged internationalconference"
	aStream
		nextPutAll: selector asString;
		space.
	2012 to: 2016 do: [ :each | 
		aStream nextPutAll: '& '.
		aStream nextPutAll: (dict at: each ifAbsent: [ Set new ]) size printString ]
]

{ #category : #accessing }
RMODPublicationsDocBuilder >> startingYear: anInteger [
	
	startingYear := anInteger
]

{ #category : #building }
RMODPublicationsDocBuilder >> statistics [
	| stream |
	stream := FileStream forceNewFileNamed: 'tableForEvaluationReport.tex'.
	stream
		nextPutAll:
			'\begin{center}
\begin{tabular}{l|r|r|r|r|r} \hline
&2012&2013&2014&2015&2016\\ \hline \hline';
		lf.
	#(#phdthesis #internationalJournal #nationalJournal #topConference #internationalConference #nationalConference #book #bookChapter #internationalWorkshop #vulgarisation #techReport)
		do: [ :each | 
			self lineFor: each into: stream.
			stream
				nextPutAll: '\\ \hline';
				lf ].
	stream nextPutAll: '\end{tabular}\end{center}'

	"\begin{center}
\begin{tabular}{l|r|r|r|r} \hline
                                &2012-2013&2013-2014&2014-2015&2015-2016\\ \hline \hline
PhD Theses                      &  3     &   1    &   2    &   2 \\ \hline
H.D.R.~(*)                      &       &   1    &       &  1  \\ \hline
Journals                        &       &       &       &     	\\ \hline
Top Conferences	     &       &       &       &     	\\ \hline
Other Conferences	     &       &       &       &     	\\ \hline
Books (written)                 &       &   1    &       &  1  	\\ \hline
Books (edited)                  &       &       &       &     	\\ \hline
Patents (we are against)	&	&	&	&     	\\ \hline
Vulgarisation papers         & 1 &	&2    &    1\\ \hline
Technical reports               &       &       &       &     	\\ \hline
\end{tabular}
"
]

{ #category : #accessing }
RMODPublicationsDocBuilder >> teamMembers: anArray [
	"anArray should be #('*Ducasse*S*' '*Denker*M*' '*Auverlot*' '*Larcheveque*' '*Anquetil*' '*Govin*' '*Pollet*' '*Abdeen*' '*Laval*' '*Peirs*' '*Falleri*' '*Denier*' '*Marr*' '*Hora*' '*Etien*' '*Blondeau*' '*Casaccio*' '*Bruni*') "
	CZEntry teamMemberPatterns: anArray
]

{ #category : #testing }
RMODPublicationsDocBuilder >> validTeamQuery [

	^ self teamEntryQuery
		AND:
			(CZFieldQuery
				named: #year
				checks: [ :value | self isFromWithinReportingPeriod: value asNumber ])
]

{ #category : #building }
RMODPublicationsDocBuilder >> verifyStatisticsGeneration [
	| phds journals topconferences internationalconferences conferences vulgarisation books tr |
	phds := workingBibSet select: CZQuery phdthesis.
	journals := workingBibSet select: CZQuery article.
	"topconferences := workingBibSet select: CZQuery topconference.
	internationalconferences := workingBibSet
		select: CZQuery internationalconference.
	'bug here since we count two times the same'."
	conferences := workingBibSet select: CZQuery conference.
	vulgarisation := workingBibSet select: CZQuery vulgarisation.
	books := workingBibSet select: CZQuery book.
	tr := workingBibSet select: CZQuery techReport.
	self halt.
	workingBibSet entries size = (tr size + books size
		+ vulgarisation size + conferences size + journals size
		+ phds size)
]
