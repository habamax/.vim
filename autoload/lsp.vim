vim9script

import autoload "qc.vim"
import autoload 'popup.vim'
import autoload 'lsp/lsp.vim'
import autoload 'lsp/util.vim'

augroup LSPPreview
    au!
    au BufCreate LspHover set wrap
augroup END

export def SetupFT()
    nnoremap <silent><buffer> gd <cmd>LspGotoDefinition<CR>
    nnoremap <silent><buffer> gD <scriptcmd>exe ":hor LspGotoDefinition"<CR>
    nnoremap <silent><buffer> <C-]> <cmd>LspGotoDefinition<CR>
    nnoremap <silent><buffer> <C-w><C-]> <cmd>exe ":hor LspGotoDefinition"<CR>
    xnoremap <silent><buffer> . <cmd>LspSelectionExpand<CR>
    xnoremap <silent><buffer> , <cmd>LspSelectionShrink<CR>
    nnoremap <silent><buffer> <space>l <scriptcmd>qc.LspCommands()<CR>
    nnoremap <silent><buffer> <space>z <scriptcmd>LspGoToSymbol()<CR>
    nnoremap <silent><buffer> K <cmd>LspHover<CR>
    nnoremap <silent><buffer> gq <plug>(LspFormat)
    xnoremap <silent><buffer> gq <plug>(LspFormat)

    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gD"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <C-]>"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <C-w><C-]>"'
    b:undo_ftplugin ..= ' | exe "xunmap <buffer> ."'
    b:undo_ftplugin ..= ' | exe "xunmap <buffer> ,"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>l"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gq"'
    b:undo_ftplugin ..= ' | exe "xunmap <buffer> gq"'
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

# def DocSymbolsComplete(arg: string, _, _): list<dict<any>>
#     var doc_symbols = GetDocSymbols()
#     if empty(doc_symbols)
#         return []
#     endif
#     var result = doc_symbols.result->mapnew((_, v) => {
#         return {
#             word: $'{v.name}:{v.range.start.line + 1}:{v.range.start.character + 1}',
#             abbr: v.name,
#             kind: symbol_map[v.kind]}
#         })
#     return empty(arg) ? result : result->matchfuzzy(arg, {key: "abbr"})
# enddef

# # position is the string of Whatever:Line:Character, e.g. MyFunc:10:5
# def GoTo(position: string)
#     if position !~ '\d\+:\d\+$'
#         echoerr "Invalid position format. Expected 'Whatever:Line:CharCol'."
#         return
#     endif
#     var pos_list = split(position, ':')
#     var line = str2nr(pos_list[-2])
#     var charcol = str2nr(pos_list[-1])
#     setcursorcharpos(line, charcol)
# enddef

# command -nargs=_ -complete=customlist,DocSymbolsComplete LspGoToSymbol GoTo(<f-args>)


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
            hi def link PopupSelectSymbolKind Comment
            hi def link PopupSelectSymbolLine Comment
        })
enddef
