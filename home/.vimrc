"'" [Vundle setup]
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let custom_system_type = join(readfile(glob('~/.custom_system_type')))

Bundle 'gmarik/vundle'

if custom_system_type == "full"
  Bundle 'Shougo/denite.nvim'
  Bundle 'Shougo/vimproc.vim'
  Bundle 'xolox/vim-notes'
  " TODO Consider pedrosans/vim-notes fork. 'xolox/vim-notes' is apparently
  " abandoned
endif
if custom_system_type == "vm"
  Bundle 'kien/ctrlp.vim'
endif

"== Features  Plugins
" Bundle 'sotte/presenting.vim'

Bundle 'SirVer/ultisnips'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline.git'
Bundle 'chrisbra/NrrwRgn'
Bundle 'diepm/vim-rest-console'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'honza/vim-snippets'
Bundle 'joonty/vdebug'
Bundle 'junegunn/goyo.vim'
Bundle 'junegunn/vim-easy-align'
Bundle 'posva/vim-vue'
Bundle 'ramele/agrep'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'stephpy/vim-php-cs-fixer'
Bundle 'tmhedberg/matchit'
Bundle 'tommcdo/vim-exchange'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vinegar'
Bundle 'vim-scripts/taglist.vim'
Bundle 'xolox/vim-misc'

"== Syntax Plugins

Bundle 'JulesWang/css.vim'
Bundle 'StanAngeloff/php.vim'
Bundle 'ap/vim-css-color'
Bundle 'jelera/vim-javascript-syntax.git'
Bundle 'ruanyl/vim-blade'
Bundle 'kchmck/vim-coffee-script'
Bundle 'leshill/vim-json'
Bundle 'mitsuhiko/vim-python-combined'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'rodjek/vim-puppet'
Bundle 'scrooloose/syntastic'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails.git'
Bundle 'vim-ruby/vim-ruby'

"== Annoyance highlight ONLY the word under cursor WITHOUT jumping to the next occurence
"   the first
"time

filetype plugin indent on     " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
" Put your stuff after this line

"" ======================
set ssop=blank,buffers,curdir,folds,resize,tabpages,winsize,winpos
set autoread
" display incomplete commands
set showcmd
" Don't redraw while executing macros
set lazyredraw

set nocursorline

" Show matching brackets when text indicator is over them
set showmatch

" No wrapping text by default
set nowrap
" Leave hidden buffers open
set hidden
" override default 8 last commands to remember
set history=100

" Do vertical splits to the right and horizontal splits below instead of top
set splitbelow
set splitright

"=========Backup and restoring
set dir=./.backup,~/.vim/backup_files,/tmp
silent execute '!mkdir -p $HOME/.vim/tmp/{backup,swap,view,undo}'
set backupdir=$HOME/.vim/tmp/backup/
set backup
set directory=$HOME/.vim/tmp/swap/
set viewdir=$HOME/.vim/tmp/view/
" store undo files, undo edits after deleting a buffer
"set undodir=$HOME/.vim/tmp/undo/
"set undofile
set viminfo='50,n$HOME/.vim/tmp/viminfo

"Change buffer - without saving
set hid
" Don't move cursor to begining of line when switching buffers
set nostartofline

scriptencoding utf-8
set termencoding=utf-8
set encoding=utf-8
set backspace=indent,eol,start
" show the cursor position all the time
set ruler

let mapleader = ","
let g:mapleader = ","

" tab completion for comands and hopefully filenames
set wildmode=longest,list,full
set wildmenu

" Search options
" Blinks underscore of search result
function! HLNext (blinktime)
  set invcursorline
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 250) . 'm'
  set invcursorline
  redraw
endfunction

set scrolloff=5
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

" do incremental searching
set incsearch

set ignorecase
set smartcase
set hlsearch

if has("syntax")
    syntax on
endif

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
"  Switching indentation schema
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set noexpandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

set autoindent

" sudo omission fix
cmap w!! w !sudo tee >/dev/null %

" Display characters for indetation, eol, and trailing whitespace
exec "set listchars=tab:\uB7\uB7,trail:\uBB,nbsp:~"
set list
" Reload vimrc
map <leader>e :so $MYVIMRC<CR>


