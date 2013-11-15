# HEAD@^~ - Ukens GIT #7-1

Du har sikkert sett referanser til `HEAD@`, `HEAD~`, `HEAD^` og lignende, men vet du hva alle disse egentlig er? La oss begynne med selve `HEAD`, `HEAD` er rett og slett en peker til _hvor du er nå_. Et Git-depot inneholder som du nok vet en tre-lignende graf (egentlig en DAG), og commits er noder i "treet". `HEAD` er en peker til noden som er utsjekket for øyeblikket. Utover `HEAD` finnes det også andre navngitte referanser (noder du kan referere med navn), for eksempel greiner (`master`), tags/merker (`v1.0`), eksterne greiner (`origin/master`). Depotes navngitte referanser og hvor de peker til finner du ved å ta en titt på `git show-ref`

### HEAD@, head@, master@ og @

Som vi så i dasstipset om `git reflog` i forrige uke, så kan man bruke @ til å referere relativt i historien fra vår navigering rundt i depoet. Med andre ord, _hvor vi er nå og stegene vi sekvensielt utførte for å komme oss hit_.

	# Reflog lar oss se historikk på våre operasjoner
	$ git reflog head   # Se global historikk
	$ git reflog master # Se historikk for master-greinen

	# @ lar oss navigere bakover i historikken
	$ git show master@{1}             # En operasjon bakover på master
	$ git show head@{2}               # To operasjoner bakover (globalt)
	$ git show master@{"yesterday"}   # Alternativt på tid/dato

	# Første operasjon som er minst X gammel på gjeldene branch
	$ git show @{"1 week 2 days ago"}

	$ git show @{-1}                  # Forrige branch du sjekket ut

	# Atomløsningen for tirsdag morgen,
	# revert alle mandagscommits på master (mellom søndag og nå)
	$ git revert master@{"last sunday"}..master@{"today at 8:00"}

	# Diff gjeldende branch (master) med forrige utsjekket (gren).
	$ git checkout gren
	$ git checkout master
	$ git diff @{-1}

	# Historikk fra master i går (med tidspunkter):
	$ git reflog master@{"yesterday"}
	525ddab master@{Fri Nov 1 18:18:49 2013 +0100}: commit: Mer fizz
	423efd9 master@{Fri Nov 1 17:07:27 2013 +0100}: commit: Fjernet buzz
	050d410 master@{Fri Nov 1 17:01:36 2013 +0100}: pull: Fast-forward

	# Hva er forskjellen før og etter en pull?
	$ git pull
	$ git diff master master@{1}

På neste toalett tar vi for oss `^` og `~`, så ta gjerne turen dit neste gang.
