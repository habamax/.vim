nmap <buffer> l <CR>
nmap <buffer> h -
if mapcheck('<C-l>', 'n') ==# '<Plug>NetrwRefresh'
    unmap <buffer> <C-l>
endif
