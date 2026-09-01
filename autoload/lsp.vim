vim9script

import autoload 'popup.vim'

export def Map()
    nnoremap <silent><buffer> gd <cmd>LspDefinition<CR>
    nnoremap <silent><buffer> <C-w>i <scriptcmd>exe ":hor LspDefinition"<CR>
    nnoremap <silent><buffer> K <cmd>LspHover<CR>
    nnoremap <silent><buffer> <space>z <cmd>LspOutline<CR>
    nnoremap <silent><buffer> [i <cmd>LspReferences<CR>
    xmap <buffer> . <Plug>(lsp-selection-expand)
    xmap <buffer> , <Plug>(lsp-selection-shrink)
enddef

export def Unmap()
    nunmap <buffer> gd
    nunmap <buffer> <C-w>i
    nunmap <buffer> K
    nunmap <buffer> <space>z
    nunmap <buffer> [i
    xunmap <buffer> .
    xunmap <buffer> ,
enddef
