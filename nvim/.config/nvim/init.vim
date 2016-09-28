if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.config/nvim/plugged')


" General settings {{{
set autoread
set number
set autoindent
set nocindent
set cmdheight=1
set ignorecase
set smartcase
set incsearch
set noshowmode
set ruler
set pastetoggle=<F3>
set backspace=indent,eol,start
set mouse=a
set cursorline
set laststatus=2
let mapleader = "\<Space>"
set backupcopy=yes
" }}}

" Backup settings {{{
set backup
set undofile
set noswapfile
set undodir=$HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup
set backupskip=/tmp/*,/private/tmp/*
set writebackup
" }}}

" Tab settings {{{
set expandtab
set shiftwidth=2
set softtabstop=2
" }}}

" Split settings {{{
" split traversal
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" split defaults
set splitbelow
set splitright
" }}}

" Clipboard settings {{{
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" }}}

" Formatting settings {{{
" disable auto comment
au FileType * setl fo-=cro

" auto remove whitespace
autocmd BufWritePre * StripWhitespace
" }}}

" Colorscheme {{{
Plug 'morhetz/gruvbox'
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='soft'
" }}}

" Syntax {{{
Plug 'othree/yajs.vim' | Plug 'othree/es.next.syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'PotatoesMaster/i3-vim-syntax'
" }}}

" Syntax checking {{{
Plug 'neomake/neomake'
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_error_sign = {'text': '⨉'}
let g:neomake_warning_sign = {'text': '◉⚠'}
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ['pep8', 'pylint']
" }}}

" Movement/Text manipulation {{{
Plug 'justinmk/vim-sneak'
Plug 'christoomey/vim-sort-motion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
" }}}

" Autocomplete {{{
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0
" }}}

" Alignment/formatting {{{
Plug 'Chiel92/vim-autoformat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig'
" }}}

" Snippets {{{
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

Plug 'justinj/vim-react-snippets', { 'for': 'javascript' }
" }}}

" File finding/navigation {{{
Plug 'ctrlpvim/ctrlp.vim'
" ctrlp
nnoremap <leader>e :CtrlP<cr>
nnoremap <leader>E :CtrlPCurFile<cr>
nnoremap <leader>t :CtrlPBufTag<cr>
nnoremap <leader>T :CtrlPTag<cr>
nnoremap <leader>a :CtrlPBuffer<cr>
nnoremap <leader>A :CtrlPMRUFiles<cr>

let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|node_modules/',
      \ }
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_show_hidden = 1
let g:ctlp_working_path_mode = 'ra'
let g:ctrlp_prompt_mappings = {
      \ 'PrtClearCache()': ['<F5>', '<c-i>'],
      \ }
let g:ctrlp_reuse_window = 'startify'

Plug 'FelikZ/ctrlp-py-matcher'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

Plug 'tpope/vim-vinegar'
Plug 'mhinz/vim-grepper'
nnoremap <leader>git :Grepper -tool git -noswitch<cr>
nnoremap <leader>ag :Grepper -tool ag -grepprg ag --vimgrep<cr>

Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_nvim_statusline=0

nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>. :Lines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction
" }}}

" External integration {{{
Plug 'christoomey/vim-system-copy'
Plug 'ludovicchabant/vim-gutentags'
" }}}

" Git {{{
Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim'
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR>

Plug 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0
nmap <leader>gg :GitGutterSignsToggle<CR>
" }}}

" Status line {{{
Plug 'itchyny/lightline.vim'
" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFugitive() abort
  if &filetype ==# 'help'
    return ''
  endif
  if has_key(b:, 'lightline_fugitive') && reltimestr(reltime(b:lightline_fugitive_)) =~# '^\s*0\.[0-5]'
    return b:lightline_fugitive
  endif
  try
    if exists('*fugitive#head')
      let head = fugitive#head()
    else
      return ''
    endif
    let b:lightline_fugitive = strlen(head) ? ' '.head : ''
    let b:lightline_fugitive_ = reltime()
    return b:lightline_fugitive
  catch
  endtry
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

Plug 'edkolev/tmuxline.vim'
" }}}

" Session Management {{{
Plug 'mhinz/vim-startify'
" }}}

" Text objects {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
" }}}

call plug#end()

colorscheme gruvbox

" vim:fdm=marker
