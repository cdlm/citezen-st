Extension { #name : #CZEntry }

{ #category : #'*Citezen-Stef-Scripts' }
CZEntry >> isTeamEntry [
	
	| author |
	
	author := self author value.
	^ #( '*Ducasse*S*' '*Denker*M*' '*Anquetil*N*' '*Pollet*D*' '*Abdeen*H*' '*Laval*J*' '*Peirs*R*' '*Falleri*' '*Denier*S*' 
		'*Casaccio*G*' '*Arnaud*J*B*' '*Bhatti*U*' '*Fernandes*H*' '*Razavizadeh*A*' ) anySatisfy: [ :each | each match: author ]
]
