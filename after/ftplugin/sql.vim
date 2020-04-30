" Install sqlparse first
" `pip install --upgrade sqlparse`
" Now you can gggqG to reformat current sql buffer
if executable('sqlformat')
    setlocal formatprg=sqlformat\ -s\ -a\ --keywords\ upper\ --wrap_after\ 120\ -
endif

" setlocal commentstring=--\ %s
let &l:commentstring = "-- %s"



"" operator mapping
xnoremap <buffer> <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <buffer> <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <buffer> <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <buffer> <leader>m  <Plug>(DBExe)
nmap <buffer> <leader>m  <Plug>(DBExe)
omap <buffer> <leader>m  <Plug>(DBExe)
nmap <buffer> <leader>mm <Plug>(DBExeLine)
