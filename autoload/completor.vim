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

# Path completion
var current_path = ''
def PathSize(size: number): string
    if size >= 10 * 1073741824 # 10G
        return printf("%.0fG", ceil(size / 1073741824.0))
    elseif size >= 10 * 1048576 # 10M
        return printf("%.0fM", ceil(size / 1048576.0))
    elseif size >= 1048576 # 1M
        return printf("%.1fM", size / 1048576.0)
    elseif size >= 10240 # 10K
        return printf("%.0fK", ceil(size / 1024.0))
    else
        return $"{size}"
    endif
enddef

export def Path(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\v\f%(\f|\s)*$')
        prefix = prefix->substitute('\v.{-}\ze\f+([/\\]|$)', '', '')
        var suffix = prefix->matchstr('[^/\\]\+$')
        current_path = prefix->fnamemodify(':p')
        if isdirectory(current_path) && !suffix->empty()
            current_path = current_path->fnamemodify(':p:h:h')
        else
            current_path = current_path->fnamemodify(':p:h')
        endif

        if suffix->empty() && prefix !~ '[/\\]\+$'
            return -2
        endif
        if !isdirectory(current_path)
            return -2
        endif
        return col('.') - suffix->len() - 1
    endif

    var items = []

    try
        for f in readdirex(current_path ?? getcwd())
            items->add({
                word: f.name,
                kind: "/",
                menu: f.type,
                info: $"{f.perm} {f.user} {f.group} {PathSize(f.size)} {strftime("%Y-%m-%d %H:%M:%S", f.time)}\n",
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
