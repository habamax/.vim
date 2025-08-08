vim9script

# Completor functions used in complete.vim or as omnifunc

var vimtrigger: string = ""
var vimprefix: string = ""

def GetTrigger(line: string): list<any>
    var result = ""
    var result_len = 0

    if line =~ '->\k*$'
        result = 'function'
    elseif line =~ '\v%(^|\s+)\&\k*$'
        result = 'option'
    elseif line =~ 'set no\k*$'
        echow "set no too"
        result = 'nooption'
        result_len = -2
    elseif line =~ '[lvgsb]:\k*$'
        result = 'var'
        result_len = 2
    else
        result = getcompletiontype(line) ?? 'cmdline'
    endif
    return [result, result_len]
enddef

export def Vim(findstart: number, base: string): any
    if findstart > 0
        var line = getline('.')->strpart(0, col('.') - 1)
        var keyword = line->matchstr('\k\+$')
        var stx = synstack(line('.'), col('.') - 1)->map('synIDattr(v:val, "name")')->join()
        if stx =~? 'Comment' || (stx =~ 'String' && stx !~ 'vimStringInterpolationExpr')
            return -2
        endif
        var trigger_len: number = 0
        [vimtrigger, trigger_len] = GetTrigger(line)
        if keyword->empty() && vimtrigger->empty()
            return -2
        endif
        vimprefix = line
        return line->len() - keyword->len() - trigger_len
    endif

    # if prefix == 'set no'
    #     echow "SET NO"
    # endif
    var items = []
    if vimtrigger == 'function'
        items = getcompletion(base, 'function')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Function', dup: 0}))
    elseif vimtrigger == 'option'
        items = getcompletion(base, 'option')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Option', dup: 0}))
    elseif vimtrigger == 'nooption'
        items = getcompletion(base, 'cmdline')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Option', dup: 0}))
    elseif vimtrigger == 'var'
        items = getcompletion(base, 'var')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Variable', dup: 0}))
    elseif vimtrigger == 'expression'
        items = getcompletion(base, 'expression')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Expression', dup: 0}))
    elseif vimtrigger == 'command'
        var commands = getcompletion(base, 'command')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Command', dup: 0}))
        var functions = getcompletion(base, 'function')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Function', dup: 0}))
        items = commands + functions
    else
        items = getcompletion(vimprefix, 'cmdline')
            ->mapnew((_, v) => ({word: v->matchstr('\k\+'), kind: 'v', dup: 0}))

        if empty(items) && !empty(base)
            items = getcompletion(base, 'expression')
                ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Expression', dup: 0}))
        endif
    endif

    return items->empty() ? v:none : {words: items, refresh: "always"}
enddef

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
    items = items->matchfuzzy(base, {key: "word", camelcase: false})
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

    items = items->matchfuzzy(base, {key: "word", camelcase: false})
    return items->empty() ? v:none : items
enddef
