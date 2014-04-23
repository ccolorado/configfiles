au BufNewFile,BufRead /var/www/conf/httpd/conf.d/* setf apache
au BufRead,BufNewFile *.php.bkp set filetype=php

""" .wiki file detection and highlight. """
au BufRead,BufNewFile *.md                  set filetype=markdown
au BufRead,BufNewFile *.wiki                set filetype=mediawiki
au BufRead,BufNewFile *.wikipedia.org*      set filetype=mediawiki
au BufRead,BufNewFile *.wikibooks.org*      set filetype=mediawiki
au BufRead,BufNewFile *.wikimedia.org*      set filetype=mediawiki
au BufRead,BufNewFile *wiki.*               set filetype=mediawiki
