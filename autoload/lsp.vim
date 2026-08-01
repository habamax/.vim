vim9script

import autoload "qc.vim"
import autoload 'popup.vim'
import autoload 'lsp/lsp.vim'
import autoload 'lsp/util.vim'

export def SetupFT()
    setlocal keywordprg=:LspHover
    nnoremap <silent><buffer> gd <scriptcmd>LspGotoDefinition<CR>
    # nnoremap <silent><buffer> <space>z :<C-U>LspGoToSymbol<space>
    # nnoremap <silent><buffer> <space>z <scriptcmd>LspDocumentSymbol<CR>
    nnoremap <silent><buffer> <space>z <scriptcmd>LspGoToSymbol()<CR>
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
            posttext: ' ' .. symbol_map[v.kind]}
    })

    popup.Select("LSP Symbols", symbols,
        (res, key) => {
            setcursorcharpos(res.linenr, res.charcol)
            normal! zz
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectSymbolKind '\\k\\+\\s\\+\\zs\\S\\+$'")
            hi def link PopupSelectSymbolKind PmenuKind
        })
enddef
