" Color related
set t_Co=256
colorscheme ir_black

" Line numbers
set number

" Helpful directories
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Syntax highlighting
syntax on
filetype on

" Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

" Searching
set ignorecase
set smartcase
set incsearch

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

