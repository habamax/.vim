vim9script

if exists('g:loaded_align')
    finish
endif
g:loaded_align = 1

import autoload 'align.vim'

nnoremap <silent> <expr> <Plug>(align) align.Op()
xnoremap <silent> <expr> <Plug>(align) align.Op()
nnoremap <silent> <expr> <Plug>(align-around) align.Op() .. '_'

if get(g:, 'align_mappings', true)
    nmap gl <Plug>(align)
    xmap gl <Plug>(align)
    nmap gll <Plug>(align-around)

    # nmap <space>a <Plug>(align)
    # xmap <space>a <Plug>(align)
    # nmap <space>aa <Plug>(align-around)

endif
