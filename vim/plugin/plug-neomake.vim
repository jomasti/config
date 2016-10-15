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
let g:neomake_python_enabled_makers = ['pep8', 'pylint', 'flake8']

" ============================================================================
" Define makers
" ============================================================================

" For using local NPM based makers (e.g. eslint):
" Resolve the maker's exe relative to the project of the file in buffer, as
" opposed to using the result of `system('npm bin')` since that executes
" relative to vim's working path (and gives a fake result of not in a node
" project). Lotta people doin` it wrong ಠ_ಠ

" @param dict settings
" @param string [settings.when]       eval()'d, add local maker only if true
" @param string settings.ft           filetype for the maker
" @param string settings.maker        maker's name
" @param string [settings.exe]        alternate exe path to use in the buffer
" @param string [settings.is_enabled] default true, auto-enable when defined
function! s:AddLocalMaker(settings) abort
  " We eval this so it runs with the buffer context
  if has_key(a:settings, 'when') && !eval(a:settings['when'])
    return
  endif

  " Override maker's exe for this buffer?
  let l:exe = jmsproject#GetFile(a:settings['exe'])
  if !empty(l:exe) && executable(l:exe)
    let b:neomake_{a:settings['ft']}_{a:settings['maker']}_exe = l:exe
  endif

  " Automatically enable the maker for this buffer?
  let l:is_enabled = get(a:settings, 'is_enabled', 1)
  if l:is_enabled && jms#IsMakerExecutable(a:settings['maker'])
    call add(
          \ jms#InitList('b:neomake_' . a:settings['ft'] . '_enabled_makers'),
          \ a:settings['maker'])
  endif
endfunction

" ----------------------------------------------------------------------------
" JavaScript
" ----------------------------------------------------------------------------

" Sets b:neomake_javascript_enabled_makers based on what is present in the
" project
function! s:PickJavascriptMakers() abort
  " Enable ternlint if there's a .tern-project -- can just use the global
  " tern-lint
  if jms#IsMakerExecutable('ternlint')
        \ && !empty(jmsproject#GetFile('.tern-project'))
    call add(
          \ jms#InitList('b:neomake_javascript_enabled_makers'),
          \ 'ternlint')
  endif

  " This project uses jshint instead of eslint, disable eslint
  if exists('b:neomake_javascript_enabled_makers')
        \ && jms#IsMakerExecutable('jshint')
        \ && !empty(jmsproject#GetFile('.jshintrc'))
    " Remove eslint from enabled makers, use only jshint
    let b:neomake_javascript_enabled_makers = filter(
          \   b:neomake_javascript_enabled_makers,
          \   "v:val !~? 'eslint'"
          \ )
  endif
endfunction

let s:local_eslint = {
      \   'ft':    'javascript',
      \   'maker': 'eslint',
      \   'exe':   'node_modules/.bin/eslint',
      \   'when':  '!empty(jmsproject#GetEslintrc())'
      \ }

autocmd jmsneomake FileType javascript
      \ call s:AddLocalMaker(s:local_eslint)

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
