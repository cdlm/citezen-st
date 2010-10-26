Extension { #name : #CZEntry }

{ #category : #'*Citezen-Stef-Scripts' }
CZEntry >> isTeamEntry [
	
	| author |
	
	author := self author value.
	^ #( '*Ducasse*S*' '*Denker*M*' '*Anquetil*N*' '*Pollet*D*' '*Abdeen*H*' '*Laval*J*' '*Peirs*R*' '*Falleri*' '*Denier*S*' 
		'*Casaccio*G*' '*Martinez-Peck*' '*Uquillas*' '*Arnaud*J*B*' '*Bhatti*U*' '*Fernandes*H*' '*Razavizadeh*A*' ) anySatisfy: [ :each | each match: author ]
]

{ #category : #'*Citezen-Stef-Scripts' }
CZEntry classSide >> privateFields [
	"privateFields is used to determine the fields that should be removed from our extended bib to offer a public bib"
	^ #(hal keywords annote aeresstatus aeres selectif labo inria rate #'x-editorial-board' #'x-proceedings' #'x-international-audience' #'x-pays' #'x-invited-conference' #'x-scientific-popularization' #'x-language'  #'peerreview' #'hal-id' #Cvs)
]
