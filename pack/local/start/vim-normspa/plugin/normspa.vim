vim9script

if exists('g:loaded_normspa')
    finish
endif
g:loaded_normspa = 1

import autoload 'normspa.vim'

nnoremap <silent> <expr> <Plug>(normspa) normspa.Op()
xnoremap <silent> <expr> <Plug>(normspa) normspa.Op()
nnoremap <silent> <expr> <Plug>(normspa-line) normspa.Op() .. '_'

if get(g:, 'normspa_mappings', true)
    nmap g<space>        <Plug>(normspa)
    xmap g<space>        <Plug>(normspa)
    nmap g<space><space> <Plug>(normspa-line)
endif
