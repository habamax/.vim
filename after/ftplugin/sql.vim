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

xmap <buffer> <leader><leader>e  <Plug>(DBExe)
nmap <buffer> <leader><leader>e  <Plug>(DBExe)
omap <buffer> <leader><leader>e  <Plug>(DBExe)
nmap <buffer> <leader><leader>ee <Plug>(DBExeLine)
