" ----------------------------------------------------------------------------
" file:     ~/.vimrc
" author:   Joshua Stiefer
" modified: December 2011
" vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=vimrc:
" ----------------------------------------------------------------------------

" Color related
set t_Co=16
colorscheme digerati

set nocompatible
set ruler
set showcmd
set number
set autoindent
set nocindent
set ts=2
set sw=2
set bs=2
set ch=1
set expandtab
set ignorecase
set smartcase
set incsearch
set showmode
set lazyredraw
set pastetoggle=<F3>

" Helpful directories
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

syntax on

" Filetype
if has("autocmd")
  filetype plugin on
  filetype indent off
endif

" disable autocomment
au FileType * setl fo-=cro

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
  colorscheme gvim/bubblegum
endif

"augroup vimrc
"	au BufReadPre * setlocal foldmethod=indent
"	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END

" JavaBrowser
let JavaBrowser_Ctags_Cmd = "/usr/bin/ctags"
if !has('gui_running')
	let JavaBrowser_Inc_Winwidth = 0
endif
nmap <F11> :JavaBrowser<CR>
imap <F11> <ESC><F11>

" use ghc functionality for haskell files
"au Bufenter *.hs compiler ghc

" configure browser for haskell_doc.vim
let g:haddock_browser = "/usr/bin/firefox"

" Project
let VCSCommandVCSTypeOverride=[["^/home/josh/cse360-treadmill", "HG"]]

" Maps
map <F2> <Esc>:browse confirm e<CR>
map <F3> <Esc>:NERDTreeToggle<CR>

" sudo write
ca w!! w !sudo tee >/dev/null "%"

" Nopaste
nnoremap <F12> :set invpaste paste?<CR>
imap <F12> <C-O><F12>
set pastetoggle=<F12>
