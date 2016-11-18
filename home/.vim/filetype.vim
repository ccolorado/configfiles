au BufNewFile,BufRead /var/www/conf/httpd/conf.d/* setf apache
au BufRead,BufNewFile *.php.bkp set filetype=php

""" Set comment string for blade templastes
autocmd FileType blade  setlocal commentstring={{--%s--}}

""" .wiki file detection and highlight. """
au BufRead,BufNewFile *.md                  set filetype=markdown
au BufRead,BufNewFile *.wiki                set filetype=mediawiki
au BufRead,BufNewFile *.wikipedia.org*      set filetype=mediawiki
au BufRead,BufNewFile *.wikibooks.org*      set filetype=mediawiki
au BufRead,BufNewFile *.wikimedia.org*      set filetype=mediawiki
au BufRead,BufNewFile *wiki.*               set filetype=mediawiki

""" Use sql syntax highligth for files opened inside vim  with the \e flag """
""" inside mysql cli client """
au BufNewFile,BufRead *tmp/sql*             set syntax=set nonu
au BufNewFile,BufRead *tmp/sql*             set syntax=set nolist
au BufNewFile,BufRead *tmp/sql*             set syntax=set paste
au BufNewFile,BufRead *tmp/sql*             set syntax=sql

""" web-dev
" au BufRead,BufNewFile *.vue                 set filetype=javascript
