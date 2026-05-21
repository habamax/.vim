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
    var shiftwidth = &shiftwidth
    var expandtab = &expandtab
    var softtabstop = &softtabstop
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
        setcharpos('.', end)
        exe $"normal! a\<C-v>{s_right}"
        setcharpos('.', start)
        # XXX: with tabs, the cursor is wrongly placed
        exe $"normal! {strchars(s_left)}l"

        # INFO: simpler, but undo puts the cursor to the end of the text
        #       which I don't like
        # setcharpos('.', end)
        # exe $"normal! a{s_right}"
        # setcharpos('.', start)
        # exe $"normal! i{s_left}"
        # exe "normal! l"
    elseif mode == 'line'
        exe $":{start[1]}normal! O{s_left}"
        exe $":{end[1]}normal! jo{s_right}"
        exe $":{start[1] + 1},{end[1] + 2}normal! =="
        exe $":{start[1] + 1}"
        exe ":normal! _"
    elseif mode == "block"
        # XXX: undo places cursor at the end of previously selected block.
        # is there a way to prevent that?
        normal! gv
        exe $"normal! A\<C-v>{s_right}"
        normal! gv
        exe $"normal! I\<C-v>{s_left}"

        # reselect and cancel the visual block so it would be possible to repeat
        # with .
        setcursorcharpos(end[1], end[2] + strchars(s_left) + end[3])
        exe "normal! \<C-v>"
        setcursorcharpos(start[1], start[2] + strchars(s_left) + start[3])
        exe "normal! \<esc>"
    endif
enddef
