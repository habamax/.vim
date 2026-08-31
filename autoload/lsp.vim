vim9script

import autoload 'popup.vim'

export def Setup()
    nnoremap <silent><buffer> gd <cmd>LspDefinition<CR>
    nnoremap <silent><buffer> <C-w>i <scriptcmd>exe ":hor LspDefinition"<CR>
    nnoremap <silent><buffer> K <cmd>LspHover<CR>
    nnoremap <silent><buffer> <space>z <scriptcmd>Outline()<CR>
    nnoremap <silent><buffer> [i <cmd>LspReferences<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <C-w>i"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> [i"'

    # nnoremap <silent><buffer> gd <cmd>LspGotoDefinition<CR>
    # nnoremap <silent><buffer> gD <scriptcmd>exe ":hor LspGotoDefinition"<CR>
    # nnoremap <silent><buffer> <C-]> <cmd>LspGotoDefinition<CR>
    # nnoremap <silent><buffer> <C-w><C-]> <cmd>exe ":hor LspGotoDefinition"<CR>
    # xnoremap <silent><buffer> . <cmd>LspSelectionExpand<CR>
    # xnoremap <silent><buffer> , <cmd>LspSelectionShrink<CR>
    # nnoremap <silent><buffer> <space>l <scriptcmd>qc.LspCommands()<CR>
    # nnoremap <silent><buffer> K <cmd>LspHover<CR>

    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> <C-]>"'
    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> <C-w><C-]>"'
    # b:undo_ftplugin ..= ' | exe "xunmap <buffer> ."'
    # b:undo_ftplugin ..= ' | exe "xunmap <buffer> ,"'
    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>l"'
    # b:undo_ftplugin ..= ' | exe "nunmap <buffer> gq"'
    # b:undo_ftplugin ..= ' | exe "xunmap <buffer> gq"'
enddef

def GoToSymbol()
    var loc = getloclist(winnr())
    if empty(loc)
        return
    endif

    var items = loc->mapnew((_, v) => {
        var vt = v.text->split()
        return {
            lnum: v.lnum,
            col: v.col,
            bufnr: v.bufnr,
            pretext: vt[0] .. (empty(vt[0]) ? '' : ' '),
            text: vt[1],
            posttext: $' ({v.lnum})'}
    })

    popup.Select("LSP Symbols", items,
        (res, key) => {
            win_gotoid(bufwinid(res.bufnr))
            call setcursorcharpos(res.lnum, res.col)
            normal! zz
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectSymbolKind '^\\[.\\+\\]'")
            win_execute(winid, "syn match PopupSelectSymbolLine '\\s(\\d\\+)$'")
            hi def link PopupSelectSymbolKind Identifier
            hi def link PopupSelectSymbolLine Comment
        })
enddef

def Outline()
    LspOutline
    au Filetype qf ++once nnoremap <buffer><nowait> z <scriptcmd>GoToSymbol()<cr>
enddef
