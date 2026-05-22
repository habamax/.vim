vim9script

var pairs = {
    b: ('(', ')'), '(': ('(', ')'), ')': ('(', ')'),
    B: ('{', '}'), '{': ('{', '}'), '}': ('{', '}'),
    d: ('[', ']'), '[': ('[', ']'), ']': ('[', ']'),
    v: ('<', '>'), '>': ('<', '>'), '<': ('<', '>'),
    g: ('"', '"'), h: ("'", "'"), p: ("|", "|"),
    q: ("‘", "’"), Q: ("“", "”"), w: ("‹", "›"), W: ("«", "»"),
    u: ('_', '_'), s: ('~', '~'), r: ('`', '`'), R: ('```', '```'),
    '1': ('!', '!'), '2': ('@', '@'), '3': ('#', '#'), '4': ('$', '$'),
    '5': ('%', '%'), '6': ('^', '^'), '7': ('&', '&'), '8': ('*', '*'),
    '9': ('(', ')'), '0': ('(', ')'),
}

export def Surround(mode: string, s_text: string)
    var lazyredraw = &lazyredraw
    var virtualedit = &virtualedit
    set lazyredraw
    setlocal virtualedit=all
    defer () => {
        &lazyredraw = lazyredraw
        &l:virtualedit = virtualedit
    }()

    var start = getcharpos("'[")
    var end = getcharpos("']")
    var s_left = ''
    var s_right = ''
    if s_text =~ '^<.*>$'
        s_left = s_text
        s_right = '</' .. s_text[1 : -2]->split()[0] .. '>'
    else
        var pair = get(pairs, s_text, ())
        s_left = empty(pair) ? s_text : pair[0]
        s_right = empty(pair) ? s_text : pair[1]
    endif

    if mode == 'char'
        setcharpos('.', start)
        exe $"normal! i\<C-v>{s_left}"
        if start[1] == end[1]
            end[2] += strchars(s_left)
        endif
        start[2] += strchars(s_left)
        setcharpos('.', end)
        exe $"normal! a\<C-v>{s_right}"
        setcharpos('.', start)
    elseif mode == 'line'
        exe $":{start[1]}normal! O{s_left}"
        exe $":{end[1]}normal! jo{s_right}"
        exe $":{start[1] + 1},{end[1] + 2}normal! =="
        exe $":{start[1] + 1}"
        exe ":normal! _"
    elseif mode == "block"
        # extend short lines to fix `I` in visual block
        for nr in range(start[1], end[1])
            if strchars(getline(nr)) < end[2] + end[3]
                call setline(nr, getline(nr) .. repeat(' ', end[2] + end[3] - 1 - strchars(getline(nr))))
            endif
        endfor

        setcursorcharpos(end[1], end[2] + end[3])
        exe "normal! \<C-v>"
        setcursorcharpos(start[1], start[2] + start[3])
        exe $"normal! I\<C-v>{s_left}"

        setcursorcharpos(end[1], end[2] + strchars(s_left) + end[3])
        exe "normal! \<C-v>"
        setcursorcharpos(start[1], start[2] + strchars(s_left) + start[3])
        exe $"normal! A\<C-v>{s_right}"
    endif
enddef
