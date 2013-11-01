# Hvor gikk det galt? - Ukens GIT #2

En eller annen gang mellom nå og en evighet siden oppstod en intrikat regresjonsfeil. Funksjonalitet du vet virket før, virker ikke lengre. Feilen er dessuten vanskelig å knytte til noen spesifikk kode. Hvor, når og hva var det egentlig som gikk galt? Git bisect kan hjelpe deg å finne svaret.
Git bisect lar deg utføre binærsøk i historikken din.

### Manuelt søk:
	$ git bisect start                  # Start et nytt søk.
	$ git bisect bad                    # Gjeldende commit fungerer ikke.
	$ git bisect good HEAD~100          # 100 commits tidligere virket.
	Bisecting: 49 revisions left to test after this (roughly 6 steps)

Git finner så frem commits i tur og orden hvor du må svare på om dette er en good commit (uten regresjonen) eller en bad commit (med regresjonen).

	$ git bisect bad                    # Merker denne som dårlig.
	Bisecting: 24 revisions left to test after this (roughly 5 steps)
	$ git bisect good                   # Merker denne som bra.
	Bisecting: 12 revisions left to test after this (roughly 4 steps)

Til slutt sitter du igjen med en utsjekket commit hvor det faktisk gikk åt skogen.

	$ git bisect good
	7974f24dc57dfe7f1f91a4479af8b654a2f86c9e is the first bad commit
	$ git bisect reset                  # Avslutt.

### Automatisk søk

Letingen kan også automatiseres dersom det er veldig mange commits som skal sjekkes. Lage et lite program eller script som sjekker etter feilen for deg.

	#!/usr/bin/env python
	import sys
	import kalkulator
	if kalkulator.summer(2, 2) != 4:
		sys.exit(1)
	sys.exit(0)

La git bisect kjøre scriptet, og den finner frem til stedet hvor regresjonen ble innført

	$ git bisect start HEAD HEAD~100    # Søk fra HEAD til HEAD~100.
	$ git bisect run ./testscript.py
	51b3d63432203898d4d58710f0dcf1178cce1d7e is the first bad commit
	bisect run success

