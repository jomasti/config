" plugin/plug-ale.vim

if !jms#IsPlugged('ale') | finish | endif

let g:ale_linters = {
      \ 'javascript': ['eslint', 'flow'],
      \ 'scss': ['stylelint'],
      \ 'python': ['flake8']
      \ }
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
