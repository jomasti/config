" vim-plug
call plug#begin('~/.vim/bundle')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --with-clang-completer' }
"Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
"Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'edkolev/tmuxline.vim'
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'moll/vim-node'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'Raimondi/DelimitMate'

Plug 'benekastah/neomake'

" Mulitple language support
Plug 'sheerun/vim-polyglot'

" Ultisnips/snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Supertab
Plug 'ervandew/supertab'

" React snippets:
Plug 'justinj/vim-react-snippets', { 'for': 'javascript' }

" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

" Auto format files
Plug 'Chiel92/vim-autoformat'

" Hex color highlighting
Plug 'gorodinskiy/vim-coloresque'

" silver searcher
Plug 'rking/ag.vim'

" easymotion
Plug 'easymotion/vim-easymotion'

" HAML/SASS/SCSS
Plug 'cakebaker/scss-syntax.vim', { 'for': ['haml', 'scss']}

" Editorconfig
Plug 'editorconfig/editorconfig'

" System clipboard
Plug 'christoomey/vim-system-copy'

" Commenting
Plug 'tpope/vim-commentary'

" Sorting via motions
Plug 'christoomey/vim-sort-motion'

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'

call plug#end()

set nocompatible
set t_Co=256
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox
let g:airline_theme='gruvbox'

" general
set autoread
set number
set autoindent
set nocindent
set cmdheight=1
set ignorecase
set smartcase
set incsearch
set showmode
set ruler
set pastetoggle=<F3>
set backspace=indent,eol,start
set mouse=a
set cursorline
set laststatus=2
set backupcopy=yes
let mapleader = " "

" directories
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/tmp//

" tab options
set expandtab
set shiftwidth=2
set softtabstop=2

"" SPLITS
" split traversal
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" split defaults
set splitbelow
set splitright

" disable auto comment
au FileType * setl fo-=cro

" NERDTree
" auto open nerdtree if vim is opened with no files
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if nerdtree is the only buffer open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" open nerdtree with ctrl+n
"map <C-n> :NERDTreeToggle<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" enable powerline fonts
let g:airline_powerline_fonts = 1

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|node_modules/',
  \ }
let g:ctrlp_show_hidden = 1

" YouCompleteMe and Ultisnips compatibility
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
