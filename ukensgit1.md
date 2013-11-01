# Branching - Ukens GIT #1

### Opprette ny branch
	$ git checkout -b nybranch                # fra gjeldene branch
	$ git checkout -b master nybranch         # fra spesifisert branch

### Gi branch nytt navn
	$ git branch -m nyttnavn                  # til gjeldende branch
	$ git branch -m gammeltnavn nyttnavn      # til spesifisert branch

### Slette branch - (klassisk git WTF)
	# Slett lokal branch:
	$ git branch -d feature123

	# Push til remote branch med :-prefix sletter remote branch
	$ git push origin :feature123

### Håndtering av remote brancher
	# Vis status på remote brancher
	$ git remote show origin

	# Slett brancher (lokalt) som ikke lengre finnes eksternt
	# Typisk feature brancher som blitt merget og fjernet
	$ git remote prune

	# Følg remote branch med lokal branch
	$ git branch --track lokalbranch origin/remotebranch
	$ git checkout lokalbranch

