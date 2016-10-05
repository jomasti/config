" editorconfig.vim

if jms#IsPlugged('editorconfig-vim')
  let g:EditorConfig_exclude_patterns = [
    \ 'fugitive://.*', 
    \ 'scp://.*'
    \ ]

endif
