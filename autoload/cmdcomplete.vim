vim9script

export def Buffer(arg: string, _, _): list<dict<any>>
    var buffer_list = getbufinfo({'buflisted': 1})->mapnew((_, v) => {
        var term_status = ''
        var kind = ''
        if bufnr('%') == v.bufnr
               kind ..= '%'
        elseif bufnr('#') == v.bufnr
               kind ..= '#'
        endif
        kind ..= empty(v.windows) ? "" : "a"
        kind ..= v.hidden ? "h" : ""
        if getbufvar(v.bufnr, "&buftype") == 'terminal'
            term_status = $' [{term_getstatus(v.bufnr)}]'
            kind ..=  term_status[2]->toupper()
        else
            kind ..= v.changed ? "+" : ""
            if !getbufvar(v.bufnr, "&modifiable")
                kind ..= '-'
            elseif getbufvar(v.bufnr, "&readonly")
                kind ..= '='
            endif
        endif
        return {bufnr: v.bufnr,
                abbr: (bufname(v.bufnr) ?? $'[No Name]') .. term_status,
                word: (bufname(v.bufnr) ?? v.bufnr),
                menu: $'line {v.lnum}',
                kind: kind,
                lastused: v.lastused }
    })->sort((i, j) => i.lastused > j.lastused ? -1 : i.lastused == j.lastused ? 0 : 1)
    # Alternate buffer first, current buffer second
    if buffer_list->len() > 1 && buffer_list[0].bufnr == bufnr()
        [buffer_list[0], buffer_list[1]] = [buffer_list[1], buffer_list[0]]
    endif
    if empty(arg)
        return buffer_list
    else
        return buffer_list->matchfuzzy(arg, {key: "abbr"})
    endif
enddef

import autoload 'unicode.vim'
export def Unicode(arg: string, _, _): list<dict<any>>
    var ulist = unicode.Subset()->mapnew((_, v) => {
        return {
            word: printf("%04X", v.value),
            abbr: v.name,
            kind: printf("%6s", (nr2char(v.value, true) =~ '\p' ? nr2char(v.value, true) : " ")),
            menu: printf("%04X", v.value)}
    })
    if empty(arg)
        return ulist
    else
        return ulist->matchfuzzy(arg, {key: "abbr"})
    endif
enddef

export def Help(arg: string, _, _): list<dict<any>>
    var help_tags = globpath(&rtp, "doc/tags", 1, 1)
        ->mapnew((_, v) => readfile(v)->mapnew((_, line) => {
            var tag_info = line->split("\t")
            return {word: tag_info[0], menu: tag_info[1]}
        }))->flattennew()
    if empty(arg)
        return help_tags
    else
        return help_tags->matchfuzzy(arg, {key: "word"})
    endif
enddef

export def Colorscheme(arg: string, _, _): list<string>
    var cur_colorscheme = get(g:, "colors_name", "default")
    var colors = [cur_colorscheme] + getcompletion('', 'color')->filter((_, v) => v != cur_colorscheme)
    if empty(arg)
        return colors
    else
        return colors->matchfuzzy(arg)
    endif
enddef

export def Make(_, _, _): string
    if has("win32")
        return ""
    endif
    return system("make -npq : 2> /dev/null | awk -v RS= -F: '$1 ~ /^[^#%.]+$/ { print $1 }' | sort -u")
enddef