"========Custom Keystrokes
"
"=== Fat finger workaroudn
" Approach to remap commonly mistaken keystrokes, usally by holding the shift key
" for longer that it should.
" taken from http://blog.sanctum.geek.nz/vim-command-typos/

if has("user_commands")
  " Saving changes
  command! -bang -nargs=? -complete=file E e<bang> <args>
  command! -bang -nargs=? -complete=file W w<bang> <args>
  command! -bang -nargs=? -complete=file Wq wq<bang> <args>
  command! -bang -nargs=? -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
  command! -bang Qall qall<bang>

  "Other
  "Vertical splitting
  command! -nargs=? -complete=file Vsp vsp <args>

endif

"=== Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"=== Save file with Ctrl+s
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Paste Toggle
set pastetoggle=<f3>
set clipboard=unnamedplus


" Arrowless window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <Down> gj
nmap <Up> gk

"========Plug-ins

"== UltiSnips
set runtimepath+=~/.vim/custom_snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsListSnippets=<
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/.vim/custom_snippets/"]
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/custom_snippets']

let g:UltiSnipsEditSplit="context"

"== vim-surround

let b:surround_72 = "[\"\r\"]"
let b:surround_104 = "['\r']"

let b:surround_109 = "{{ \r }}"

"== vim-syntastic

" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

"== gundo.vim
nnoremap <leader>u :GundoToggle<CR>

"== vim-php-cs-fixer
let g:php_cs_fixer_enable_default_mapping = 0
let g:php_cs_fixer_level = "symfony"
let g:php_cs_fixer_config = "default"
let g:php_cs_fixer_rules = "@PSR2"
nnoremap <silent><leader>p :call PhpCsFixerFixFile()<CR>
nnoremap <silent><leader>P :call PhpCsFixerFixDirectory()<CR>

"== easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"== Nerdtree
let NERDTreeShowLineNumbers=1
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" nmap <silent><leader>f :NERDTreeToggle<CR> && :NERDTreeFind<CR>
nmap <silent><leader>f :NERDTreeToggle<CR>

if custom_system_type == "full"

  "== denite.vim
  if executable('ag')
    call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nogroup',
          \'--ignore-dir', 'node_modules',
          \'--ignore-dir', 'vendor',
          \'--ignore-dir', 'docs',
          \'-g', ''])
  endif

  nmap <leader><space> :Denite file_rec buffer<CR>
  nmap <space> :Denite buffer<CR>

else

  ""== cntlp
  nmap <leader><space> :CtrlPBuffer<CR>
  nmap <leader> :CtrlPMixed<CR>
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

endif
"== airline
"" FIXES The statusline is hidden/only appears in split windows!
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

set laststatus=2
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
"let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline#extensions#branch#symbol = '⭠'
let g:airline#extensions#readonly#symbol = '⭤'
let g:airline_symbols.linenr = '⭡'

let g:airline#extensions#whitespace#trailing_format = '$[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = ' ^[%s]'

let g:airline_theme = 'dark'
let g:airline_inactive_collapse=1
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

"== vim-notes
let g:notes_directories = ['~/Dropbox/Notes']
nnoremap <leader>nc :vsp<CR>:Note<Space>
nnoremap <leader>ns :vsp<CR>:SearchNotes<Space>

