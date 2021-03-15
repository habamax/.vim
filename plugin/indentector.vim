func! s:get_indent(line) abort
    let tab = 0
    let space = 0
    let shiftwidth = {}

    let indent = matchstr(a:line, '^\s\+')
    let indent_len = len(indent)

    if indent_len > 0
        if indent[0] == "\t"
            let tab = 1
        elseif indent_len > 1
            let space = 1
            for sw in range(8, 2, -1)
                let shiftwidth[sw] = indent_len % sw ? 0 : 1
            endfor
        endif
    endif
    return [tab, space, shiftwidth]
endfunc


func! s:detect_indent(lines) abort
    if &buftype != ''
        return
    endif

    let tabs = 0
    let spaces = 0
    let shiftwidths = {2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0}
    for line in a:lines
        let [tab, space, shiftwidth] = s:get_indent(line)
        let [tabs, spaces] += [tab, space]
        for [key, value] in items(shiftwidth)
            let shiftwidths[key] += value
        endfor
    endfor

    if tabs > spaces
        setlocal noexpandtab
    else
        setlocal expandtab
        let sw = 0
        let sw_acc = 0
        for [key, value] in items(shiftwidths)
            if sw_acc < value + value * key / 2 && sw < key
                let sw_acc = value + value * key / 2
                let sw = key
            endif
        endfor
        if sw != 0
            let &l:shiftwidth = sw
        endif
    endif
endfunc


augroup indentector | au!
    au FileType * call s:detect_indent(getline(1, 1024))
augroup END
