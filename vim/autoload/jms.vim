let g:jms#vim_dir = fnamemodify(resolve(expand('$MYVIMRC')), ':p:h')

" Output &runtimepath, one per line, to current buffer
function! jms#Runtimepath() abort
  put! =split(&runtimepath, ',', 0)
endfunction

" Declare and define var as new dict if the variable has not been used before
"
" @param string var
" @return the declared var
function! jms#InitDict(var) abort
  let {a:var} = exists(a:var) ? {a:var} : {}
  return {a:var}
endfunction

" Declare and define var as new list if the variable has not been used before
"
" @param string var
" @return the declared var
function! jms#InitList(var) abort
  let {a:var} = exists(a:var) ? {a:var} : []
  return {a:var}
endfunction

" ============================================================================
" vim-plug helpers
" ============================================================================

" Memory cache
let s:plugged = {}

" @param string name
" @return boolean true if the plugin is installed
function! jms#IsPlugged(name) abort
  if has_key(s:plugged, a:name)
    return s:plugged[a:name]
  endif

  " Use exists instead of has_key so can skip checking if g:plugs itself
  " exists
  let l:is_plugged = exists("g:plugs['" . a:name . "']")
        \ && isdirectory(expand(g:plug_home . '/' . a:name))

  let s:plugged[a:name] = l:is_plugged

  return l:is_plugged
endfunction
