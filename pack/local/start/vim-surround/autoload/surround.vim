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
    '[': ('[ ', ' ]'), ']': ("\n[", ']'),
    '<': ('< ', ' >'), '>': ("\n<", '>'),
    '"': ("\n\"", '"'), "'": ("\n'", "'"),
    '*': ("\n*", '*'), '_': ("\n_", '_'), '/': ("\n/", '/'),
}

extend(pairs, get(g:, "surround_pairs", {}))

var s_text: string = ''
export def With(s: string)
    s_text = s
enddef

var visual_dollar: bool = false
export def VisualDollar(val: bool)
    visual_dollar = val
enddef

export def Add(mode: string)
    var lazyredraw = &lazyredraw
    var virtualedit = &virtualedit
    var indentkeys = &indentkeys
    var autoindent = &autoindent
    set lazyredraw
    setlocal virtualedit=all
    setlocal indentkeys=
    setlocal autoindent
    defer () => {
        &lazyredraw = lazyredraw
        &l:virtualedit = virtualedit
        &l:indentkeys = indentkeys
        &l:autoindent = autoindent
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
        if empty(pair) && s_text !~ '[[:punct:][:space:][:blank:]]'
            return
        endif
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
    elseif s_mode == 'line'
        exe $":{start[1]}normal! O{s_left}"
        exe $":{end[1]}normal! jo{s_right}"
        if s_left =~ '[([{]'
            exe $":{start[1]},{end[1] + 2}normal! =="
        endif
        exe $":{start[1] + 1}"
        exe ":normal! _"
    elseif s_mode == "block"
        if visual_dollar
            for nr in range(start[1], end[1])
                if strchars(getline(nr)) >= start[2]
                    setcursorcharpos(nr, start[2])
                    var squeeze = ""
                    if getline(nr)[ : start[2] - 1] =~ '^\s*$'
                        squeeze = "_"
                    endif
                    exe $"normal! {squeeze}\<C-v>$"
                    exe $"normal! I{s_tab}{s_left}"
                    exe "normal! \<C-v>$"
                    exe $"normal! A{s_tab}{s_right}"

                endif
            endfor
            setcursorcharpos(start[1 :])
            exe "normal! \<C-v>"
            setcursorcharpos(end[1 :])
            exe "normal! $\<ESC>"
            start[2] += strchars(s_left)
            setcursorcharpos(start[1 :])
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
        endif
    endif
enddef

# XXX: start simple, only [({< and their corresponding closing pairs
export def Remove()
    var cursor = getcurpos()
    var s_left = ""
    var s_right = ""
    var start = []
    var end = []
    if s_text == 's'
        var pos_list = []
        for char in '({[<'
            var pair = get(pairs, char, ())
            s_left = empty(pair) ? char : trim(pair[0])
            s_right = empty(pair) ? char : trim(pair[1])
            [start, end] = ProbePair(s_left, s_right)
            if !empty(start) && !empty(end)
                add(pos_list, [start, end, s_left, s_right])
            endif
        endfor
        if empty(pos_list)
            return
        endif
        [start, end, s_left, s_right] = pos_list->sort((v1, v2) => {
            if v1[0][0] == v2[0][0]
                return v1[0][1] == v2[0][1] ? 0 : v1[0][1] > v2[0][1] ? 1 : -1
            elseif v1[0][0] > v2[0][0]
                return 1
            else
                return -1
            endif
        })[-1]
    elseif s_text == 't'
        [start, end, s_left, s_right] = ProbeTag()
    else
        var pair = get(pairs, s_text, ())
        s_left = empty(pair) ? s_text : trim(pair[0])
        s_right = empty(pair) ? s_text : trim(pair[1])
        [start, end] = ProbePair(s_left, s_right)
    endif

    if empty(start) || empty(end)
        return
    endif

    cursor(start)
    if getline('.') =~ $'\V\^\s\*{escape(s_left, '\')}\$'
        normal! "_dd
        start[0] -= 1
        end[0] -= 1
        cursor[1] -= 1
    else
        exe $'normal! {strcharlen(s_left)}"_x'
    endif
    if start[0] == cursor[1] && end[0] == cursor[1]
        end[1] -= strchars(s_left)
        cursor[2] -= strchars(s_left)
    endif
    cursor(end)
    if getline('.') =~ $'\V\^\s\*{escape(s_right, '\')}\$'
        normal! "_dd
        end[0] -= 1
    else
        exe $'normal! {strcharlen(s_right)}"_x'
    endif

    if end[0] - start[0] > 1 && s_left =~ '[([{]'
        exe $":{start[0]},{end[0]}normal! =="
    endif
    setpos('.', cursor)
enddef


def ProbePair(s_left: string, s_right: string): list<list<number>>
    var view = winsaveview()
    defer () => {
        winrestview(view)
    }()

    if trim(s_left) != trim(s_right)
        var start = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'cnbW')
        var end = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'nW')

        if start == [0, 0] || end == [0, 0]
            normal! %
            start = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'cnbW')
            end = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'nW')
            if start == [0, 0] || end == [0, 0]
                return [[], []]
            endif
        endif
        return [start, end]
    else
        # XXX: searchpairpos doesn't work for identical pairs, so we need to
        # search them separately and check if they form a pair
        # var start = searchpos('\V' .. escape(s_left, '\'), 'cnb')
        # var end = searchpos('\V' .. escape(s_right, '\'), 'cn')

        return [[], []]
    endif
enddef

def ProbeTag(): tuple<list<number>, list<number>, string, string>
    var view = winsaveview()
    defer () => {
        winrestview(view)
    }()

    var s_left = ''
    var s_right = ''
    var tagregion = []
    try
        normal! vat
        tagregion = getregionpos(getpos('v'), getpos('.'), {type: 'v'})
        var line = getline(tagregion[-1][-1][1])[ : tagregion[-1][-1][2] - 1]
        s_right = matchstr(line, '</\S\{-}>$')
        line = getline(tagregion[0][0][1])[tagregion[0][0][2] - 1 :]
        s_left = matchstr(line, '^<[^[:punct:][:space:]].\{-}[^/]>')

        if !empty(s_left) && !empty(s_right)
            var start = [tagregion[0][0][1], tagregion[0][0][2]]
            var end = [tagregion[-1][-1][1], tagregion[-1][-1][2] - strcharlen(s_right) + 1]
            return (start, end, s_left, s_right)
        endif
    catch
    finally
        exe "normal! \<esc>"
    endtry
    return ([], [], '', '')
enddef

