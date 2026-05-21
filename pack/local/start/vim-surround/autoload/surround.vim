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
    var lzredraw = &lazyredraw
    set lazyredraw
    var vedit = &virtualedit
    set virtualedit=all
    defer () => {
        &lazyredraw = lzredraw
        &virtualedit = vedit
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
        setcharpos('.', end)
        exe $"normal! a{s_right}"
        setcharpos('.', start)
        exe $"normal! i{s_left}"
        if s_text != "\<CR>"
            exe "normal! l"
        endif
    elseif mode == 'line'
        if s_text == "\<CR>"
            s_left = ""
            s_right = ""
        endif
        exe $":{start[1]}normal! O{s_left}"
        exe $":{end[1]}normal! jo{s_right}"
        exe $":{start[1] + 1},{end[1] + 2}normal! =="
        exe $":{start[1] + 1}"
        exe ":normal! _"
    elseif mode == "block"
        normal! gv
        exe $"normal! A{s_right}"
        normal! gv
        exe $"normal! I{s_left}"

        # XXX: gv fails with unicode chars like ‹ ›
        # move selection to the new position and cancel
        exe $"normal! gv{strchars(s_left)}lO{strchars(s_left)}l"
        exe "normal! \<esc>"
        # move cursor to the beginning of the visual block
        setcharpos('.', start)
        exe $"normal! {strchars(s_left)}l"
    endif
enddef
