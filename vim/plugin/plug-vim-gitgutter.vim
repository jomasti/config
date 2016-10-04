" plugin/plug-vim-gitgutter.vim
scriptencoding utf-8

if !jms#IsPlugged('vim-gitgutter') | finish | endif

" off until toggled on
let g:gitgutter_enabled = 0
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

nmap <leader>gg :GitGutterSignsToggle<CR>
