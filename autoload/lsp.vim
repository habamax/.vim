vim9script

import autoload 'popup.vim'
# import autoload "qc.vim"
# import autoload 'lsp/lsp.vim'
# import autoload 'lsp/util.vim'

export def SetupFT()
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

const symbol_map: list<string> = [
    '', 'File', 'Module', 'Namespace', 'Package', 'Class', 'Method',
    'Property', 'Field', 'Constructor', 'Enum', 'Interface', 'Function',
    'Variable', 'Constant', 'String', 'Number', 'Boolean', 'Array',
    'Object', 'Key', 'Null', 'EnumMember', 'Struct', 'Event', 'Operator',
    'TypeParameter'
]

def GetDocSymbols(): dict<any>
    var fname: string = @%
    if fname->empty()
        return {}
    endif

    var lspserver = lsp.Server()
    if lspserver->empty() || !lspserver.running || !lspserver.ready
        return {}
    endif

    # Check whether LSP server supports getting document symbol information
    if !lspserver.isDocumentSymbolProvider
        return {}
    endif

    # interface DocumentSymbolParams
    # interface TextDocumentIdentifier
    var params = {textDocument: {uri: util.LspFileToUri(fname)}}
    return lspserver.rpc('textDocument/documentSymbol', params)
enddef

def LspGoToSymbol()
    var doc_symbols = GetDocSymbols()
    if empty(doc_symbols)
        return
    endif
    var symbols = doc_symbols.result->mapnew((_, v) => {
        return {
            linenr: v.range.start.line + 1,
            charcol: v.range.start.character + 1,
            text: v.name,
            pretext: symbol_map[v.kind] .. ': ',
            posttext: $' ({v.range.start.line + 1})'}
    })

    popup.Select("LSP Symbols", symbols,
        (res, key) => {
            setcursorcharpos(res.linenr, res.charcol)
            normal! zz
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectSymbolKind '^\\k\\+:'")
            win_execute(winid, "syn match PopupSelectSymbolLine '\\s(\\d\\+)$'")
            hi def link PopupSelectSymbolKind Identifier
            hi def link PopupSelectSymbolLine Comment
        })
enddef
