vim9script

# XXX: reword it later
# If left pair ends with space
# - linewise surround adds newline instead of space
# If left pair ends with \n
# - charwise/blockwise ignores it
# - linewise surround adds newline instead of \n
# If left pair ends with no space
# - linewise for a single line surrounds within the line
# - linewise for multiple lines surrounds with additional newlines
var pairs = {
    'b': ('(', ')'), '(': ('( ', ' )'), ')': ("\n(", ')'),
    'B': ('{', '}'), '{': ('{ ', ' }'), '}': ("\n{", '}'),
    'd': ('[', ']'), 'D': ('[ ', ' ]'), '[': ('[ ', ' ]'), ']': ("\n[", ']'),
    'v': ("\n<", '>'), 'V': ('< ', ' >'), '<': ('< ', ' >'), '>': ("\n<", '>'),
    'g': ("\n\"", '"'), 'G': ("\"\"\"\n", '"""'),
    '"': ("\n\"", '"'), "'": ("\n'", "'"),
    'q': ("\n‘", "’"), 'Q': ("\n“", "”"),
    'w': ("\n‹", "›"), 'W': ("\n«", "»"),
    'r': ("\n`", '`'), 'R': ("```\n", '```'),
    'u': ("\n_", '_'), 'U': ("\n__", '__'),
    'o': ("\n*", '*'), 'O': ("\n**", '**'), '*': ("\n*", '*'),
    'y': ("\n~", '~'), 'Y': ("\n~~", '~~'),
    'p': ("\n|", "|"), 'P': ("\n| ", " |"),
}

var s_text: string = ''
export def With(s: string)
    s_text = s
enddef

var visual_dollar: bool = false
export def VisualDollar(val: bool)
    visual_dollar = val
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

    # For a single line surround
    # - ( [ { < surround with newlines
    # - ``` and """ surrounds with newlines
    # - <tag> surrounds with newlines
    # - others surround line without newlines
    var s_mode = mode
    if mode == 'line' && start[1] == end[1] && s_left[-1] !~ '[> ]' && s_left[-1] != "\n"
        s_mode = 'char'
        normal! _
        start = getcursorcharpos()
        normal! g_
        end = getcursorcharpos()
    elseif mode == 'line' && s_left[0] == "\n"
        s_mode = 'char'
        normal! _
        start = getcursorcharpos()
        setcharpos('.', end)
        normal! g_
        end = getcharpos('.')
    elseif mode == 'line'
        s_left = trim(s_left)
        s_right = trim(s_right)
    endif

    s_left = trim(s_left, "\n")

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

        var blink_start_start = deepcopy(start)
        var blink_start_end = deepcopy(start)
        blink_start_start[2] -= strchars(s_left)
        var blink_end_start = deepcopy(end)
        blink_end_start[2] += 1
        var blink_end_end = deepcopy(end)
        blink_end_end[2] += strchars(s_right)
        Blink(getregionpos(blink_start_start, blink_start_end))
        Blink(getregionpos(blink_end_start, blink_end_end))
    elseif s_mode == 'line'
        var blink_start_start = deepcopy(start)
        var blink_start_end = deepcopy(start)
        var blink_end_start = deepcopy(end)
        var blink_end_end = deepcopy(end)

        exe $":{start[1]}normal! O{s_left}"
        exe $":{end[1]}normal! jo{s_right}"
        if s_left =~ '[([{]'
            exe $":{start[1]},{end[1] + 2}normal! =="
        endif
        exe $":{start[1] + 1}"
        exe ":normal! _"

        blink_start_start[2] = indent(blink_start_start[1])
        blink_start_end[2] = blink_start_start[2] + strchars(s_left)
        blink_end_start[1] += 2
        blink_end_end[1] += 2
        blink_end_start[2] = indent(blink_end_start[1])
        blink_end_end[2] = indent(blink_end_end[1]) + strchars(s_right)
        Blink(getregionpos(blink_start_start, blink_start_end))
        Blink(getregionpos(blink_end_start, blink_end_end))
    elseif s_mode == "block"
        # FIXME: bad on lines with tabs
        if visual_dollar
            for nr in range(start[1], end[1])
                if strchars(getline(nr)) >= start[2] + start[3]
                    setcursorcharpos(nr, start[2] + start[3])
                    var squeeze = ""
                    if getline(nr)[ : start[2] + start[3] - 1] =~ '^\s*$'
                        squeeze = "_"
                    endif
                    exe $"normal! {squeeze}\<C-v>$"
                    exe $"normal! I{s_tab}{s_left}"
                    exe "normal! \<C-v>$"
                    exe $"normal! A{s_tab}{s_right}"

                    var blink_start_start = deepcopy(start)
                    var blink_start_end = deepcopy(end)
                    blink_start_start[1] = nr
                    blink_start_start[2] = max([indent(nr) + 1, blink_start_start[2]])
                    blink_start_end[1] = nr
                    blink_start_end[2] = blink_start_start[2] + strchars(s_left) - 1
                    blink_start_end[3] = 0
                    Blink(getregionpos(blink_start_start, blink_start_end, {type: "\<C-v>", exclusive: false}))
                    var blink_end_start = deepcopy(start)
                    var blink_end_end = deepcopy(end)
                    blink_end_start[1] = nr
                    blink_end_end[1] = nr
                    blink_end_start[2] = strcharlen(getline(blink_end_start[1])) - strchars(s_right) + 1
                    blink_end_end[2] = v:maxcol
                    Blink(getregionpos(blink_end_start, blink_end_end, {type: "\<C-v>", exclusive: false}))
                endif
            endfor
            setcursorcharpos(start[1], start[2] + start[3])
            exe "normal! \<C-v>"
            setcursorcharpos(end[1], end[2] + end[3])
            exe "normal! $\<ESC>"
            setcursorcharpos(start[1], start[2] + start[3] + strchars(s_left))
        else
            #extend short lines to fix `I` in visual block
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

            var blink_start_start = deepcopy(start)
            var blink_start_end = deepcopy(end)
            blink_start_end[2] = start[2] + strchars(s_left) - 1
            var blink_end_start = deepcopy(start)
            var blink_end_end = deepcopy(end)
            blink_end_start[2] = end[2] + strchars(s_left) + 1
            blink_end_end[2] = blink_end_start[2] + strchars(s_right) - 1
            Blink(getregionpos(blink_start_start, blink_start_end, {type: "\<C-v>", exclusive: false}))
            Blink(getregionpos(blink_end_start, blink_end_end, {type: "\<C-v>", exclusive: false}))
        endif
    endif
enddef

def Blink(regionpos: list<any>)
    var m = matchaddpos('MatchParen', regionpos->mapnew((_, v) => {
        var col_beg = v[0][2] + v[0][3]
        var col_end = v[1][2] + v[1][3] + 1
        return [v[0][1], col_beg, col_end - col_beg]
    }))
    if m == -1
        return
    endif
    var winid = win_getid()
    timer_start(300, (_) => m->matchdelete(winid))
enddef
