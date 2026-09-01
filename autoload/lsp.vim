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

# def GoToSymbol()
#     var loc = getloclist(winnr())
#     if empty(loc)
#         return
#     endif

#     var items = loc->mapnew((_, v) => {
#         var vt = v.text->split()
#         return {
#             lnum: v.lnum,
#             col: v.col,
#             bufnr: v.bufnr,
#             pretext: vt[0] .. (empty(vt[0]) ? '' : ' '),
#             text: vt[1],
#             posttext: $' ({v.lnum})'}
#     })

#     popup.Select("LSP Symbols", items,
#         (res, key) => {
#             win_gotoid(bufwinid(res.bufnr))
#             call setcursorcharpos(res.lnum, res.col)
#             normal! zz
#         },
#         (winid) => {
#             win_execute(winid, "syn match PopupSelectSymbolKind '^\\[.\\+\\]'")
#             win_execute(winid, "syn match PopupSelectSymbolLine '\\s(\\d\\+)$'")
#             hi def link PopupSelectSymbolKind Identifier
#             hi def link PopupSelectSymbolLine Comment
#         })
# enddef

# TODO create a more generic filtering of the quickfix/location lists
# au Filetype qf ++once nnoremap <buffer><nowait> z <scriptcmd>GoToSymbol()<cr>
