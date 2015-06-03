"'" [Vundle setup]
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'Shougo/vimproc.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline.git'
Bundle 'chrisbra/NrrwRgn'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'gmarik/vundle'
Bundle 'jelera/vim-javascript-syntax.git'
Bundle 'joonty/vdebug'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sheerun/vim-polyglot'
Bundle 'sjl/gundo.vim'
Bundle 'takac/vim-hardtime'
Bundle 'tommcdo/vim-exchange'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vinegar'
Bundle 'vim-ruby/vim-ruby.git'
Bundle 'vim-scripts/grep.vim'
Bundle 'vim-scripts/taglist.vim'

" Themes
Bundle 'wellsjo/wells-colorscheme.vim'
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

set scrolloff=10
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
exec "set listchars=tab:\uB7\uB7,trail:\uBB,nbsp:~,eol:\uAC"
set list
" Reload vimrc
map <silent><leader>e :so $MYVIMRC<CR>


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

"=== Tabs ===
" Create new tab
map <F10> :tabedit <cr>
" Go to next tab
map <F11> :tabn<cr>
" Go to previous tab
map <F12> :tabp<cr>

"=== Save file with Ctrl+s
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Paste Toggle
set pastetoggle=<f3>

" Arrowless window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" return to preovious window
nnoremap <tab> <c-w><c-p>

nmap <Down> gj
nmap <Up> gk

"========Plug-ins

"== vim-surround

let b:surround_104 = "[\"\r\"]"

"== rainbow_parentheses.vim

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

"== vim-hardtime
let g:hardtime_default_on = 1
let g:hard_time_timeout = 10000
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2

"== cntlp
nmap <space> :CtrlPBuffer<CR>
nmap <leader><space> :CtrlPMixed<CR>

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"== Nerdtree
let NERDTreeShowLineNumbers=1
nmap <silent><leader>f :NERDTreeToggle<CR>
""== Unite
"
"if executable('ag')
"
"  let g:unite_source_grep_command = 'ag'
"  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"  let g:unite_source_grep_recursive_opt = ''
"
"  "call unite#custom#source('file_rec/async', 'matchers', ['matcher_project_ignore_files', 'matcher_default'])
"  nmap <space> :<C-u>Unite -no-split -start-insert buffer file <CR>
"  nmap <leader><space> :<C-u>Unite -no-split -start-insert buffer file file_rec/async <CR>
"else
"  nmap <space> :<C-u>Unite -no-split -start-insert buffer file<CR>
"  nmap <leader><space> :<C-u>Unite -no-split -start-insert buffer file file_rec<CR>
"endif

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

"== taglist
" First check if ctags is installed
if executable('ctags')
  let Tlist_Ctags_Cmd = "/usr/bin/ctags"
  let Tlist_WinWidth = 50
  let Tlist_Use_Right_Window=1
  " Maps F4 to toggle the ctags widnow
  map <F4> :TlistToggle<cr>
  " Maps building tags to F10 for the current directory
  map <leader>0 :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
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

"Alternative Insert Mode exit
imap jj <Esc>
imap ii <Esc>

"Enable spell check and text with on git commits by default
autocmd Filetype gitcommit setlocal spell textwidth=72
"Enable spell check and text with on mediawiki files by default
autocmd Filetype mediawiki setlocal spell textwidth=72
autocmd Filetype markdown setlocal spell textwidth=90


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

if version >= 703
 highlight ColorColumn ctermbg=magenta
 call matchadd('ColorColumn', '\%81v', 100)
endif

" Better diff highlights
" From https://groups.google.com/forum/#!topic/vim_use/IERXsR4WVFk
highlight! link DiffText MatchParen

" Toggle line numbering relative and absolute
" Vim 7.4 doesn't turn line numbers on when disable relative lines
function! ToggleLineNumbering()
  set nu!
  if version > 703
    set rnu!
  endif
endfunction

" Toggle extra characters for copying with mouse
function! ToggleCopyMode()
  echom "functino called"
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
if version > 702
  "set relative line numbering On by default on vim 7.2 and up
  "
  "
  set rnu
  nmap <F2> :call ToggleCopyMode()<CR>
endif

:source ~/.vim/autocorrect.vim
