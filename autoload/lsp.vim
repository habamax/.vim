vim9script

export def SetupFT()
    setlocal noautocomplete
    setlocal keywordprg=:LspHover
    nnoremap <silent><buffer> gd <scriptcmd>LspGotoDefinition<CR>
    nnoremap <silent><buffer> <space>ld <scriptcmd>LspDiag current<CR>
    nnoremap <silent><buffer> <space>la <scriptcmd>LspCodeAction<CR>
    nnoremap <silent><buffer> <space>lr <scriptcmd>LspRename<CR>
    nnoremap <silent><buffer> <space>ls <scriptcmd>LspShowSignature<CR>
enddef
