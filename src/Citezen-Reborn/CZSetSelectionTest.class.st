Class {
	#name : #CZSetSelectionTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #setup }
CZSetSelectionTest >> setUp [

	bibset := CZBibParser parse: '
	@article{key1,
		author = {Barreau, Adrien},
		annote = {a},
		title = {article / key 1},
		year = 2000
	}
	
	@article{key2,
		author = {Barreau, Adrien},
		annote = {b},
		title = {article / key 2},
		year = 2002
	}
	
	@misc{key3,
		author = {Barreau, Adrien and Marcel, Robert},
		annote = {c},
		title = {misc / key 3},
		year = 2001
	}
	
	@misc{key4,
		author = {Barreau, Adrien and Marcel, Robert},
		annote = {d},
		title = {article},
		year = 2001
	}
	
	@misc{key5,
		author = {Chat, Le},
		annote = {choucroute},
		title = {Le chat aime la choucroute},
		year = 2001,
		note = {note}
	}
	'.
]

{ #category : #testing }
CZSetSelectionTest >> testSort [
	"self debug: #testSort"
	
	CZSetSelection new
		entries: bibset entries; 
		sort
	
]
