Class {
	#name : #NicolasThemesDocBuilder,
	#superclass : #NicolasPublicationsDocBuilder,
	#category : #'Citezen-Nicolas'
}

{ #category : #adding }
NicolasThemesDocBuilder >> addArchitectureSection [
	self
		addBibSection: NicolasHTMLSection
		withTitle: '<a name="archi"></a>Software Architecture'
		withHeader: self architectureHeader
		forEntries:(self themeQuery: 'architecture') 
]

{ #category : #adding }
NicolasThemesDocBuilder >> addBibSection: aSection withTitle: aString withHeader: sectHead forEntries: aQuery [
	"adding a section just add a section and a list of entries following it."
	| entries |
	entries := (workingBibSet select: aQuery).
	(noEmptySection & entries size isZero)
		ifTrue: [^ self].
	entries sortByDateReverse.	
	self addSection: (aSection new title: aString; yourself).
	
	self document add: (CZHeader new text: sectHead ; yourself).
	
	self document add:  (CZSet new addAll: entries ; yourself)

]

{ #category : #adding }
NicolasThemesDocBuilder >> addKnowledgeSection [
	self
		addBibSection: NicolasHTMLSection
		withTitle: '<a name="knwldge"></a>Knowledge management'
		withHeader: self knowledgeHeader
		forEntries:(self themeQuery: 'knowledge')
]

{ #category : #adding }
NicolasThemesDocBuilder >> addMetricSection [
	self
		addBibSection: NicolasHTMLSection
		withTitle: '<a name="quality"></a>Software Quality / Metrics'
		withHeader: self metricsHeader
		forEntries:(self themeQuery: 'metric') 

]

{ #category : #adding }
NicolasThemesDocBuilder >> addOtherSection [
	self
		addBibSection: NicolasHTMLSection
		withTitle: '<a name="other"></a>Other'
		withHeader: self otherHeader
		forEntries:(self themeQuery: 'other') 
]

{ #category : #sections }
NicolasThemesDocBuilder >> architectureHeader [
	   ^ '<p>Systems are initially conceived with a given goal and scope in mind. As they
evolve and new functionalities are added, this goal and scope will typically drift
in unforeseen directions. After some time, it becomes necessary to straighten
things by redefining a new architecture, taking into account the new scope of
the system. I worked on methods to help in this task.</p>'
]

{ #category : #building }
NicolasThemesDocBuilder >> buildBody [

	self document add: (CZHeader new text: '
<p>You will find here my publications organized by topic.
In my <a href="publications.html">publications page</a>, they are presented by type and in chronological order.</p>

<p>My work covers various topics of software maintenance:
<ul>
<li><a href="#archi">software architecture</a> and re-structuring, or how to help re-organizing a legacy software into coherent modules;</li>
<li><a href="#quality">software quality</a>, to measure the maintenance activity and legacy software;</li>
<li><a href="#knwldge">knowledge management</a>, to recover all the knowledge that is embedded in legacy software ; and,</li>
<li><a href="#other">other aspects</a> of software maintenance management (software quality, risk management, ...)</li>
</ul>
</p>' ; yourself).
	
	self
		addArchitectureSection ; 
		addMetricSection ;
		addKnowledgeSection ;
		addOtherSection .
]

{ #category : #sections }
NicolasThemesDocBuilder >> knowledgeHeader [
	   ^ '<p>One of the conclusions of my research was that some tasks,
like evaluating the quality of an architectural design, depend also on information
of a different nature. For example, one may want to decompose a
system according to the various market segments it targets (<i>e.g.</i>,
hotels, hospitals, or schools), or according to internal divisions in the organization
using it (<i>e.g.</i>, sales department, logistics department, etc.).
This led me to work with more abstract concepts or consider the knowledge
required from software maintainers to do their work.</p>'
]

{ #category : #sections }
NicolasThemesDocBuilder >> metricsHeader [
	   ^ '<p>In software
maintenance, the quality of the system (<i>e.g.</i>, its source code, its architecture)
can greatly impact the time it takes to understand it, or to introduce a new
feature.
In this sense, a good part of my research has been dedicated to software
quality metrics and models.</p>'
]

{ #category : #sections }
NicolasThemesDocBuilder >> otherHeader [
	   ^ '<p>Beyond the main topics I studied (software rearchitecturing,
software quality, knowledge involved in software maintenance) I also
considered other aspects of the software maintenance ecosystem. For example,
the organization within which the people work or the working processes
this organization enforces.</p>'
]

{ #category : #queries }
NicolasThemesDocBuilder >> themeQuery: aString [

	^ (CZFieldQuery 
			named: #tagnicolasa
			checks: [ :value | '*' , aString , '*' match: value ])
]

{ #category : #building }
NicolasThemesDocBuilder >> xhtmlTitle [
	^  'Research Themes'
]
