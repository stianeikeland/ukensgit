#  - Ukens GIT #6

De gangene man bæsjer på leggen med git kan det være en trøst at det egentlig er skikkelig vanskelig å miste data eller gjøre uopprettelig skade. Som regel skal det et par tre skikkelige brølere til på rad før du faktisk har ødelagt noe. Reflog er en mekanisme i git som holder rede på alle endringene du gjør (commits, checkouts, (hard) resets, osv) i et gitt antall dager (ca 1 mnd).

### Eksempel - git reset
	$ git reset --hard HEAD~3
	# Oi, der gikk vi tilbake for mange commits, vi skulle bare 2 tilbake
	$ git reflog
	e3c7357 HEAD@{0}: reset: moving to HEAD~3
	677ee12 HEAD@{1}: commit: 3
	121e3f9 HEAD@{2}: commit: 2
	c5eb0eb HEAD@{3}: commit: 1

	# Gå til tilstanden vi var i etter commit 1
	$ git reset --hard HEAD@{3}
	HEAD is now at c5eb0eb 1

	# Du kan også bruke operasjoner som merge eller cherry-pick for å
	# plukke med deg endringer du kanskje ville ha likevel
	$ git cherry-pick HEAD@{2}
	[master 9363daa] 2

### Eksempel - slettet gren:

Kanskje har du hatt en lokal gren gående over lang tid, en gren som fikset alle buggene i prosjektet. I et blondt øyeblikk klarte du å slette den - krise!

	$ git checkout master
	$ git branch -D fikser-alle-bugs
	Deleted branch fikser-alle-bugs (was 24b74fa).

	$ git reflog
	e3c7357 HEAD@{0}: checkout: moving from fikser-alle-bugs to master
	24b74fa HEAD@{1}: commit: fikset alle buggene i prosjektet
	e3c7357 HEAD@{2}: checkout: moving from master to fikser-alle-bugs

	# Finn siste commit du gjorde på grenen du slettet, og sjekk ut
	$ git checkout -b fikser-alle-bugs 24b74fa

### Annet:

* Ta gjerne en backup av .git før du går i gang med avansert redningsarbeid.
* `git reflog` kan ikke hjelpe deg med data som ikke er commitet - commit ofte (og squash).
* Har du virkelig ødelagt for deg selv, ta en titt på `git fsck --lost-found`.
