vim9script

import autoload 'popup.vim'

export def Map()
    nnoremap <silent><buffer> gd <cmd>LspDefinition<CR>
    nnoremap <silent><buffer> <C-w>i <scriptcmd>exe ":hor LspDefinition"<CR>
    if &filetype !=# 'vim'
        setl keywordprg=:LspHover
    endif
    setl tagfunc=lsp#TagFunc
    nnoremap <silent><buffer> <space>z <cmd>LspOutline<CR>
    nnoremap <silent><buffer> [i <cmd>LspReferences<CR>
    xmap <buffer> . <Plug>(lsp-selection-expand)
    xmap <buffer> , <Plug>(lsp-selection-shrink)
    nnoremap <buffer> g* <scriptcmd>exe $'LspSymbol {expand("<cword>")}'<cr>
enddef

export def Unmap()
    nunmap <buffer> gd
    nunmap <buffer> <C-w>i
    setl keywordprg<
    setl tagfunc<
    nunmap <buffer> <space>z
    nunmap <buffer> [i
    xunmap <buffer> .
    xunmap <buffer> ,
    nunmap <buffer> g*
enddef
