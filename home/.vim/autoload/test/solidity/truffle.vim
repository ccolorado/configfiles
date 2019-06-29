
" if !exists('g:test#solidity#truffle#file_pattern')
"   let g:test#solidity#truffle#file_pattern = '\.test\.js'
" endif

if !exists('g:test#solidity#truffle#file_pattern')
  let g:test#solidity#truffle#file_pattern = '\vtest.*\.(sol|js)$'
endif

" " Returns true if the given file belongs to your test runner
" function! test#solidity#truffle#test_file(file) abort
"   return a:file =~# g:test#solidity#truffle#file_pattern
" endfunction
" 
" " Returns test runner's arguments which will run the current file and/or line
" function! test#solidity#truffle#build_position(type, position) abort
"   if a:type ==# 'nearest'
"     let name = s:nearest_test(a:position)
"     if !empty(name)
"       let name = '--grep '.shellescape(name, 1)
"     endif
"     return [a:position['file'], name]
"   elseif a:type ==# 'file'
"     return [a:position['file']]
"   else
"     let test_dir = get(filter(['test/', 'tests/'], 'isdirectory(v:val)'), 0)
"     return ['--recursive', test_dir]
" endfunction
" 
" " Returns processed args (if you need to do any processing)
" function! test#solidity#truffle#build_args(args) abort
"   let args = a:args
" 
"   if test#base#no_colors()
"     let args = ['--no-colors'] + args
"     let args = args + ['|', 'sed -e "s///g"']
"   endif
" 
"   return args
" endfunction



" Returns true if the given file belongs to your test runner
function! test#solidity#truffle#test_file(file)
  return a:file =~# g:test#solidity#truffle#file_pattern
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#solidity#truffle#build_position(type, position)
  return [a:position['file']]
endfunction

" Returns processed args (if you need to do any processing)
function! test#solidity#truffle#build_args(args)
  return ['test'] + a:args
endfunction

" Returns the executable of your test runner
function! test#solidity#truffle#executable()
  return 'truffle'
endfunction

