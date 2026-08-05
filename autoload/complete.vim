vim9script

# Complete functions used in `set complete`

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
const MAX_REG_LENGTH = 30
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
    for r in '"/#:%abcdefghijklmnopqrstuvwxyz'
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

# Path completion
var current_path = ''
var path_cache = []
export def Path(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\v\f%(\f|\s)*$')
        prefix = prefix->substitute('\v[^/\\]{-}\ze\f*([/\\]|$)', '', '')
        var suffix = prefix->matchstr('[^/\\]\+$')
        if empty(suffix) && empty(prefix)
            return -2
        endif
        prefix = expand(prefix)
        if !isabsolutepath(prefix)
            prefix = [expand('%:h') ?? getcwd(), prefix]->join('/')
        endif
        if isdirectory(prefix)
            current_path = prefix
        elseif !empty(suffix)
            current_path = prefix->fnamemodify(':h')
        else
            current_path = ''
        endif
        path_cache = []
        return col('.') - suffix->len() - 1
    endif

    var items = []

    if empty(current_path)
        return v:none
    endif

    try
        if path_cache->empty()
            path_cache = readdirex(current_path)
        endif
        for f in path_cache
            items->add({
                word: f.name,
                kind: "/",
                menu: f.type,
                dup: 1
            })
        endfor
    catch
    endtry

    if !empty(base)
        items = items->matchfuzzy(fnamemodify(base, ":t"), {key: "word"})
    endif
    return items->empty() ? v:none : {words: items, refresh: "always"}
enddef
