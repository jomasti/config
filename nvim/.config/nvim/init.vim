" vim-plug
call plug#begin('~/.config/nvim/plugged')

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

" Movement/Text manipulation
Plug 'justinmk/vim-sneak'
Plug 'christoomey/vim-sort-motion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

" Autocomplete/Syntax Checking
Plug 'benekastah/neomake'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
Plug 'jiangmiao/auto-pairs'

" Alignment/formatting
Plug 'Chiel92/vim-autoformat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig'

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'justinj/vim-react-snippets', { 'for': 'javascript' }

" File finding/navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-vinegar'
Plug 'mhinz/vim-grepper'

" External integration
Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim'
Plug 'christoomey/vim-system-copy'
Plug 'airblade/vim-gitgutter'

" Status information
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

" Session Management
Plug 'mhinz/vim-startify'

" Colorscheme
Plug 'morhetz/gruvbox'

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'


call plug#end()

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
let mapleader = " "
set backupcopy=yes

" backup
set backup
set undofile
set noswapfile
set undodir=$HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup
set backupskip=/tmp/*,/private/tmp/*
set writebackup

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

" auto remove whitespace
autocmd BufWritePre * StripWhitespace

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" enable powerline fonts
let g:airline_powerline_fonts = 1

" ctrlp
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

" YouCompleteMe and Ultisnips compatibility
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"neomake
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2

" Grepper
nnoremap <leader>git :Grepper -tool git -noswitch<cr>
nnoremap <leader>ag :Grepper -tool ag -grepprg ag --vimgrep<cr>
