au BufNewFile,BufRead /var/www/conf/httpd/conf.d/* setf apache
au BufRead,BufNewFile *.php.bkp set filetype=php

""" Set comment string for blade templastes
autocmd FileType blade  setlocal commentstring={{--%s--}}

""" Set automatic spellcheck for notes
autocmd Filetype notes  setlocal spell

""" Set NestedMarkdownFolds for markdown
autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

""" .wiki file detection and highlight. """
au BufRead,BufNewFile *.md                  set filetype=markdown
au BufRead,BufNewFile *.es.md               set spelllang=es filetype=markdown
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
au BufRead,BufNewFile *.vue                 set textwidth=80

"""Notes
au BufNewFile,BufRead *Notes/*              set textwidth=120
au BufNewFile,BufRead *Notes/*              set spell
au BufNewFile,BufRead *Notes/*              call matchadd('ColorColumn', '\%110v', 100)

""" TextWidht
autocmd Filetype svn  setlocal spell textwidth=72
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype gitcommit setlocal foldlevel=999
autocmd Filetype gitcommit if getfsize(@%) > 1000000 | setlocal syntax=OFF | endif
autocmd Filetype mediawiki setlocal spell textwidth=90
autocmd Filetype markdown setlocal spell textwidth=90
autocmd Filetype vim setlocal foldmethod=marker

