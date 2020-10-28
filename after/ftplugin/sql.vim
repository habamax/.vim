" npm i -g sql-formatter-cli
if executable('sql-formatter-cli')
    setlocal formatprg=sql-formatter-cli
    command -buffer Format :%!sql-formatter-cli
endif

" setlocal commentstring=--\ %s
let &l:commentstring = "-- %s"



"" operator mapping
xnoremap <buffer> <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <buffer> <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <buffer> <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <buffer> <space><space>e  <Plug>(DBExe)
nmap <buffer> <space><space>e  <Plug>(DBExe)
omap <buffer> <space><space>e  <Plug>(DBExe)
nmap <buffer> <space><space>ee <Plug>(DBExeLine)
