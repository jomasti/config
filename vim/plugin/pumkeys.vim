" plugin/pumkeys.vim

function! s:jms_tab()
  " Autocompletion
  if pumvisible()
    return "\<C-n>"
  endif

  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  return "\<Tab>"
endfunction

function! s:jms_stab()
  return pumvisible() ? "<\C-p>" : "\<C-d>"
endfunction

" deoplete tab-complete
imap <expr> <Tab> <SID>jms_tab()
imap <expr> <S-Tab> <SID>jms_stab()
