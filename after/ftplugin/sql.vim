" npm i -g sql-formatter
if executable('sql-formatter')
    setlocal formatprg=sql-formatter\ -i\ 4
    command -buffer Format :%!sql-formatter -i 4
endif

let &l:commentstring = "-- %s"



"" operator mapping
xnoremap <buffer> <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <buffer> <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <buffer> <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <buffer> <space><space>e  <Plug>(DBExe)
nmap <buffer> <space><space>e  <Plug>(DBExe)
omap <buffer> <space><space>e  <Plug>(DBExe)
nmap <buffer> <space><space>ee <Plug>(DBExeLine)
