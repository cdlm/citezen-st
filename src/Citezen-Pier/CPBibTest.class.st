"
I create a [CP]BibFilePage in Pier as a test fixture and smash it with various scenarios.
"
Class {
	#name : #CPBibTest,
	#superclass : #TestCase,
	#instVars : [
		'testPage'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'as yet unclassified' }
CPBibTest class >> classNamesNotUnderTest [
	^ #( "Not part of PierBib:"
	'CZBibEntry' 'CZBibEntryHtmlView' 'CZBibList' 'CZBibListHtmlView' 'CZBibliographyComponent' 'CZBibWidget'
	'CZFileLibrary' 'CZHtmlRenderer' 'MAServerFileChooserComponent' 'PRVisitor' 'PRViewRenderer'
	"Don't test rendering classes"
	'CZPierBibFileView'
	)
]

{ #category : #'as yet unclassified' }
CPBibTest class >> packageNamesUnderTest [
	^ #('Citezen-Seaside')
]

{ #category : #'test data' }
CPBibTest >> bibFileName [
	^ 'testData.bib'
]

{ #category : #'test data' }
CPBibTest >> bibFilePageName [
	^ 'testData'
]

{ #category : #'test data' }
CPBibTest >> createBibFilePage [
	"self new createBibFilePage"
	| parent child |
	parent := PRKernel instances anyOne root lookupPath: '/'.
	child := CPBibFile named: self bibFilePageName.
	child file: (MAReferenceFileModel fromRio: (Rio new: self bibFileName)).
	parent addChild: child.
	^ child
]

{ #category : #'test data' }
CPBibTest >> createTestBibFile [
	(FileDirectory default newFileNamed: self bibFileName)
		nextPutAll: (self scgbibSample copyReplaceAll: String cr with: String lf);
		close
]

{ #category : #'test data' }
CPBibTest >> deleteBibFilePage [
	| child |
	child := PRKernel instances anyOne root lookupPath: '/', self bibFilePageName.
	child remove
]

{ #category : #'test data' }
CPBibTest >> deleteTestBibFile [
	FileDirectory default deleteFileNamed: self bibFileName
]

{ #category : #'test data' }
CPBibTest >> scgbibSample [
	^ '@techreport{Ache98a,
  Author       = {Franz Achermann},
  Institution  = {IAM, U. Bern},
  Keywords     = {olit scg-wp piccola},
  Month	       = nov,
  Title	       = {JPict --- a framework for pi Agents},
  Type	       = {tech. note},
  Url	       = {http://www.iam.unibe.ch/~scg/Research/Piccola/History/jpict.pdf},
  Year	       = {1998}
}

@article{Duca06b,
  Abstract     = {Inheritance is well-known and accepted as a
                  mechanism for reuse in ob ject-oriented languages.
                  Unfortunately, due to the coarse granularity of
                  inheritance, it may be difficult to decompose an
                  application into an optimal class hierarchy that
                  maximizes software reuse. Existing schemes based on
                  single inheritance, multiple inheritance, or mixins,
                  all pose numerous problems for reuse. To overcome
                  these problems we propose traits, pure units of
                  reuse consisting only of methods. We develop a
                  formal model of traits that establishes how traits
                  can be composed, either to form other traits, or to
                  form classes. We also outline an experimental
                  validation in which we apply traits to refactor a
                  non-trivial application into composable units.},
  Annote       = {internationaljournal},
  Author       = {St\''ephane Ducasse and Oscar Nierstrasz and
                  Nathanael Sch{\"a}rli and Roel Wuyts and Andrew
                  Black},
  Cvs	       = {TraitsTOPLAS2005},
  Doi	       = {10.1145/1119479.1119483},
  Issn	       = {0164-0925},
  Journal      = {ACM Transactions on Programming Languages and
                  Systems (TOPLAS)},
  Keywords     = {scg-pub stefPub snf05 snf06 jb06 toplas traits
                  schaerli toplastraits},
  Misc	       = {SCI impact factor 1.404 (2005)},
  Miscmisc     = {was Duca05z},
  Month	       = mar,
  Number       = {2},
  pages	       = {331--388},
  aeres	       = {ACL},
  aeresstatus  = {aeres08},
  selectif     = {oui},
  inria	       = {hors},
  Title	       = {Traits: A Mechanism for fine-grained Reuse},
  Url	       = {http://scg.unibe.ch/archive/papers/Duca06bTOPLASTraits.pdf},
  Volume       = {28},
  Year	       = {2006}
}

@inproceedings{Lien08b,
  author       = {Adrian Lienhard and Tudor G\^irba and Oscar
                  Nierstrasz},
  title	       = {Practical Object-Oriented Back-in-Time Debugging},
  abstract     = {Back-in-time debuggers are extremely useful tools
                  for identifying the causes of bugs, as they allow us
                  to inspect the past states of objects no longer
                  present in the current execution
                  stack. Unfortunately the "omniscient" approaches
                  that try to remember all previous states are
                  impractical because they either consume too much
                  space or they are far too slow. Several approaches
                  rely on heuristics to limit these penalties, but
                  they ultimately end up throwing out too much
                  relevant information. In this paper we propose a
                  practical approach to back-in-time debugging that
                  attempts to keep track of only the relevant past
                  data. In contrast to other approaches, we keep
                  object history information together with the regular
                  objects in the application memory. Although
                  seemingly counter-intuitive, this approach has the
                  effect that past data that is not reachable from
                  current application objects (and hence, no longer
                  relevant) is automatically garbage collected. In
                  this paper we describe the technical details of our
                  approach, and we present benchmarks that demonstrate
                  that memory consumption stays within practical
                  bounds. Furthermore since our approach works at the
                  virtual machine level, the performance penalty is
                  significantly better than with other approaches.},
  annote       = {internationalconference},
  Note	       = {ECOOP distinguished paper award},
  peer	       = {yes},
  keywords     = {scg-pub object-flow snf08 jb08 girba},
  Publisher    = {Springer},
  Series       = {LNCS},
  Volume       = {5142},
  Url	       = {http://scg.unibe.ch/archive/papers/Lien08bBackInTimeDebugging.pdf
                  http://www.springerlink.com/content/v178515tx1q25823/},
  Doi	       = {10.1007/978-3-540-70592-5_25},
  ISBN	       = {978-3-540-70591-8},
  booktitle    = {Proceedings of the 22nd European Conference on
                  Object-Oriented Programming (ECOOP''08)},
  Pages	       = {592--615},
  year	       = {2008}
}

@techreport{Bung09a,
  Abstract     = {
		Browsers are a crucial instrument to understand complex systems or models. Each problem
		domain is accompanied by an abundance of browsers that are created to help analyze and
		interpret the underlying elements. The issue with these browsers is that they are frequently
		rewritten from scratch, making them expensive to create and burdensome to maintain.
		While many frameworks exist to ease the development of user interfaces in general, they
		provide only limited support to simplifying the creation of browsers.
		In this thesis we present a dedicated model to describe browsers that equally emphasizes
		the control of navigation flow within the browser. Our approach is designed to support
		arbitrar y domain models allowing researchers to quickly define new browsers for their data.
		To validate our model we have implemented the framework Glamour which additionally
		offers a declarative language to simplify the definition of browsers. We have used Glamour
		to re-implement several existing browsers and to explore the creation of new browsers.},
  Author       = {Philipp Bunge},
  Institution  = {University of Bern},
  Keywords     = {snf10 scg-msc jb09 moose-pub},
  Month	       = apr,
  Title	       = {Scripting	Browsers with {Glamour}},
  School       = {University of Bern},
  Type	       = {Master''s Thesis},
  Url	       = {http://scg.unibe.ch/archive/masters/Bung09a.pdf},
  Year	       = {2009}
}

@phdthesis{Deri97a,
  Author       = {Luca Deri},
  Keywords     = {snf-none olit scg-pub skipdoi skip-abstract
                  toBeChecked scg-phd jb97},
  Month	       = jun,
  School       = {University of Bern},
  Title	       = {A Component-based Architecture for Open,
                  Independently Extensible Distributed Systems},
  Type	       = {Ph.{D}. Thesis},
  Url	       = {http://scg.unibe.ch/archive/phd/deri-phd.pdf},
  Year	       = {1997}
}

@misc{PetitPetri,
  Abstract     = {Petri nets are a well-known mathematical formalism for
				modeling and reasoning about concurrency. This web page
                provides an overview of a Squeak Etoys implementation of a
                Petri net interpreter. First download and install Etoys and
                download Petit Petri. If you unzip the Petit Petri download you
                will find several Etoys project files containing examples that
                you can run. Simply start Etoys and drag and drop any of these
                files onto the running Etoys images.},
  Annote       = {misc},
  Author       = {Oscar Nierstrasz and Markus Gaelli},
  Keywords     = {scg-misc skipdoi petri nets etoys jb-none gaelli},
  Month	       = sep,
  Note	       = {http://scg.unibe.ch/download/petitpetri},
  Title	       = {Petit{Petri} --- A {Petri} Net Editor built with
                  {Etoys}},
  Url	       = {http://scg.unibe.ch/download/petitpetri},
  Year	       = {2005}
}
'
]

{ #category : #'test data' }
CPBibTest >> setUp [
	"self new setUp"
	self createTestBibFile.
	testPage := self createBibFilePage
]

{ #category : #'test data' }
CPBibTest >> tearDown [
	"self new tearDown"
	self deleteTestBibFile.
	self deleteBibFilePage
]

{ #category : #running }
CPBibTest >> testBibFileKeywordQuery [
	| result |
	result := testPage query: 'scg-pub oscar'.
	self assert: result size = 2.
]

{ #category : #running }
CPBibTest >> testBibFileKeywordQueryCaseSenstive [
	| result |
	result := testPage queryCaseSensitive: 'scg-pub oscar'.
	self assert: result size = 0.
]

{ #category : #running }
CPBibTest >> testBibFileRegexQuery [
	| result |
	result := testPage query: 'ach\w+ann'.
	self assert: result size = 1.
]

{ #category : #running }
CPBibTest >> testBibFileRegexQueryCaseSensitive [
	| result |
	result := testPage queryCaseSensitive: 'ach\w+ann'.
	self assert: result size = 0.
]

{ #category : #running }
CPBibTest >> testBibListSize [
	self assert: testPage bibList size = 6
]

{ #category : #running }
CPBibTest >> testExpiry [
	| oldTimestamp |
	self assert: testPage isExpired not.
	oldTimestamp := testPage timestamp.
	self deleteTestBibFile.
	(Delay forSeconds: 1) wait.
	self createTestBibFile.
	self assert: testPage isExpired.
	self assert: testPage bibList notNil. "triggers reload"
	self assert: testPage isExpired not.
	self assert: oldTimestamp < testPage timestamp.
]

{ #category : #running }
CPBibTest >> testValidity [
	self assert: testPage isValid.
	self assert: testPage error isEmpty.
]