"== taglist
" First check if ctags is installed
if executable('ctags')
  let Tlist_Ctags_Cmd = "/usr/bin/ctags"
  let Tlist_WinWidth = 50
  let Tlist_Use_Right_Window=1
  " Maps F4 to toggle the ctags widnow
  map <F4> :TlistToggle<cr>
  " Maps building tags to F10 for the current directory
  " map <leader>0 :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
  map <leader>0 :Dispatch /usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude={*.phar,node_modules,vendor,docs,public,.branch_dir,*min.js} .<CR>
  " Open tag file on vertical split and move it to the right split
  nmap <leader>]  :vsp <CR>:exec("tag ".expand("<cword>"))<CR>zz
  nmap <leader>[  :exec("tag ".expand("<cword>"))<CR>zz
endif

"== Clear search highlights
nmap \q :nohlsearch<CR>
"== Switch to next buffer
nmap <C-e> :e#<CR>
"set ff=dos,unix Change file format to avoid ^M line breaks also
"replacing ^M's :%s/CTRL-v ENTER//g

"== Search visually selected text
vnoremap // y/<C-R>"<CR>

" Show vimdiff of unsaved changes

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

nmap <leader>d :DiffSaved <CR>

"== Tabs
nmap <leader>h :tabprevious<CR>
nmap <leader>j :tab sp<CR>
nmap <leader>k :tab new<CR>
nmap <leader>l :tabnext<CR>

"== Center cursor vertically
" TODO: make this toggable
nmap <leader>zz :set scrolloff=999<CR>

"Alternative Insert Mode exit
imap jj <Esc>

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
      set t_Co=256
endif

set background=dark
colorscheme molokai-transparent
:hi Normal ctermbg=NONE
:hi Visual term=reverse cterm=reverse guibg=Grey

"== Vdebug

" less intrusive, more readable highlighting

highlight DbgBreakptLine ctermbg=none ctermfg=none
highlight DbgBreakptSign ctermbg=none ctermfg=10

"highlight DbgCurrentLine ctermbg=none ctermfg=none
highlight DbgCurrentSign ctermbg=none ctermfg=red

if v:version > 702
 highlight ColorColumn ctermbg=darkgrey
 call matchadd('ColorColumn', '\%81v', 100)
endif

" Better diff highlights
" From https://groups.google.com/forum/#!topic/vim_use/IERXsR4WVFk
highlight! link DiffText MatchParen

"== Annoyance * Spell check word under cursor without adding spellcheck to the said file

" TODO: create function to togggle spell highlighting
" http://stackoverflow.com/questions/22180623/spell-check-word-under-cursor-in-vim

" Toggle line numbering relative and absolute
" Vim 7.4 doesn't turn line numbers on when disable relative lines
function! ToggleLineNumbering()
  set nu!
  if v:version > 703
    set rnu!
  endif
endfunction

" Toggle extra characters for copying with mouse
function! ToggleCopyMode()
  echo "function called"
  call ToggleLineNumbering()
  if &number
    set list
    set wrap
    :GitGutterEnable
  else
    set nolist
    set nowrap
    :GitGutterDisable
  endif
endfunction

set nu
if v:version > 702
  "set relative line numbering On by default on vim 7.2 and up
  "
  set rnu
  nmap <F2> :call ToggleCopyMode()<CR>
endif

:source ~/.vim/autocorrect.vim

" Pdf text reader command Rpdf
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

" Unsuccessful attempt to do a 'read mode' highlighting perhaps can be ironned
" out in the future
"" 'Reading Mode' Next/Previous Sentence highlight
" xnoremap <leader>( <Esc>((vis
" xnoremap <leader>) <Esc>vis

autocmd Filetype svn  setlocal spell textwidth=72
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype mediawiki setlocal spell textwidth=90
autocmd Filetype markdown setlocal spell textwidth=90

" Auto resize splits proportionaly on window resize
autocmd VimResized * :wincmd =

" open file under cursor on new vertical split
:nnoremap gf] <C-W>vgf

" open file under cursor on new horizontal split
:nnoremap gf[ <C-W><C-f>

" Opens each line of a text file in vim
" for line in getline(1, '$') | exec 'argadd' line | endfor

" Traverse the buffer list comparing against development branch
nnoremap <leader>t :w<CR>:Gwrite<CR>:q<CR>:next<CR>:Gdiff development<CR>

map <leader>T :Dispatch! tmux send-keys -t 1.0 "clear; codeceptjs run . --steps" C-m <CR>
map <leader>t :Dispatch! tmux send-keys -t 1.0 "clear; codeceptjs run .  %:t  --steps" C-m <CR>
map <leader>g :Dispatch! tmux send-keys -t 0.2 "clear; npm run dist" C-m <CR>

" au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-e>"

" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Follow and highlight current line
" taken from http://vim.wikia.com/wiki/Highlight_current_line
hi CursorLine   cterm=NONE ctermbg=yellow ctermfg=black guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
nnoremap <Leader>c :set cursorline!<CR>

