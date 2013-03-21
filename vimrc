" ======================
" hacosta recepies https://github.com/hacosta/configfiles/blob/master/vimrc
" Maintainer:	Héctor Acosta <hector.acosta@gazzang.com>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Search options

set incsearch
set ignorecase
set smartcase
set hlsearch
set backspace=indent,eol,start
set autoread

set nu



" Reload file if changed externally && not modified in vim
set autoread

if has("syntax")
    syntax on
endif


filetype plugin indent on
"  Spaces TAB 
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" latex shinanningas

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

highlight WhiteSpaceEOL ctermbg=darkred guibg=lightred

" sudo omission fix
cmap w!! w !sudo tee >/dev/null %


" Find cursor:  Highlight current posstion
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"========Plug-ins
call pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp.vim

"========Custom Keystrokes 
"==Clear search highlights
nmap \q :nohlsearch<CR>
"==Open previous buffer
nmap <C-e> :e#<CR> 
"===Initiate Ctrl-P
nmap ; :CtrlPBuffer<CR>

"set ff=dos,unix Change file format to avoid ^M line breaks also 
"replacing ^M's :%s/CTRL-v ENTER//g
