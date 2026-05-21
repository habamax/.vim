vim9script

var pairs = {
    b: ('(', ')'), '(': ('(', ')'), ')': ('(', ')'),
    B: ('{', '}'), '{': ('{', '}'), '}': ('{', '}'),
    d: ('[', ']'), '[': ('[', ']'), ']': ('[', ']'),
    v: ('<', '>'), '>': ('<', '>'), '<': ('<', '>'),
    g: ('"', '"'), h: ("'", "'"),
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

    var start = getpos("'[")
    var end = getpos("']")
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
        exe $":{end[1]}"
        exe $"normal! {end[2]}|a{s_right}"
        exe $":{start[1]}"
        exe $"normal! {start[2]}|i{s_left}"
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
        var idx = 0
        for linenr in range(start[1], end[1])
            var adj_linenr = linenr
            if s_text == "\<CR>"
                adj_linenr += idx * 2
            endif
            var start_adj = start[2] + start[3]
            var end_adj = end[2] + end[3]
            exe $":{adj_linenr}"
            exe $"normal! {end_adj}|a{s_right}"
            exe $":{adj_linenr}"
            exe $"normal! {start_adj}|i{s_left}"
            idx += 1
        endfor
        if s_text != "\<CR>"
            exe $":{start[1]}"
            exe "normal! l"
        else
            exe $":{start[1] + 1}"
        endif
    endif
enddef
