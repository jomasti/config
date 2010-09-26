colorscheme ir_black
set number
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
syntax on
set mouse=r
filetype on

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

