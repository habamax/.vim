vim9script

# Completor functions used in complete.vim or as omnifunc

# Language server protocol (LSP) completion
# provided by the omnifunction from yegappan/lsp plugin.
export def Lsp(findstart: number, base: string): any
    # Using g:LspOmniFunc from the yegappan/lsp plugin.
    if &l:omnifunc != 'g:LspOmniFunc'
        return -2 # cancel but stay in completion mode
    endif
    if findstart == 1
        return g:LspOmniFunc(findstart, base)
    elseif findstart == 2
        return g:LspOmniCompletePending() ? 0 : 1
    endif
    return g:LspOmniFunc(findstart, base)
enddef

# Abbreviations completion.
export def Abbrev(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\S\+$')
        if prefix->empty()
            return -2
        endif
        return col('.') - prefix->len() - 1
    endif
    var lines = execute('ia', 'silent!')
    if lines =~? gettext('No abbreviation found')
        return v:none
    endif
    var items = []
    for line in lines->split("\n")
        var m = line->matchlist('\v^i\s+\zs(\S+)\s+(.*)$')
        items->add({ word: m[1], kind: "ab", info: m[2], dup: 1 })
    endfor
    items = items->matchfuzzy(base, {key: "word"})
    return items->empty() ? v:none : items
enddef

# Registers completion.
const MAX_REG_LENGTH = 50
export def Register(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\S\+$')
        if prefix->empty()
            return -2
        endif
        return col('.') - prefix->len() - 1
    endif

    var items = []

    # for r in '"/=#:%-0123456789abcdefghijklmnopqrstuvwxyz'
    for r in '"/=#:%abcdefghijklmnopqrstuvwxyz'
        var text = trim(getreg(r))
        var abbr = text->slice(0, MAX_REG_LENGTH)->substitute('\n', '⏎', 'g')
        var info = ""
        if text->len() > MAX_REG_LENGTH
            abbr ..= "…"
            info = text
        endif
        if !empty(text)
            items->add({
                abbr: abbr,
                word: text,
                kind: 'R',
                menu: '"' .. r,
                info: info,
                dup: 0
            })
        endif
    endfor

    items = items->matchfuzzy(base, {key: "word"})
    return items->empty() ? v:none : items
enddef
