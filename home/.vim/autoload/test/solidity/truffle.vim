if !exists('g:test#solidity#truffle#file_pattern')
  let g:test#solidity#truffle#file_pattern = '\vtest.*\.(sol|js)$'
endif

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

