autocmd BufNewFile,BufRead *.txt,*.rest if &buftype != "help" | set ft=rst | endif
