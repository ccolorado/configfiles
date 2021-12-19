"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|
"

" Platform Setup {{{

  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
  let custom_system_type = join(readfile(glob('~/.custom_system_type')))

  Bundle 'gmarik/vundle'

  " TODO: try https://github.com/ncm2/ncm2
  " TODO: try deoplete"
  if custom_system_type == "full"
    Bundle "junegunn/fzf.vim"
    Bundle 'pedrosans/vim-notes'
    if v:version > 8
    endif
  endif

  if custom_system_type == "vm"
    Bundle 'kien/ctrlp.vim'
  endif

" }}}

" Plugins Instalation {{{

" Tools and Features {{{

  " Bundle 'joonty/vdebug'
  " Bundle 'tomlion/vim-solidity'
  " Bundle 'ycm-core/YouCompleteMe'
  " Check code linter https://github.com/maralla/validator.vim
  " Favor tomlion vim-solidity ( check if integration with testing and linter)

  Bundle "HP4k1h5/ephemeris"
  Bundle "TovarishFin/vim-solidity"
  Bundle "dmdque/solidity.vim"
  Bundle "isRuslan/vim-es6"
  Bundle "jamessan/vim-gnupg"
  Bundle "mattn/calendar-vim"
  Bundle "moll/vim-node"
  Bundle "neoclide/coc.nvim"
  Bundle 'AndrewRadev/linediff.vim'
  Bundle 'RRethy/vim-illuminate'
  Bundle 'SirVer/ultisnips'
  Bundle 'Xuyuanp/nerdtree-git-plugin'
  Bundle 'airblade/vim-gitgutter'
  Bundle 'bling/vim-airline.git'
  Bundle 'kamykn/spelunker.vim'
  Bundle 'chrisbra/NrrwRgn'
  Bundle 'diepm/vim-rest-console'
  Bundle 'editorconfig/editorconfig-vim'
  Bundle 'elixir-lang/vim-elixir'
  Bundle 'honza/vim-snippets'
  Bundle 'janko/vim-test'
  Bundle 'junegunn/goyo.vim'
  Bundle 'junegunn/vim-easy-align'
  Bundle 'masukomi/vim-markdown-folding'
  Bundle 'mattn/emmet-vim'
  Bundle 'pedrosans/vim-misc'
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
  Bundle 'vim-scripts/tar.vim'
  Bundle 'w0rp/ale'
  Bundle 'wesQ3/vim-windowswap'
  Plugin 'hashivim/vim-terraform'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'vimwiki/vimwiki'

" }}}

" Syntax Support {{{

  Bundle 'JulesWang/css.vim'
  Bundle 'StanAngeloff/php.vim'
  Bundle 'ap/vim-css-color'
  Bundle 'jelera/vim-javascript-syntax.git'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'leshill/vim-json'
  Bundle 'mitsuhiko/vim-python-combined'
  Bundle 'othree/html5.vim'
  Bundle 'pangloss/vim-javascript'
  Bundle 'rodjek/vim-puppet'
  Bundle 'ruanyl/vim-blade'
  Bundle 'shawncplus/phpcomplete.vim'
  Bundle 'tpope/vim-haml'
  Bundle 'tpope/vim-markdown'
  Bundle 'tpope/vim-rails.git'
  Bundle 'vim-ruby/vim-ruby'
  Plugin 'mxw/vim-jsx'

" }}}


" Build Instructctions {{{

  " neoclide/coc.nvim"
  " cd ~/.vim/bundle/coc.nvim;
  " yarn install && yarn build

" }}}


" Apearance {{{
  Bundle 'joshdick/onedark.vim'
  Bundle 'arcticicestudio/nord-vim'
" }}}


"
" Plugins to checkout {{{

" Checkout these plugins sometime in the future
" 'sotte/presenting.vim'
" https://vimawesome.com/plugin/obsession-vim
" https://vimawesome.com/plugin/session-vim
" https://vimawesome.com/plugin/vim-workspace

" }}}

" }}}

