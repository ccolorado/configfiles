"" [Vundle setup]
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline.git'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
"Bundle 'scrooloose/nerdtree.git'
Bundle 'Xuyuanp/git-nerdtree'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-ruby/vim-ruby.git'
Bundle 'jelera/vim-javascript-syntax.git'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround'

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
""" Use Vim settings, rather then Vi settings (much better!).
""" This must be first, because it changes other options as a side effect.
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
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

set smartindent
set autoindent

" sudo omission fix
cmap w!! w !sudo tee >/dev/null %

" Highlight empty white spaces at the right
"highlight WhiteSpaceEOL ctermbg=darkred guibg=lightred
"match WhiteSpaceEOL /\s\+$/
"   Testing new highlight for white spaces
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
" Reload vimrc
map <silent><leader>e :so $MYVIMRC<CR>

"========Plug-ins
set runtimepath^=~/.vim/bundle/ctrlp.vim

"========Custom Keystrokes

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
inoremap <c-s> <Esc>:update<CR>

"========Custom Keystrokes
" Paste Toggle
set pastetoggle=<f5>

" Arrow window navigation
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

nmap <Down> gj
nmap <Up> gk
"== Ctrl-P
" Initiate Ctrl-P
nmap <leader>; :CtrlPBuffer<CR>

"== NerdTree
" Initiate NerdTree
nmap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
let NERDTreeShowHidden=1
" AutoClose NerdTree after file is open
let NERDTreeQuitOnOpen = 1
" Ignore .svn directoies
let NERDTreeIgnore = ['\.svn$'] 
" Open Nerdtree on startup if no files where opened
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if Nerdtree is the only remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"== airline
"" FIXES The statusline is hidden/only appears in split windows!
set laststatus=2
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline#extensions#branch#symbol = '⭠'
let g:airline#extensions#readonly#symbol = '⭤'
let g:airline_linecolumn_prefix = '⭡'
let g:airline_theme = 'dark'

"== taglist
" First check if ctags is installed
if filereadable("/usr/bin/ctags")
  let Tlist_Ctags_Cmd = "/usr/bin/ctags"
  let Tlist_WinWidth = 50
  let Tlist_Use_Right_Window=1
  " Maps F4 to toggle the ctags widnow
  map <F4> :TlistToggle<cr>
  " Maps building tags to F10 for the current directory
  map <leader>0 :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
  " Open tag file on vertical split and move it to the right split
  nmap <leader>]  :vsp <CR>:exec("tag ".expand("<cword>"))<CR> <C-W>R<CR>
endif

"== Clear search highlights
nmap \q :nohlsearch<CR>
"== Switch to next buffer
nmap <C-e> :e#<CR>
"set ff=dos,unix Change file format to avoid ^M line breaks also
"replacing ^M's :%s/CTRL-v ENTER//g

" Show diff of unsaved changes
nmap <leader>d :w !diff % -<CR>

"Alternative Insert Mode exit
imap jj <Esc>
imap ii <Esc>

"Enable spell check and text with on git commits by default
autocmd Filetype gitcommit setlocal spell textwidth=72
"Enable spell check and text with on mediawiki files by default
autocmd Filetype mediawiki setlocal spell textwidth=72

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
      set t_Co=256
endif

set background=dark
colorscheme molokai-transparent

if version >= 703
 highlight ColorColumn ctermbg=magenta
 call matchadd('ColorColumn', '\%81v', 100)
endif

" From https://groups.google.com/forum/#!topic/vim_use/IERXsR4WVFk
" Fix the difficult-to-read default setting for diff text highlighting.  The
" bang (!) is required since we are overwriting the DiffText setting. The highlighting
" for "Todo" also looks nice (yellow) if you don't like the "MatchParen" colors.
highlight! link DiffText MatchParen

set nu
if version > 702
  "set relative line numbering On by default on vim 7.2 and up
  set rnu

  " Toggle between relative and 'absolute' line numbers
  " Vim 7.4 doesn't turn line numbers on when disable relative lines
  if version <= 703
    nmap <silent><F2> :exec &rnu==1? "se nu" : "se rnu"<CR>
  else
    nmap <silent><F2> :exec &rnu==1? "se rnu!" : "se rnu"<CR>
  endif

endif
