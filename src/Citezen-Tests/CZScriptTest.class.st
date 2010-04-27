Class {
	#name : #CZScriptTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset',
		'script'
	],
	#category : #'Citezen-Tests'
}

{ #category : #running }
CZScriptTest >> setUp [ 
	bibset := CZBibParser parse: 
	'
	@article { a1,
		author = {Barreau, Adrien},
		title = {title1}
	}
	
	@article { a3,
		author = {Barreau, Adrien},
		title = {title2},
		year = 2003
	}
	
	@article { a2,
		author = {Toto, Robert},
		title = {title3},
		year = 2005
	}
	
	@unpublished { u1,
		author = {Barreau, Adrien},
		title = {titleUn1},
		year = 2005
	}
	
	@misc { m1,
		author = {Toto, Robert},
		title = {title4},
		year = 2000
	}
	'
	.
	script := CZScript new bibsetInput: bibset; exportAsBib 
]

{ #category : #RemoveTests }
CZScriptTest >> testBlackList [
	| output |
	output := script blackList: #(a1 a2); generate.
	
	self assert: output = 
'@article {a3,
  author = {Barreau, Adrien},
  title = {title2},
  year = 2003
}

@unpublished {u1,
  author = {Barreau, Adrien},
  title = {titleUn1},
  year = 2005
}

@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

'

]

{ #category : #SortTests }
CZScriptTest >> testDoubleSort [
	| output |
	output := script sortByField: #year; sortByField: #author; generate.
	
	self assert: output = 
'@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

@article {a3,
  author = {Barreau, Adrien},
  title = {title2},
  year = 2003
}

@unpublished {u1,
  author = {Barreau, Adrien},
  title = {titleUn1},
  year = 2005
}

@article {a2,
  author = {Toto, Robert},
  title = {title3},
  year = 2005
}

'
]

{ #category : #RemoveTests }
CZScriptTest >> testNoChanges [
	"Print the bibset should give an identical bibset"
	
	| output bibset2 |
	output := script generate.
	bibset2 := CZBibParser parse: output.
	
	self assert: (bibset equalsButDifferent: bibset2)
]

{ #category : #RemoveFieldsTests }
CZScriptTest >> testRemoveFields [
	| output |
	output := script fieldsToRemove: #(author); generate.
	
	self assert: output = 
'@article {a1,
  title = {title1}
}

@article {a3,
  title = {title2},
  year = 2003
}

@article {a2,
  title = {title3},
  year = 2005
}

@unpublished {u1,
  title = {titleUn1},
  year = 2005
}

@misc {m1,
  title = {title4},
  year = 2000
}

'
]

{ #category : #RemoveFieldsTests }
CZScriptTest >> testRemoveFieldsBadFields [
	| output |
	output := script fieldsToRemove: #(BADFIELD author BADFIELD2); generate.
	
	self assert: output = 
'@article {a1,
  title = {title1}
}

@article {a3,
  title = {title2},
  year = 2003
}

@article {a2,
  title = {title3},
  year = 2005
}

@unpublished {u1,
  title = {titleUn1},
  year = 2005
}

@misc {m1,
  title = {title4},
  year = 2000
}

'
]

{ #category : #SortTests }
CZScriptTest >> testSortByField [
	| output |
	output := script sortByField: #year; generate.
	
	self assert: output = 
'@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

@article {a3,
  author = {Barreau, Adrien},
  title = {title2},
  year = 2003
}

@article {a2,
  author = {Toto, Robert},
  title = {title3},
  year = 2005
}

@unpublished {u1,
  author = {Barreau, Adrien},
  title = {titleUn1},
  year = 2005
}

'
]

{ #category : #SortTests }
CZScriptTest >> testSortByKey [
	| output |
	output := script sortByKey; generate.
	
	self assert: output = 
'@article {a1,
  author = {Barreau, Adrien},
  title = {title1}
}

@article {a2,
  author = {Toto, Robert},
  title = {title3},
  year = 2005
}

@article {a3,
  author = {Barreau, Adrien},
  title = {title2},
  year = 2003
}

@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

@unpublished {u1,
  author = {Barreau, Adrien},
  title = {titleUn1},
  year = 2005
}

'
]

{ #category : #SortTests }
CZScriptTest >> testSortByType [
	| output |
	output := script sortByType; generate.
	
	self assert: output = 
'@article {a1,
  author = {Barreau, Adrien},
  title = {title1}
}

@article {a3,
  author = {Barreau, Adrien},
  title = {title2},
  year = 2003
}

@article {a2,
  author = {Toto, Robert},
  title = {title3},
  year = 2005
}

@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

@unpublished {u1,
  author = {Barreau, Adrien},
  title = {titleUn1},
  year = 2005
}

'
]

{ #category : #DisplayOrderTests }
CZScriptTest >> testTypeOrderDisplayingBadOrder [
	| output |
	output := script displayOrder: #(BADTYPE misc BADTYPE2); generate.
	
	self assert: output = 
'@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

'
]

{ #category : #DisplayOrderTests }
CZScriptTest >> testTypeOrderDisplayingWithWildcard [
	| output |
	output := script displayOrder: #(misc *); generate.
	
	self assert: output = 
'@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

@article {a1,
  author = {Barreau, Adrien},
  title = {title1}
}

@article {a3,
  author = {Barreau, Adrien},
  title = {title2},
  year = 2003
}

@article {a2,
  author = {Toto, Robert},
  title = {title3},
  year = 2005
}

@unpublished {u1,
  author = {Barreau, Adrien},
  title = {titleUn1},
  year = 2005
}

'
]

{ #category : #DisplayOrderTests }
CZScriptTest >> testTypeOrderDisplayingWithoutWildcard [
	| output |
	output := script displayOrder: #(misc); generate.
	
	self assert: output = 
'@misc {m1,
  author = {Toto, Robert},
  title = {title4},
  year = 2000
}

'
]

{ #category : #RemoveTests }
CZScriptTest >> testWithQuery [
	| output aQuery |
	aQuery := CZBibFieldQuery named: #year checks: [ :each | each = 2005].
	
	output := script query: aQuery; generate.

	self assert: output = 
'@article {a2,
  author = {Toto, Robert},
  title = {title3},
  year = 2005
}

@unpublished {u1,
  author = {Barreau, Adrien},
  title = {titleUn1},
  year = 2005
}

'
]
