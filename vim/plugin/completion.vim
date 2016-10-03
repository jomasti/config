" plugin/completion.vim
"

if !g:jms_has_completion | finish | endif

if jms#IsPlugged('deoplete.vim')
  let g:deoplete#enable_at_startup = 1
endif
