# Rerererererererererere - Ukens Git #8

Løser du noen gang de samme merge/rebase-konfliktene flere ganger? Git har en funksjon ved navn rerere (reuse recorded resolution). Den kan brukes manuelt før og etter du løser en konflikt ved å kjøre kommandoen `git rerere`, men kan også aktiveres globalt (alltid aktiv).

	# Aktiver git rerere:
	$ git config --global rerere.enabled 1

Hver gang du nå løser en konflikt vil den huske løsningen, og dukker den samme konflikten opp i fremtiden vet git hvordan konflikten skal løses.

	# Merge/rebase og løs en konflikt:
	$ git rebase master
	CONFLICT (content): Merge conflict in fizzbuzz.c
	Recorded preimage for 'fizzbuzz.c'
	Automatic merge failed; fix conflicts and then commit the result.
	$ git add fizzbuzz.c && git commit
	Recorded resolution for 'fizzbuzz.c'.

	# Neste gang samme konflikt dukker opp:
	$ git rebase master
	Auto-merging fizzbuzz.c
	CONFLICT (content): Merge conflict in fizzbuzz.c
	Resolved 'fizzbuzz.c' using previous resolution.

### Hodeløs testing

Du jobber på en gren med ny funksjonalitet, en av dine kollegaer jobber på en annen gren. Du mistenker at grenene kan brekke hverandre, og vil gjerne avdekke dette på et tidlig tidspunkt. Ingen av grenene er klare nok til å merges til master.

Et enkelt triks er da å sjekke ut siste commit på grenen din, du kommer da inn i en såkalt 'detached HEAD' tilstand, du er ikke lengre på en spesifikk gren. Git vil ikke ta vare på noe du gjør her med mindre du gjør det om til en ekte navngitt gren, dette er en fin lekeplass for eksperimenter.

	# Sjekk ut siste commit som detached head
	(feature1)$ git checkout HEAD@{0}
	Note: checking out 'HEAD@{0}'. You are in 'detached HEAD' state....
	# Merge så inn grenen du ønsker å teste mot
	(0ded449)$ git merge feature2
	# Løs eventuelle konflikter og gjør testingen din.

Når du er ferdig kan du sjekke ut en vanlig navngitt gren igjen (master, feature1, etc.) - du slipper å rydde opp etter festen. Gits søppeltømmer vil ta seg av rotet og slette ditt hodeløse eksperiment etter ca 30 dager. Angrer du deg før den tid kan du ta i bruk reflog (se tidligere dasstips).

Siden du nå har rerere aktivert vet git hvordan den skal løse disse mergene i fremtiden, det betyr at du lett kan teste igjen når som helst, uten at du må løse de samme konfliktene om igjen, og uten at historikken blir full av unyttige merges.

Husk å slette eventuelle løsninger som du gjør feil underveis (`git rerere forget`)