" TODO's {{{

  "   SOLVED: Highlight ONLY the word under cursor WITHOUT jumping to the next occurence the first time

  " TODO: create function to togggle spell highlighting
  " http://stackoverflow.com/questions/22180623/spell-check-word-under-cursor-in-vim

  " * Spell check word under cursor without adding spellcheck to the said file

  " this mapping Enter key to <C-y> to chose the current highlight item
  " and close the selection list, same as other IDEs.
  " CONFLICT with some plugins like tpope/Endwise
  " inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" }}}

" Bundle Requirements {{{
  filetype plugin indent on     " required
" }}}

" General Settings{{{

  if has("syntax")
      syntax on
  endif

  if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
  endif

  if filereadable("~/.vim/autocorrect.vim")
    :source ~/.vim/autocorrect.vim
  endif

  " look and feel {{{

    set background=dark
    colorscheme molokai-transparent
    " colorscheme nord
    highlight! link DiffText MatchParen
    :hi Normal ctermbg=NONE
    :hi Visual term=reverse cterm=reverse guibg=Grey

    if v:version > 702
     highlight ColorColumn ctermbg=darkgrey
     call matchadd('ColorColumn', '\%81v', 100)
    endif

    "Don't highlist current line past line 255
    "Stolen from https://github.com/wincent/wincent
    if exists('+colorcolumn')
      let &l:colorcolumn='+' . join(range(0, 254), ',+')
    endif

  " }}}

  " Variable Settings {{{

    set autoread
    set hidden " Leave hidden buffers open
    set history=100 " override default 8 last commands to remember
    set lazyredraw " Don't redraw while executing macros
    set nocursorline " Don't Highlight the screen line of the cursor with CursorLine
    " set nowrap " No wrapping text by default
    set showcmd " display incomplete commands
    set showmatch " Show matching brackets when text indicator is over them
    set splitbelow " Do vertical splits to DOWN instead of UP
    set splitright " Do horizontal splits to the RIGH instead of LEFT
    set ssop=blank,buffers,curdir,folds,resize,tabpages,winsize,winpos
    scriptencoding utf-8
    set termencoding=utf-8
    set encoding=utf-8
    set backspace=indent,eol,start
    set nostartofline " Don't move cursor to begining of line when switching buffers
    " show the cursor position all the time
    " set ruler
    set wildmode=longest,list,full " tab completion for comands and hopefully filenames
    set wildmenu
    set autoindent

    set nu
    if v:version > 702
      set rnu
    endif

    " Display characters for indetation, eol, and trailing whitespace
    exec "set listchars=tab:\uB7\uB7,trail:\uBB,nbsp:~"
    set list

    hi CursorLine   cterm=NONE ctermbg=240 ctermfg=black guibg=darkred guifg=white
    hi CursorColumn cterm=NONE ctermbg=240 ctermfg=white guibg=darkred guifg=white

  " }}}


  " Folding {{{

    nnoremap <Tab> za
    set foldlevel=9999
    set foldenable
    set foldlevelstart=1
    set foldnestmax=10
    set foldmethod=syntax

  " }}}

  "" Backup, history and Restoring {{{

    " Create directory if doesn't exists
    silent execute '!mkdir -p $HOME/.vim/tmp/{backup,swap,view,undo}'
    set dir=./.backup,~/.vim/backup_files,/tmp
    set backupdir=$HOME/.vim/tmp/backup/
    set backup
    set directory=$HOME/.vim/tmp/swap/
    set viewdir=$HOME/.vim/tmp/view/
    set viminfo='50,n$HOME/.vim/tmp/viminfo
    " store undo files, undo edits after deleting a buffer
    "set undodir=$HOME/.vim/tmp/undo/
    "set undofile
    set scrolloff=5

    " Search {{{
      set incsearch " do incremental searching
      set ignorecase
      set smartcase
      set hlsearch
    " }}}

    " Indentation {{{
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
    " }}}

  " }}}

  " Leader + Remaps {{{

    let mapleader = ","
    let g:mapleader = ","

    nnoremap <silent> n n:call HLNext(0.4)<cr>
    nnoremap <silent> N N:call HLNext(0.4)<cr>

    " Center cursor Vertically
    nmap <leader>zz :set scrolloff=999<CR>
    nmap <leader>d :DiffSaved <CR>


  "}}}

" Custom Functions {{{

  " Search options
  " Blinks underscore of search result
  function! HLNext (blinktime)
    set invcursorline
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 250) . 'm'
    set invcursorline
    redraw
  endfunction

  function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  endfunction

  function! ToggleCopyMode()
    echo "function called"
    call ToggleLineNumbering()
    if &number
      set list
      " set wrap
      :GitGutterEnable
    else
      set nolist
      " set nowrap
      :GitGutterDisable
    endif
  endfunction

  " Toggle line numbering relative and absolute
  " Vim 7.4 doesn't turn line numbers on when disable relative lines
  function! ToggleLineNumbering()
    set nu!
    if v:version > 703
      set rnu!
    endif
  endfunction

  " Show vimdiff of unsaved changes
  com! DiffSaved call s:DiffWithSaved()

  autocmd VimResized * :wincmd =

" }}}

" }}}

" Mappings {{{

  "Alternative Insert Mode exit
  imap jj <Esc>

  " save as root
  cmap w!! w !sudo tee >/dev/null %

  " Save with Ctrl+s
  map <C-s> <esc>:w<CR>
  imap <C-s> <esc>:w<CR>

  " Clear search highlights
  nmap \q :nohlsearch<CR>
  " Search visually selected text
  vnoremap // y/<C-R>"<CR>

  " Fat Finger {{{

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

      "Vertical splitting
      command! -nargs=? -complete=file Vsp vsp <args>

    endif

  " }}}

  " Movement {{{

    " == Tabs {{{
      nmap <leader>h :tabprevious<CR>
      nmap <leader>j :tab sp<CR>
      nmap <leader>k :tab new<CR>
      nmap <leader>l :tabnext<CR>
    " }}}

    " Disable arrow keys {{{

      " Approach to remap commonly mistaken keystrokes, usally by holding the shift key
      " for longer that it should.
      " taken from http://blog.sanctum.geek.nz/vim-command-typos/

      inoremap  <Up>     <NOP>
      inoremap  <Down>   <NOP>
      inoremap  <Left>   <NOP>
      inoremap  <Right>  <NOP>
      noremap   <Up>     <NOP>
      noremap   <Down>   <NOP>
      noremap   <Left>   <NOP>
      noremap   <Right>  <NOP>

    " }}}

    " Solit Navegation {{{
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
    " }}}

  " }}}

  " Indentation Switching{{{
    nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
    nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
    nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
    nmap \m :set noexpandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
  " }}}

  " Tool Mappings {{{

    " Leader mapping {{{
      " Reload vimrc
      map <leader>e :so $MYVIMRC <bar> call UltiSnips#RefreshSnippets() <CR> :checktime <CR>
    " }}}

    " Unit testing {{{
      map <leader>tr :Dispatch! tmux send-keys -t tester.0 "!!" C-m <CR>
      " TEST THIS FILE
      map <leader>tt :Dispatch! tmux send-keys -t tester.0 "clear; ttester ./%" C-m <CR>
      " map <leader>tt :Dispatch! tmux send-keys -t tester.0 "clear; truffle test --migrations_directory test ./%" C-m <CR>
      " COMPILE AND TEST THIS FILE
      " map <leader>tct :Dispatch! tmux send-keys -t tester.0 " clear; truffle test ./% --compile-all" C-m <CR>
      map <leader>tct :Dispatch! tmux send-keys -t tester.0 "truffle compile --all && clear && truffle test ./%" C-m <CR>

      map <leader>tm :Dispatch! tmux send-keys -t tester.0 "clear; truffle migrate --reset" C-m <CR>

      " TEST ALL FILES
      map <leader>ta :Dispatch! tmux send-keys -t tester.0 "clear; truffle test" C-m <CR>
      " COMPILE AND TEST ALL FILES
      " map <leader>tca :Dispatch! tmux send-keys -t tester.0 "clear; MIGRATE=false truffle test --compile-all" C-m <CR>
      map <leader>tca :Dispatch! tmux send-keys -t tester.0 " truffle compile --all && clear && truffle test" C-m <CR>

      " COMPILE THIS
      map <leader>ct :Dispatch! tmux send-keys -t tester.0 " truffle compile --all ./%" C-m <CR>
      " COMPILE ALL
      map <leader>ca :Dispatch! tmux send-keys -t tester.0 " truffle compile --all " C-m <CR>

      " Traverse the buffer list comparing against development branch
      nnoremap <leader>X :w<CR>:Gwrite<CR>:q<CR>:next<CR>:Gdiff development<CR>

      map <leader>g :Dispatch! tmux send-keys -t tester.0 "clear; npm run dist" C-m <CR>

      nnoremap <Leader>c :set cursorline!<CR> :set cursorcolumn! <CR>

      map <leader>w :call append(line('.')-1, "console.log('>>> ".@%.":' + ".line('.').')') <CR>
      map <leader>q :call append(line('.')-1, "process.exit(".line('.').")") <CR>

      " open file under cursor on new vertical split
      :nnoremap gf] <C-W>vgf

      " open file under cursor on new horizontal split
      :nnoremap gf[ <C-W><C-f>

      nmap <F2> :call ToggleCopyMode()<CR>
    " }}}

  " }}}

" }}}

" Plugin Settings {{{


  " HP4k1h5/ephemeris {{{
    let g:calendar_diary = "~/scrums"
    nmap <leader>eci :EphemerisCreateIndex<CR>
    nmap <leader>egi :EphemerisGotoIndex<CR>
    nmap <leader>ect :EphemerisCopyTodos<CR>
    nmap <leader>eft :EphemerisFilterTasks<CR>
    nmap <leader>et  :EphemerisToggleTask<CR>
    " keeps index properly sized
    au BufEnter g:calendar_diary :vertical resize 38
  " }}}

  " neoclide/coc.nvim {{{
    " To install = cd .vim/bundle/coc.nvim && yarn install
  " }}}
  "
  " UltiSnips {{{
    set runtimepath+=~/.vim/custom_snippets
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    let g:UltiSnipsListSnippets="<C-e>"
    " let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/.vim/custom_snippets/"]
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/custom_snippets']

    let g:UltiSnipsEditSplit="context"

    " Prevent UltiSnips from removing our carefully-crafted mappings.
    let g:UltiSnipsMappingsToIgnore = ['autocomplete']
  " }}}

  " YouCompleteMe {{{
  " taken from Greg Hurrell's video [ https://www.youtube.com/watch?v=WeppptWfV-0 ]
  " https://github.com/wincent/wincent/blob/9b938b4d879a2/roles/dotfiles/files/.vim/plugin/autocomplete.vim

    let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
    let g:ycm_key_list_accept_completion = ['<C-y>']

    " Additional YouCompleteMe config.
    let g:ycm_complete_in_comments = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_seed_identifiers_with_syntax = 1

    " Disable unhelpful semantic completions.
    let g:ycm_filetype_specific_completion_to_disable = {
          \   'c': 1,
          \   'gitcommit': 1,
          \   'haskell': 1,
          \   'javascript': 1,
          \   'ruby': 1
          \ }

    let g:ycm_semantic_triggers = {
          \   'haskell': [
          \     '.',
          \     '(',
          \     ',',
          \     ', '
          \   ]
          \ }

    " Same as default, but with "markdown" and "text" removed.
    let g:ycm_filetype_blacklist = {
          \   'notes': 1,
          \   'unite': 1,
          \   'tagbar': 1,
          \   'pandoc': 1,
          \   'qf': 1,
          \   'vimwiki': 1,
          \   'infolog': 1,
          \   'mail': 1
          \ }

  " }}}

  " vim-surround {{{

    " surround hash key [""] 'H'
    let g:surround_72 = "[\"\r\"]"

    " surround ruby string interpolation #{} 'r'
    let g:surround_115 = "\#{\r}"

    " surround terraform string interpolation ${} 'T'
    " t is for html tags so ... sorry, SOL
    let g:surround_84= "\${\r}"

    " surround with [''] 'h'
    let g:surround_104 = "['\r']"

    " surround with ${''} 'j' javascript
    let g:surround_106 = "${\r}"

    " surround with mustaches {{}} 'm'
    let g:surround_109 = "{{ \r }}"

    " surround selection with console log consolelog(); 'c'
    let g:surround_99 = "console.log(\r)"

  " }}}

  " vim-syntastic {{{

    " set statusline+=%#warningmsg#
    " set statusline+=%{SyntasticStatuslineFlag()}
    " set statusline+=%*

    " let g:syntastic_always_populate_loc_list = 1
    " let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_open = 1
    " let g:syntastic_check_on_wq = 0

  " }}}

  " vim-gitgutter {{{
    " Force focus detection on focus
    let g:gitgutter_terminal_reports_focus=0

    " Force sign colors
    let g:gitgutter_override_sign_column_highlight = 0
    highlight GitGutterAdd ctermfg=green
    highlight GitGutterDelete ctermfg=red
    highlight GitGutterChange ctermfg=brown

    " Force diffs to run asynchronously.
    let g:gitgutter_async = 1

    " hunk motions
    nmap ]h <Plug>(GitGutterNextHunk)
    nmap [h <Plug>(GitGutterPrevHunk)

    " Customize keystrokes, hunk {add, remove, preview}
    "
    nmap <Leader>ha <Plug>(GitGutterStageHunk)
    nmap <Leader>hr <Plug>(GitGutterUndoHunk)
    nmap <Leader>hv <Plug>(GitGutterPreviewHunk)

  " }}}

  " gundo.vim {{{
    nnoremap <leader>u :GundoToggle<CR>
  " }}}

  "vim-php-cs-fixer {{{
    let g:php_cs_fixer_enable_default_mapping = 0
    let g:php_cs_fixer_level = "symfony"
    let g:php_cs_fixer_config = "default"
    let g:php_cs_fixer_rules = "@PSR2"
    nnoremap <silent><leader>p :call PhpCsFixerFixFile()<CR>
    nnoremap <silent><leader>P :call PhpCsFixerFixDirectory()<CR>
  " }}}

  " easy-align {{{
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  " }}}

  "== Nerdtree {{{
  let NERDTreeShowLineNumbers=1
  let NERDTreeQuitOnOpen = 1
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  let NERDTreeShowHidden = 1

  " nmap <silent><.eader>f :NERDTreeToggle<CR> && :NERDTreeFind<CR>
  nmap <silent><leader>f :NERDTreeToggle<CR>
  " }}}

if custom_system_type == "full"

  "== fzf.vim {{{

      " Resizes the preview window to 40 right
      " Hides the preview window by default
      " Toggles visibility of preview window with ctrl+/
      let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
      " map <leader><space>:Files<CR>
      nmap <leader><space> :Buffers<CR>
      nmap <space> :GFiles<CR>
  " }}}

  ""== denite.vim {{{

  "  autocmd FileType denite call s:denite_my_settings()
  "  function! s:denite_my_settings() abort
  "    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  "    nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  "    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  "    nnoremap <silent><buffer><expr> q denite#do_map('quit')
  "    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  "    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  "  endfunction

  "  if executable('ag')
  "      call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup',
  "            \'--ignore-dir', 'node_modules',
  "            \'--ignore-dir', 'vendor',
  "            \'--ignore-dir', 'docs',
  "            \'--ignore-dir', 'staticContracts',
  "            \'-g', ''])
  "    endif

  "    call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
  "            \   [ '.git/', 'node_modules/*', 'vendor/', 'build/', 'staticContracts/' ]
  "            \ )

  "    nmap <leader><space> :Denite -start-filter file/rec buffer<CR>
  "    nmap <space> :Denite -start-filter buffer<CR>

    else

      ""== cntlp
      nmap <leader><space> :CtrlPBuffer<CR>
      nmap <leader> :CtrlPMixed<CR>
      let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

    endif

  " }}}

  "== airline {{{
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
    let g:airline#extensions#branch#symbol = '⎇'
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

    " }}}

    "== vim-notes {{{
      if custom_system_type == "full"
        let g:notes_directories = ['~/Notes']
        nnoremap <leader>nc :vsp<CR>:Note<Space>
        nnoremap <leader>ns :vsp<CR>:SearchNotes<Space>
      endif
    " }}}

    "== taglist {{{
      " First check if ctags is installed
      if executable('ctags')
        let Tlist_Ctags_Cmd = "/usr/bin/ctags"
        let Tlist_WinWidth = 50
        let Tlist_Use_Right_Window=1
        " Maps F4 to toggle the ctags widnow
        map <F4> :TlistToggle<cr>
        " Maps building tags to F10 for the current directory
        " map <leader>0 :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
        map <leader>0 :Dispatch /usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extras=+q --exclude={*.phar,node_modules,vendor,docs,public,.branch_dir,*min.js,.brancher,.branch,build} .<CR>
        " Open tag file on vertical split and move it to the right split
        nmap <leader>]  :vsp <CR>:exec("tag ".expand("<cword>"))<CR>zz
        nmap <leader>[  :exec("tag ".expand("<cword>"))<CR>zz
      endif

    " }}}

    "Vdebug {{{

      " less intrusive, more readable highlighting
      highlight DbgBreakptLine ctermbg=none ctermfg=none
      highlight DbgBreakptSign ctermbg=none ctermfg=10

      "highlight DbgCurrentLine ctermbg=none ctermfg=none
      highlight DbgCurrentSign ctermbg=none ctermfg=red

    " }}}

    " w0rp/ale {{{
      " Supported linters
      " https://github.com/dense-analysis/ale/blob/master/supported-tools.md
      " let b:ale_linters = ['flake8', 'pylint', 'solc', 'solhint', 'eslint']
      let b:ale_linters = {'python': ['pyflakes'], 'javascript': ['xo'], 'solidity': ['solc', 'solhint' ]}
      " let b:ale_fixers = ['autopep8', 'yapf']
      let b:ale_fixers = {'python': ['black', 'isort'], 'javascript': ['xo']}
      let g:ale_javascript_xo_options = "--plug=react --prettier"
    " }}}

    " vim-test {{{

      let g:test#preserve_screen = 1
      let test#strategy = {
        \ 'nearest': 'dispatch_background',
        \ 'file':    'dispatch_background',
        \ 'suite':   'dispatch_background',
      \}

      let test#vim#term_position = "belowright"

      let test#project_root = "/home/ccolorado/Source/nobservices/nobblockchain"
      " let test#solidity#minitest#file_pattern = test\.js
      " let test#solidity#rspec#executable = 'foreman run rspec'

      " augroup test
      "   autocmd!
      "   autocmd BufWrite * if test#exists() |
      "     \   TestFile |
      "     \ endif
      " augroup END

      let test#custom_runners = {'Solidity': ['Truffle']}
      let test#enabled_runners = ["solidity#truffle"]

    " }}}

    " vim-terraform {{{
      let g:terraform_align=1
      let g:terraform_fold_sections=1
      let g:terraform_fmt_on_save=1
    " }}}

    " wesQ3/vim-windowswap {{{
      let g:windowswap_map_keys = 0 "prevent default bindings
      nnoremap <silent> <leader>ss :call WindowSwap#EasyWindowSwap()<CR>
    " }}}

" }}}

"" Folding instruction do not remove
" vim:foldmethod=marker:foldlevel=0

:hi ColorColumn ctermbg=0

" augroup BgHighlight
"   autocmd!
"   autocmd WinEnter * set cul
"   autocmd WinLeave * set nocul
" augroup END

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

