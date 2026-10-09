vim9script

export def Map()
    nnoremap <silent><buffer> gd <cmd>LspDefinition<CR>
    nnoremap <buffer> g. <cmd>LspReferences<cr>
    nnoremap <silent><buffer> <C-w>i <scriptcmd>exe ":hor LspDefinition"<CR>
    if &filetype !=# 'vim'
        setl keywordprg=:LspHover
    endif
    setl tagfunc=lsp#TagFunc
    nnoremap <silent><buffer> <space>z <cmd>LspOutline<CR>
    xmap <buffer> . <Plug>(lsp-selection-expand)
    xmap <buffer> , <Plug>(lsp-selection-shrink)
    if &filetype != 'odin'
        augroup lsp_format
            au BufWritePre <buffer> LspFormat
        augroup END
    endif
enddef

export def Unmap()
    if &filetype != 'odin'
        augroup! lsp_format
    endif
    nunmap <buffer> gd
    nunmap <buffer> g.
    nunmap <buffer> <C-w>i
    setl keywordprg<
    setl tagfunc<
    nunmap <buffer> <space>z
    xunmap <buffer> .
    xunmap <buffer> ,
enddef
