vim9script

import autoload "qc.vim"

export def SetupFT()
    setlocal keywordprg=:LspHover
    nnoremap <silent><buffer> gd <scriptcmd>LspGotoDefinition<CR>
    nnoremap <silent><buffer> <space>z <scriptcmd>LspDocumentSymbol<CR>
    xnoremap <silent><buffer> . <scriptcmd>LspSelectionExpand<CR>
    xnoremap <silent><buffer> , <scriptcmd>LspSelectionShrink<CR>
    nnoremap <silent><buffer> <space>l <scriptcmd>qc.LspCommands()<CR>
    # nnoremap <silent><buffer> <space>ld <scriptcmd>LspDiag current<CR>
    # nnoremap <silent><buffer> <space>la <scriptcmd>LspCodeAction<CR>
    # nnoremap <silent><buffer> <space>lr <scriptcmd>LspShowReferences<CR>
    # nnoremap <silent><buffer> <space>lR <scriptcmd>LspRename<CR>
    # nnoremap <silent><buffer> <space>ls <scriptcmd>LspShowSignature<CR>
enddef
