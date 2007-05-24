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
		named: 'article'
]

{ #category : #'basic entry types' }
BibPhraseLibrary class >> bibarticle [
	^ BibSequencePhrase new
		addNamedFields: #(url keywords);
		add: ((BibAlternativePhrase
				rules: {
					[:e | e hasField: #here]
					-> (BibSequencePhrase new
							add: (BibLiteralPhrase text: 'HERE');
							addField: #weight;
							separatorText: '/ '; yourself)}
				default: (BibSequencePhrase new
							addFields: #(water fire);
							separatorText: '| '; yourself))
			named: 'elements');
		addNamedField: #note;
		separatorText: '!? ';
		terminatorText: '...';
		named: 'nimp'
]
