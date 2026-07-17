vim9script

if exists('g:loaded_align')
    finish
endif
g:loaded_align = 1

import autoload 'align.vim'

nnoremap <silent> <expr> <Plug>(align) align.Op()
xnoremap <silent> <expr> <Plug>(align) align.Op()
nnoremap <silent> <expr> <Plug>(align-after) align.Op(1)
xnoremap <silent> <expr> <Plug>(align-after) align.Op(1)
nnoremap <silent> <expr> <Plug>(align-around) align.Op() .. 'l'
nnoremap <silent> <expr> <Plug>(align-around-after) align.Op(1) .. 'l'

if get(g:, 'align_mappings', true)
    nmap gl <Plug>(align)
    xmap gl <Plug>(align)
    nmap gll <Plug>(align-around)
    nmap gL <Plug>(align-after)
    xmap gL <Plug>(align-after)
    nmap gLL <Plug>(align-around-after)

    # nmap <space>a <Plug>(align)
    # xmap <space>a <Plug>(align)
    # nmap <space>aa <Plug>(align-around)

endif
