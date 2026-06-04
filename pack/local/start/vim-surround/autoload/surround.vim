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
    '"': ("\n\"", '"'), "'": ("\n'", "'"), "`": ("\n`", "`"),
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

var filetypes = []
def ShouldIndent(): bool
    if empty(filetypes)
        filetypes = globpath(&rtp, 'indent/*.vim', 0, 1)
            ->mapnew((_, v) => fnamemodify(v, ':t:r'))
    endif
    return filetypes->index(&filetype) != -1
enddef

export def Add(mode: string)
    var lazyredraw = &lazyredraw
    var virtualedit = &virtualedit
    var indentkeys = &indentkeys
    var autoindent = &autoindent
    var comments = &comments
    set lazyredraw
    setlocal virtualedit=all
    setlocal indentkeys=
    setlocal autoindent
    setlocal comments=
    defer () => {
        &lazyredraw = lazyredraw
        &l:virtualedit = virtualedit
        &l:indentkeys = indentkeys
        &l:autoindent = autoindent
        &l:comments = comments
    }()

    var start = getcharpos("'[")
    var end = getcharpos("']")

    # Handle case with v$S(. when selection is started in the middle of the
    # line. Start/end positions are incorrect in dot-repeating.
    var end_len = strcharlen(getline(end[1]))
    if visual_dollar && start[1] == end[1] && start[2] == 1 && end[2] != end_len
        start = deepcopy(end)
        end[2] = end_len
    endif

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
        if (s_left =~ '[([{]' || s_right =~ '</.\{-}>')
            && ShouldIndent()
            exe $":{start[1]}"
            exe $":silent normal! {end[1] - start[1] + 2}=="
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

export def Remove()
    var cursor = getcurpos()
    var s_left = ""
    var s_right = ""
    var start = []
    var end = []
    if s_text == 's'
        var pos_list = []

        # XXX: probing all chars is quite slow in a large buffer (>6k lines)
        # # get deduplicated chars from pairs
        # # TODO: remove "duplicates" as ' and ''' or " and """
        # var pair_chars = pairs->items()
        #     ->mapnew((_, v) => [v[0], trim(v[1][0]) .. trim(v[1][1])])
        #     ->sort((v1, v2) => v1[1] == v2[1] ? 0 : v1[1] > v2[1] ? 1 : -1)
        #     ->uniq((v1, v2) => v1[1] == v2[1] ? 0 : v1[1] > v2[1] ? 1 : -1)
        #     ->mapnew((_, v) => v[0])

        var pair_chars = '({[<*_/`''"'

        for char in pair_chars
            var pair = get(pairs, char, ())
            s_left = empty(pair) ? char : trim(pair[0])
            s_right = empty(pair) ? char : trim(pair[1])
            # XXX: profile perfomance.
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
    var indent_lines = end[0] - start[0]

    if start[0] == cursor[1] && end[0] == cursor[1]
        end[1] -= strchars(s_left)
    endif
    if getline('.') =~ $'\V\^\s\*{escape(s_left, '\')}\$'
        normal! "_dd
        end[0] -= 1
    else
        exe $'normal! {strcharlen(s_left)}"_x'
    endif
    cursor(end)
    if getline('.') =~ $'\V\^\s\*{escape(s_right, '\')}\$'
        normal! "_dd
        end[0] -= 1
    else
        exe $'normal! {strcharlen(s_right)}"_x'
    endif
    if indent_lines >= 1
            && (s_left =~ '[([{]' || s_text == 't')
            && ShouldIndent()
        exe $":{start[0]}"
        exe $":silent normal! {end[0] - start[0] + 2}=="
    endif
    cursor(start)
enddef


def ProbePair(s_left: string, s_right: string): list<list<number>>
    var view = winsaveview()
    defer () => {
        winrestview(view)
    }()

    if trim(s_left) != trim(s_right)
        var start = []
        var start1 = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'cnbW')
        var start2 = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'nbW')
        var end = []
        var end1 = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'nW')
        var end2 = searchpairpos('\V' .. escape(s_left, '\'), '', '\V' .. escape(s_right, '\'), 'cnW')
        if start1[0] > start2[0]
            start = start1
        elseif start1[0] < start2[0]
            start = start2
        elseif start1[1] > start2[1]
            start = start1
        else
            start = start2
        endif
        if end2 == [0, 0]
            end = end1
        elseif end1[0] > end2[0]
            end = end2
        elseif end1[0] < end2[0]
            end = end1
        elseif end1[1] > end2[1]
            end = end2
        else
            end = end1
        endif

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
        var start = searchpos('\V' .. escape(s_left, '\'), 'ncbW', line('.'))
        var end = searchpos('\V' .. escape(s_right, '\'), 'nW', line('.'))
        if start != [0, 0] && end == [0, 0]
            end = deepcopy(start)
            start = searchpos('\V' .. escape(s_left, '\'), 'nbW', line('.'))
        endif

        if start != [0, 0] && end != [0, 0] && start != end
            return [start, end]
        else
            return [[], []]
        endif
    endif
enddef

def ProbeTag(): tuple<list<number>, list<number>, string, string>
    var view = winsaveview()
    var unnamed = getreg("")
    defer () => {
        winrestview(view)
        setreg("", unnamed)
    }()

    var s_left = ''
    var s_right = ''
    var tagregion = []
    try
        noautocmd normal! yat
        var start = getpos("'[")
        var end = getpos("']")

        var line = getline(end[1])[ : end[2] - 1]
        s_right = matchstr(line, '</\S\{-}>$')
        line = getline(start[1])[start[2] - 1 :]
        s_left = matchstr(line, '^<[^[:punct:][:space:]].\{-}>')

        if !empty(s_left) && !empty(s_right)
            end[2] -= (strcharlen(s_right) - 1)
            return (start[1 : 2], end[1 : 2], s_left, s_right)
        endif
    catch
    finally
        exe "normal! \<esc>"
    endtry
    return ([], [], '', '')
enddef
