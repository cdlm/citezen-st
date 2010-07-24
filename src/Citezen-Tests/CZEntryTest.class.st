Class {
	#name : #CZEntryTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'duplicateEntry',
		'articleEntry',
		'inproceedingsEntry',
		'masterEntry'
	],
	#category : #'Citezen-Tests'
}

{ #category : #running }
CZEntryTest >> setUp [

	entry := (CZBibParser parse: CZTestResource bibTest) entries at: 1.
	duplicateEntry := (CZBibParser parse: CZTestResource bibTest) entries at: 1.
	articleEntry := CZBibParser parse: '	@article{Herm00a,
 author = {Herman, Ivan and Melan\c{c}on, Guy and Marshall, M. Scott},
 title = {Graph Visualization and Navigation in Information Visualization: A Survey},
 journal = {IEEE Transactions on Visualization and Computer Graphics},
 volume = {6},
 number = {1},
 year = {2000},
 issn = {1077-2626},
 pages = {24--43},
 doi = {10.1109/2945.841119},
 publisher = {IEEE Educational Activities Department},
 address = {Piscataway, NJ, USA}
 }'.

inproceedingsEntry := CZBibParser parse: '	
@inproceedings{Nier04d,
  Abstract     = {In this paper we briefly review various kinds of
                  software changes and the issues that arise from
                  them. As a consequence, we propose research into
                  programming languages with explicit support for
                  representing first-class changes, and for
                  manipulating and merging multiple viewpoints of
                  evolving software systems.},
  Annote       = {internationalworkshop},
  Author       = {Oscar Nierstrasz and Marcus Denker},
  Booktitle    = {OOPSLA Workshop on Revival of Dynamic Languages},
  Cvs	       = {RDLchange},
  Keywords     = {snf05 scg-pub skip-doi jb05 fromscgbib},
  Month	       = oct,
  Title	       = {Supporting Software Change in the Programming
                  Language},
  Url	       =
                  {http://rmod.lille.inria.fr/archives/workshops/Nier04d-RDL04-Change.pdf},
  Year	       = {2004}
}'.

masterEntry := CZBibParser parse: '	
@mastersthesis{Peirs08a,
  author       = {Romain Peirs},
  title	       = {Enhanced Dependency Structure Matrix},
  year	       = {2008},
  abstract     = {Dependency Structure Matrix (DSM) is an approach taken from
                  process optimization and it exists a variety of algorithms
                  to help organizing the matrix in a form that reflects the
                  architecture and highlights patterns and problematic
                  dependencies. However, the existing DSM implementations have
                  a lack of information in their visualization. That is why, we
                  enhanced DSM by adding written and colored information in the
                  visualization to improve the architecture understanding of a
                  software system and the support of its remodularization. This
                  visualization has been implemented on top of Moose which is a
                  collaborative research platform for Software Analysis and
                  Information Visualization. This report presents my
                  internship done at the research centre INRIA Lille - Nord
                  Europe with the RMoD Team led by S. Ducasse.},
  annote       = {master cook},
  school       = {Enseita}
 }'
]

{ #category : #running }
CZEntryTest >> tearDown [
	entry := nil.
	duplicateEntry := nil
]

{ #category : #tests }
CZEntryTest >> testAddToBibSet [
	| bibset |
	
	bibset := CZSet new.
	bibset addEntry: entry.
	
	self assert: ((bibset entries at:1) == entry).
	self assert: (entry scope == bibset).
	
]

{ #category : #tests }
CZEntryTest >> testAt [
	self assert: ((entry at:#pages) class = CZField).
	self assert: ((entry at:#absent) class = CZUndefinedField).
	self assert: (entry at:#absent ifAbsent:'a pas' = 'a pas').
	
]

{ #category : #tests }
CZEntryTest >> testHasField [
	self assert: (entry hasField: #author).
	self assert: (entry hasField: #title).
	self assert: (entry hasField: #pages).
	self deny: (entry hasField: #anotherField).
	self deny: (entry hasField: '').
]

{ #category : #tests }
CZEntryTest >> testKey [
	self assert: (entry key = #testUnpublished).
	entry key: #test.
	self assert: (entry key = #test)
]

{ #category : #tests }
CZEntryTest >> testMacroReferences [
	self assert: (entry macroReferences size = 1).
	entry at: #macro put:#MACRO.
	self assert: (entry macroReferences size = 2)
]

{ #category : #tests }
CZEntryTest >> testMoveToBibSet [
	| bibsetFrom bibsetTo |
	bibsetFrom := CZSet new.
	bibsetTo := CZSet new.
	
	entry addToBibSet: bibsetFrom.
	entry moveToBibSet: bibsetTo.
	
	self assert: (bibsetFrom entries size = 0).
	self assert: (bibsetTo entries size = 1).
	self assert: (entry scope == bibsetTo).
	
]

{ #category : #tests }
CZEntryTest >> testPredefinedAccess [
	"self debug: #testPredefinedAccess"
	
	
]

{ #category : #tests }
CZEntryTest >> testSize [
	| entrySize |
	entrySize := 0.
	entry do: [:each | entrySize := entrySize+1].
	
	self assert: (entry size = entrySize).
	entry at:#nonRenseigne put:'maintenant, si'.
	self assert: (entry size = (entrySize+1))
]

{ #category : #tests }
CZEntryTest >> testType [
	self assert: (entry type = #unpublished).
	entry type: #test.
	self assert: (entry type = #test)
]
