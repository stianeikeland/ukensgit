# Subversion i Git - Ukens GIT #5

Er du git-tilhenger, men tvunget til å jobbe mot en trollgammel SVN på et eller flere prosjekter? Du kan faktisk sjekke ut og commite til svn fra git.

### Bruk:

Gitt at SVN-repoet følger konvensjonen med `trunk/`, `branches/` og `tags/` gjør du følgende for å klone et svn repo:

	$ git svn clone --stdlayout http://svnserver/prosjekt

	# Brukes andre navn kan du bruke
	$ git svn clone http://svnserver/prosjekt -T trunk -b branches -t tags

	# Du kan klone trunk direkte dersom du ikke trenger branches/tags
	$ git svn clone http://svn.example.com/project/trunk

Ting som svn sitt ignore-filter fungerer jo ikke i git, men git tilbyr en importfunksjon som løser dette for deg.

	$ git-svn show-ignore > .gitignore

Du kan nå bruke depotet og commite slik du er vant til. Eneste unntaket er at branching og merging er veldig tungt i SVN, så branches bør en prøve å holde lokale i din git. Dette får også et par følger for det å hente ned endringer fra SVN. En bør benytte seg av rebase (istedenfor merge/pull) når man henter ned nye endringer for å beholde en lineær historikk.

	# For å hente nye endringer fra svn:
	$ git svn rebase

For å commite til svn bruker du kommandoen `git svn dcommit`, dette tar alle dine git commits og sender dem over til svn-server.

### Annet:

`git svn` er veldig nyttig for å konvertere gamle svn depot til moderne git depot med historikken i behold. Lag en klone av et svn depot som over og push endringene til din nye git-server.

SVN er bygget inn i git, men det finnes også tredjeparts plugins til andre versjoneringssystemer, som f.eks mercurial (git-hg).
