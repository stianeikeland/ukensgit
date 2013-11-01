# Grenfilter - Ukens GIT #4

Har du opplevd det å sitte med et prosjekt som har vokst seg stort over tid? Så stort at det ikke er praktisk å oppbevare det i et enkelt git depot lengre - kanskje vil du skille ut f.eks backend og frontend til sine egne depoter - og helst beholde den relevante historikken for hvert depot.

Kanskje har du dummet deg ut og commitet sensitiv informasjon (f.eks passord, sertifikater eller nøkler) eller store binærfiler?

Git tilbyr kommandoen `filter-branch` som lar deg sile bort (eller utføre endringer på) commits basert på forskjellige kriterier som f.eks fil/katalog-navn, commit-melding, hvem som commitet, osv.

`filter-branch` er en destruktiv kommando, den skriver om historikken (ureverserbar) og bør derfor brukes med forsiktighet.

### Filtrere basert på underkatalog

Gitt at du har et depot hvor du ønsker å skille ut katalogene `frontend/` og `backend/` til egne depot som beholder kun relevant historikk.

	$ git clone git://gitserver/prosjekt.git
	$ cd prosjekt
	# Filtrer og behold kun commits og filer tilhørende backend.
	$ git filter-branch --prune-empty --subdirectory-filter backend HEAD
	Rewrite fa886d3fd7685c5b0cebfe213cb1dd5ec52c9cab (19/19)
	Ref 'refs/heads/master' was rewritten

Du kan nå f.eks dytte dette tilbake til gitserveren din som et nytt depot ved navnet prosjekt-backend. Utfør det samme på frontend så har du delt opp prosjektet ditt til to depoter med all relevant historikk i behold.

### Slette en fil fra all commit-historikk

For å fjerne en fil (sensitiv informasjon, store binære filer, osv) fra et git depot kan du utføre:

	# Dette fjerne filen filnavn fra all tidligere historikk:
	$ git filter-branch --index-filter 'git rm --cached --ignore-unmatch filnavn' HEAD

Du må antagelig force-pushe for å sende endringene til server etterpå.

### Annet

`filter-branch` er nyttig til alle mulige store og små batch operasjoner i historikken din. Noen eksempler på bruksområder:

* Retroaktivt endre epost-adresser til commit-forfatter dersom man får ny.
* Fjerne all kode som er skrevet på mandager.
* Flytte hele treet inn i en underkatalog istedenfor rot.
* Redusere størrelse på depot ved å fjerne filer som ikke er aktuelle å ta vare på.
