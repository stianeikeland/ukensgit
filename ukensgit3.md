# Der untermodule - Ukens GIT #3

_Yo dawg! I herd u like repos so I put repos in yo repos so u can commit while u commit!_

Noen ganger har man et internt bibliotek som blir brukt av flere produkter / programmer. Programmene ligger gjerne i hver sine git depoter, og biblioteket har gjerne sitt eget depot det også. Git submodule lar deg referere til og sjekke ut andre git depoter inni git depotet ditt - samt å dele dette med de andre utviklerne på prosjektet.

### Legge til en undermodul

Følgende legger til et eksternt git repo som en underkatalog i `lib/` i hovedprogrammets repo. Dette produserer en `.gitmodules`-fil som du commiter og pusher til de andre.

	# Inni utsjekket git depot for hovedprogrammet:
	$ git submodule add git://gitserver/bibliotek.git lib/bibliotek
	Cloning into 'lib/bibliotek'... done.
	$ cat .gitmodules
	[submodule "lib/bibliotek"]
		path = lib/bibliotek
		url = git://gitserver/bibliotek.git
	$ git add .gitmodules
	$ git commit -m "La til bibliotek som submodule"

### Hente ned et depot som bruker undermoduler

	$ git clone git://gitserver/hovedprogram.git
	$ cd hovedprogram
	$ git submodule init          # Last ned eventuelle undermoduler
	Submodule 'lib/bibliotek' (git://gitserver/bibliotek.git) registered
	$ git submodule update
	Submodule path 'lib/bibliotek': checked out '6a21ab9...'

### Spesifikk revisjon av undermodul

Gjerne vil man at alle skal ha samme revisjon av undermodulen utsjekket, og kanskje ikke gjeldende HEAD, men heller en godt uttestet tag eller lignende. Man kan da gjøre følgende:

	$ cd lib/bibliotek            # Gå inn i undermodul
	$ git checkout v1.0
	$ cd ..                       # Gå tilbake til hovedprogram
	$ git add bibliotek           # Commit revisjonen undermodul er på
	$ git commit -m "Hovedprogram bruker nå v1.0 av bibliotek"

De andre utviklerne kan så utføre følgende:

	$ git pull
	$ git submodule update

