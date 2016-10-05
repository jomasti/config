" plug/vim-better-whitespace

if !jms#IsPlugged('vim-better-whitespace') | finish | endif

autocmd BufWritePre * StripWhitespace
