Class {
	#name : #BibPhraseLibrary,
	#superclass : #Object,
	#category : #'Citezen-Rendering'
}

{ #category : #'basic entry types' }
BibPhraseLibrary class >> article [
	^ BibSequencePhrase new
		addNamedFields: #(author title);
		add: ((BibAlternativePhrase
				rules: {
					[:e | e hasField: #crossref]
					-> (BibSequencePhrase new
							add: (BibLiteralPhrase text: 'CROSSREF');
							addField: #pages;
							separatorText: ', '; yourself)}
				default: (BibSequencePhrase new
							addField: #journal;
							add: self volumeNumberPages;
							add: self monthYear;
							initiatorText: 'In '; separatorText: ', '; yourself))
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. '; terminatorText: '.';
		named: 'article'
]

{ #category : #'partial phrases' }
BibPhraseLibrary class >> monthYear [
	^ BibSequencePhrase new
		separatorText: ' ';
		addFields: #(month year)
]

{ #category : #'partial phrases' }
BibPhraseLibrary class >> volumeNumberPages [
	^ BibSequencePhrase new
		separatorText: ': ';
		add: (BibSequencePhrase new
			addField: #volume;
			add: (BibSequencePhrase new
				initiatorText: '(';	addField: #number; terminatorText: ')'));
		addField: #pages
]
