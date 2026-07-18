vim9script

if exists('g:loaded_align')
    finish
endif
g:loaded_align = 1

import autoload 'align.vim'

nnoremap <silent> <expr> <Plug>(align-before) align.Op()
xnoremap <silent> <expr> <Plug>(align-before) align.Op()
nnoremap <silent> <expr> <Plug>(align-after) align.Op(1)
xnoremap <silent> <expr> <Plug>(align-after) align.Op(1)
nnoremap <silent> <expr> <Plug>(align-before-around) align.Op() .. 'l'
nnoremap <silent> <expr> <Plug>(align-after-around) align.Op(1) .. 'l'

if get(g:, 'align_mappings', true)
    nmap gl <Plug>(align-before)
    xmap gl <Plug>(align-before)
    nmap gll <Plug>(align-before-around)
    nmap gL <Plug>(align-after)
    xmap gL <Plug>(align-after)
    nmap gLL <Plug>(align-after-around)
endif
