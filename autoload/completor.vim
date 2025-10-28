vim9script

# Completor functions used in `set complete`

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
        var abbr = text
            ->slice(0, MAX_REG_LENGTH)
            ->substitute('\n', '⏎', 'g')
            ->strtrans()
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
