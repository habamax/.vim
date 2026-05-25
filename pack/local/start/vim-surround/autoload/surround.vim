vim9script

var pairs = {
    b: ('(', ')'), '(': ('( ', ' )'), ')': ('(', ')'),
    B: ('{', '}'), '{': ('{ ', ' }'), '}': ('{', '}'),
    d: ('[', ']'), D: ('[ ', ' ]'), '[': ('[ ', ' ]'), ']': ('[', ']'),
    v: ('<', '>'), V: ('< ', ' >'), '>': ('< ', ' >'), '<': ('<', '>'),
    g: ('"', '"'), G: ('"""', '"""'),
    q: ("‘", "’"), Q: ("“", "”"),
    w: ("‹", "›"), W: ("«", "»"),
    r: ('`', '`'), R: ('```', '```'),
    u: ('_', '_'), U: ('__', '__'),
    o: ('*', '*'), O: ('**', '**'),
    y: ('~', '~'), Y: ('~~', '~~'),
    p: ("|", "|"), P: ("| ", " |"),
}

var s_text: string = ''
export def With(s: string)
    s_text = s
enddef

export def Surround(mode: string)
    var lazyredraw = &lazyredraw
    var virtualedit = &virtualedit
    var indentkeys = &indentkeys
    set lazyredraw
    setlocal virtualedit=all
    setlocal indentkeys=
    defer () => {
        &lazyredraw = lazyredraw
        &l:virtualedit = virtualedit
        &l:indentkeys = indentkeys
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

    var s_tab = s_text == "\<tab>" ? "\<C-v>" : ''

    var s_mode = mode
    if mode == 'line' && start[1] == end[1] && s_left[-1] != ' '
        s_mode = 'char'
        normal! _
        start = getpos('.')
        normal! g_
        end = getcharpos('.')
    elseif mode == 'line'
        s_left = trim(s_left)
        s_right = trim(s_right)
    endif

    if s_mode == 'char'
        setcharpos('.', start)
        exe $"normal! i{s_tab}{s_left}"
        if start[1] == end[1]
            end[2] += strchars(s_left)
        endif
        start[2] += strchars(s_left)
        setcharpos('.', end)
        exe $"normal! a{s_tab}{s_right}"
        setcharpos('.', start)
    elseif s_mode == 'line'
        exe $":{start[1]}normal! O{s_left}"
        exe $":{end[1]}normal! jo{s_right}"
        exe $":{start[1]},{end[1] + 2}normal! =="
        exe $":{start[1] + 1}"
        exe ":normal! _"
    elseif s_mode == "block"
        # extend short lines to fix `I` in visual block
        for nr in range(start[1], end[1])
            if strchars(getline(nr)) < end[2] + end[3]
                call setline(nr, getline(nr) .. repeat(' ', end[2] + end[3] - 1 - strchars(getline(nr))))
            endif
        endfor

        setcursorcharpos(end[1], end[2] + end[3])
        exe "normal! \<C-v>"
        setcursorcharpos(start[1], start[2] + start[3])
        exe $"normal! I{s_tab}{s_left}"

        setcursorcharpos(end[1], end[2] + strchars(s_left) + end[3])
        exe "normal! \<C-v>"
        setcursorcharpos(start[1], start[2] + strchars(s_left) + start[3])
        exe $"normal! A{s_tab}{s_right}"
    endif
enddef
