" plugin/plugneomake.vim

if !jms#IsPlugged('neomake') | finish | endif

augroup jmsneomake
  autocmd!
augroup end

autocmd jmsneomake VimLeave * let g:neomake_verbose = 0

let g:neomake_open_list = 2
let g:neomake_error_sign = {'text': '⨉'}
let g:neomake_warning_sign = {'text': '⚠'}
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ['pep8', 'pylint']

" ============================================================================
" Should we :Neomake?
" ============================================================================

function! s:MaybeNeomake() abort
  " Not a real file
  if &buftype ==# 'nofile' | return | endif

  " File was never written
  if empty(glob(expand('%'))) | return | endif

  Neomake
endfunction

autocmd jmsneomake  BufWritePost,FileChangedShellPost
  \ *
  \ call s:MaybeNeomake()
