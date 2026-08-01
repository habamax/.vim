vim9script

import autoload "qc.vim"

export def SetupFT()
    setlocal keywordprg=:LspHover
    nnoremap <silent><buffer> gd <scriptcmd>LspGotoDefinition<CR>
    nnoremap <silent><buffer> <space>z :<C-U>LspGoToSymbol<space>
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

import autoload 'lsp/lsp.vim'
import autoload 'lsp/util.vim'

const symbol_map: list<string> = [
    '',
    'File',
    'Module',
    'Namespace',
    'Package',
    'Class',
    'Method',
    'Property',
    'Field',
    'Constructor',
    'Enum',
    'Interface',
    'Function',
    'Variable',
    'Constant',
    'String',
    'Number',
    'Boolean',
    'Array',
    'Object',
    'Key',
    'Null',
    'EnumMember',
    'Struct',
    'Event',
    'Operator',
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
    doc_symbols = lspserver.rpc('textDocument/documentSymbol', params)
    return doc_symbols
enddef

var doc_symbols = {}
def DocSymbolsComplete(arg: string, _, _): list<dict<any>>
    doc_symbols = GetDocSymbols()
    if empty(doc_symbols)
        return []
    endif
    var result = doc_symbols.result->mapnew((_, v) => {
        return {
            word: v.name,
            kind: symbol_map[v.kind]}
        })
    return empty(arg) ? result : result->matchfuzzy(arg, {key: "word"})
enddef

def GoToSymbol(symbol_name: string)
    if empty(doc_symbols)
        doc_symbols = GetDocSymbols()
    endif
    if empty(doc_symbols)
        return
    endif
    for symbol in doc_symbols.result
        if symbol.name == symbol_name
            setcursorcharpos(symbol.range.start.line + 1, symbol.range.start.character + 1)
            break
        endif
    endfor
enddef

command -nargs=_ -complete=customlist,DocSymbolsComplete LspGoToSymbol GoToSymbol(<f-args>)
