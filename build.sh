#!/bin/bash

rm ukens*.html

echo "<html><body>" > index.html

for f in *.md; do
	BASE=`basename ${f} .md`
	cat templatetop.html > ${BASE}.html
	multimarkdown $f | sed 's/<pre><code>/<pre><code class="prettyprint lang-sh">/g'>> ${BASE}.html
	cat templatebottom.html >> ${BASE}.html

	echo "<a href='${BASE}.html'>${BASE}</a><br />" >> index.html
done

echo "</body></html>" >> index.html

cp *.html /Users/se/Dropbox/Public/ukensgit/
cp -r resources /Users/se/Dropbox/Public/ukensgit/
