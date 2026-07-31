vim9script

import autoload "qc.vim"

export def SetupFT()
    setlocal keywordprg=:LspHover
    nnoremap <silent><buffer> gd <scriptcmd>LspGotoDefinition<CR>
    nnoremap <silent><buffer> <space>z <scriptcmd>LspDocumentSymbol<CR>
    xnoremap <silent><buffer> . <scriptcmd>LspSelectionExpand<CR>
    xnoremap <silent><buffer> , <scriptcmd>LspSelectionShrink<CR>
    nnoremap <silent><buffer> <space>l <scriptcmd>qc.LspCommands()<CR>
enddef

export def UnSetupFT()
    setlocal keywordprg&
    nunmap <buffer> gd
    xunmap <buffer> .
    xunmap <buffer> ,
    nunmap <buffer> <space>l
enddef
