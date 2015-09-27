set nocompatible
syntax on
colorscheme jellybeans

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'edkolev/tmuxline.vim'
Plugin 'marijnh/tern_for_vim'
Plugin 'moll/vim-node'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/DelimitMate'

" Mulitple language support
Plugin 'sheerun/vim-polyglot'

" Ultisnips engine
Plugin 'SirVer/ultisnips'

" Snippets
Plugin 'honza/vim-snippets'

" Supertab
Plugin 'ervandew/supertab'

" React snippets:
Plugin 'justinj/vim-react-snippets'

Plugin 'nanotech/jellybeans.vim'

" Auto format files
Plugin 'Chiel92/vim-autoformat'

" Hex color highlighting
Plugin 'gorodinskiy/vim-coloresque'

" silver searcher
Plugin 'rking/ag.vim'

" easymotion
Plugin 'easymotion/vim-easymotion'

" HAML/SASS/SCSS
Plugin 'cakebaker/scss-syntax.vim'

" Editorconfig
Plugin 'editorconfig/editorconfig'


call vundle#end()
filetype plugin indent on

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
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if nerdtree is the only buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" open nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

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
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

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
