Class {
	#name : #CZLaTeXOutputerTest,
	#superclass : #CZOutputterTest,
	#category : #'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> rendererClass [
	^ CZLaTeXOutputer
]

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> testArticle [
	"self debug: #testArticle"
	
	super testArticle.
	
	self assert: result  = '\pub  \emph{S. Ducasse and D. Pollet},
 \emph{Fingerprints},
 In \emph{Journal of Information System},
2010'
]

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> testLongArticle [
	super testLongArticle.
	self assert: result = '\pub  \emph{H. Abdeen, I. Alloui, S. Ducasse, D. Pollet and M. Suen},
 \emph{Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships},
ACT,
aeres08,
internationalconference stefPub,
 In \emph{European Conference on Software Maintenance and Reengineering (CSMR)},
ADAM,
moose-pub,
Athens, Greece,
Acceptance rate: 24/87 = 27\%,
87,
24,
pp. 213--222,
IEEE Computer Society Press,
27%,
oui,
http://scg.unibe.ch/archive/external/Abde08a.pdf,
2008,
http://scg.unibe.ch/archive/external/Abde08a.pdf'
]

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> testSeveral [
	super testSeveral.
	self assert: result = '\pub  \emph{S. Ducasse and D. Pollet},
 \emph{Fingerprints},
 In \emph{Journal of Information System},
2010
\pub  \emph{H. Abdeen, I. Alloui, S. Ducasse, D. Pollet and M. Suen},
 \emph{Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships},
ACT,
aeres08,
internationalconference stefPub,
 In \emph{European Conference on Software Maintenance and Reengineering (CSMR)},
ADAM,
moose-pub,
Athens, Greece,
Acceptance rate: 24/87 = 27\%,
87,
24,
pp. 213--222,
IEEE Computer Society Press,
27%,
oui,
http://scg.unibe.ch/archive/external/Abde08a.pdf,
2008,
http://scg.unibe.ch/archive/external/Abde08a.pdf' 
]
