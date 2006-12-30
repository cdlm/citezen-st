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
							addFields: #(journal volume number month year);
							initiatorText: 'In ';
							separatorText: ', '; yourself))
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. ';
		terminatorText: '.';
		named: 'entry'
]
