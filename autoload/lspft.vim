vim9script

export def Setup()
    nnoremap <silent><buffer> gd <cmd>LspDefinition<CR>
    nnoremap <silent><buffer> gD <scriptcmd>exe ":hor LspDefinition"<CR>
    nnoremap <silent><buffer> K <cmd>LspHover<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gD"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'


    # nnoremap <silent><buffer> gd <cmd>LspGotoDefinition<CR>
    # nnoremap <silent><buffer> gD <scriptcmd>exe ":hor LspGotoDefinition"<CR>
    # nnoremap <silent><buffer> <C-]> <cmd>LspGotoDefinition<CR>
    # nnoremap <silent><buffer> <C-w><C-]> <cmd>exe ":hor LspGotoDefinition"<CR>
    # xnoremap <silent><buffer> . <cmd>LspSelectionExpand<CR>
    # xnoremap <silent><buffer> , <cmd>LspSelectionShrink<CR>
    # nnoremap <silent><buffer> <space>l <scriptcmd>qc.LspCommands()<CR>
    # nnoremap <silent><buffer> <space>z <scriptcmd>LspGoToSymbol()<CR>
    # nnoremap <silent><buffer> K <cmd>LspHover<CR>

    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> <C-]>"'
    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> <C-w><C-]>"'
    # b:undo_ftplugin ..= ' | exe "xunmap <buffer> ."'
    # b:undo_ftplugin ..= ' | exe "xunmap <buffer> ,"'
    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>l"'
    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> gq"'
    # b:undo_ftplugin ..= ' | exe "xunmap <buffer> gq"'
enddef
