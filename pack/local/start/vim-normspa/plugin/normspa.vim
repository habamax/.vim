vim9script

if exists('g:loaded_normspa')
    finish
endif
g:loaded_normspa = 1

import autoload 'normspa.vim'

nnoremap <silent> <expr> <Plug>(normspa) normspa.Op()
xnoremap <silent> <expr> <Plug>(normspa) normspa.Op()
nnoremap <silent> <expr> <Plug>(normspa-line) normspa.Op() .. 'l'

if get(g:, 'normspa_mappings', true)
    nmap gs  <Plug>(normspa)
    xmap gs  <Plug>(normspa)
    nmap gss <Plug>(normspa-line)
endif
