vim9script

# Maintainer: Maxim Kim <habamax@gmail.com>
# Last Update: 2026-07-20

# Surround/Remove surround with.
var s_with: dict<any> = {}
# Change surround with.
var c_with: dict<any> = {}
# If block selection is done with $
var visual_dollar: bool = false

# how many times to surround, e.g. 2yssB
var vcount: number = 1

# To prevent asking for surround char in every repetition of a dot command, e.g.
# ysiw( followed by . should surround with ( as well, not ask for a char again.
var dotrepeat = false

# save view before Adding surround, to restore if Add operation is canceled with
# <ESC>
var cancel_view = {}

var base_pairs = {
    ' ': {pair: (' ', ' '), newline: 1},
    'b': ('(', ')'),
    '(': {pair: ('( ', ' )'), newline: 1, trim: 1},
    ')': {pair: ('(', ')'), newline: -1},
    'B': ('{', '}'),
    '{': {pair: ('{ ', ' }'), newline: 1, trim: 1},
    '}': {pair: ('{', '}'), newline: -1},
    '[': {pair: ('[ ', ' ]'), newline: 1, trim: 1},
    ']': {pair: ('[', ']'), newline: -1},
    '<': {pair: ('< ', ' >'), newline: 1, trim: 1},
    '>': {pair: ('<', '>'), newline: -1},
    '"': {pair: ('"', '"'), newline: -1},
    "'": {pair: ("'", "'"), newline: -1},
    "`": {pair: ('`', '`'), newline: -1},
    '*': {pair: ('*', '*'), newline: -1},
    '_': {pair: ('_', '_'), newline: -1},
    '/': {pair: ('/', '/'), newline: -1},
    't': {probe: "tag", input: "Tag: ", pair: ("<__INPUT__>", "</__INPUT[0]__>"), newline: 1},
    'f': {probe: "func", input: "Function: ", pair: ("__INPUT__CAMEL__(", ")")},
    'F': {probe: "func", input: "Function: ", pair: ("__INPUT__CAMEL__( ", " )")},
}

extend(base_pairs, get(g:, "surround_pairs", {}))

def Pairs(): dict<any>
    return extendnew(base_pairs, get(b:, "surround_pairs", {}))
        ->filter((k, v) => {
            return typename(k) == 'string'
                && strcharlen(k) == 1
                && (typename(v) == 'tuple<string, string>'
                || typename(v) == 'dict<any>')
        })
enddef

def Pair(char: string, adding: bool = true): dict<any>
    var pairs = Pairs()
    var pair = get(pairs, char, ())
    if typename(pair) == 'tuple<string, string>'
        return {
            left: adding ? pair[0] : trim(pair[0]),
            right: adding ? pair[1] : trim(pair[1]),
            newline: 0
        }
    elseif typename(pair) == 'dict<any>'
        var res = {
            left: pair.pair[0],
            right: pair.pair[1],
            newline: get(pair, "newline", 0)
        }
        if adding && get(pair, "input", null) != null
            var in = input(pair.input)
            if empty(trim(in))
                return {}
            else
                res.left = substitute(res.left, '__INPUT__SNAKE__',
                    substitute(trim(in), '\s\+', '_', 'g'), 'g')
                res.left = substitute(res.left, '__INPUT__CAMEL__',
                    substitute(trim(in), '\(\w\)\s\+\(\w\)', '\1\U\2', 'g'), 'g')
                res.left = substitute(res.left, '__INPUT__', in, 'g')
                res.right = substitute(res.right, '__INPUT__SNAKE__',
                    substitute(trim(in), '\s\+', '_', 'g'), 'g')
                res.right = substitute(res.right, '__INPUT__CAMEL__',
                    substitute(trim(in), '\(\w\)\s\+\(\w\)', '\1\U\2', 'g'), 'g')
                res.right = substitute(res.right, '__INPUT__', in, 'g')
                res.left = substitute(res.left, '__INPUT\[\(\d\+\)\]__', '\=split(in)[submatch(1)->str2nr()]', 'g')
                res.right = substitute(res.right, '__INPUT\[\(\d\+\)\]__', '\=split(in)[submatch(1)->str2nr()]', 'g')
            endif
        else
            res.probe = get(pair, "probe", "pair")
            res.left = substitute(res.left, '__INPUT__\(SNAKE\|CAMEL\)__', '', 'g')
            res.left = substitute(res.left, '__INPUT\(\[\d\+\]\)\?__', '', 'g')
            res.right = substitute(res.right, '__INPUT__\(SNAKE\|CAMEL\)__', '', 'g')
            res.right = substitute(res.right, '__INPUT\(\[\d\+\]\)\?__', '', 'g')
            if !adding && get(pair, "trim", 0) == 1
                res.left = res.left->trim()
                res.right = res.right->trim()
            endif
        endif
        return res
    endif
    if empty(pair) && char =~ '[[:punct:][:blank:]]'
        return {
            left: char,
            right: char,
            newline: 0
        }
    else
        return {}
    endif
enddef

export def Add(): string
    if !&l:modifiable
        echohl ErrorMsg
        echomsg "E21: Cannot make changes, 'modifiable' is off"
        echohl NONE
        return ''
    endif
    dotrepeat = false
    cancel_view = winsaveview()
    visual_dollar = getcursorcharpos()[-1] == v:maxcol
    vcount = v:count1
    &opfunc = (mode) => AddSurround(mode)
    if mode() == 'n'
        return ":\<C-U>\<CR>g@"
    else
        return "g@"
    endif
enddef

export def Remove(): string
    if !&l:modifiable
        echohl ErrorMsg
        echomsg "E21: Cannot make changes, 'modifiable' is off"
        echohl NONE
        return ''
    endif
    vcount = 1
    dotrepeat = false
    &opfunc = (_) => RemoveSurround()
    return 'g@l'
enddef

export def Change(): string
    if !&l:modifiable
        echohl ErrorMsg
        echomsg "E21: Cannot make changes, 'modifiable' is off"
        echohl NONE
        return ''
    endif
    vcount = 1
    dotrepeat = false
    &opfunc = (_) => ChangeSurround()
    return 'g@l'
enddef

def ShouldIndent(): bool
    return !empty(&indentexpr) || &cindent
enddef

def AddSurround(mode: string, pos_start: list<number> = getpos("'["), pos_end: list<number> = getpos("']")): bool
    var save_selection = &selection
    var save_lazyredraw = &lazyredraw
    var save_virtualedit = &l:virtualedit
    var save_indentkeys = &l:indentkeys
    var save_cinkeys = &l:cinkeys
    var save_autoindent = &l:autoindent
    var save_comments = &l:comments
    set selection=inclusive
    set lazyredraw
    setlocal virtualedit=block
    setlocal indentkeys=
    setlocal cinkeys=
    setlocal autoindent
    setlocal comments=
    defer () => {
        &selection = save_selection
        &lazyredraw = save_lazyredraw
        &l:virtualedit = save_virtualedit
        &l:indentkeys = save_indentkeys
        &l:cinkeys = save_cinkeys
        &l:autoindent = save_autoindent
        &l:comments = save_comments
    }()

    if !dotrepeat
        dotrepeat = true
        var char = getcharstr(-1, {cursor: 'keep'})
        if char == "\<Esc>" || char == "\<CR>"
            winrestview(cancel_view)
            return false
        endif
        s_with = {trigger: char, pair: Pair(char)}
    endif

    if empty(s_with.pair)
        return false
    endif

    var start = pos_start
    var end = pos_end

    var s_left = s_with.pair.left
    var s_right = s_with.pair.right

    var s_tab = s_with.pair.left == "\<tab>" ? "\<C-v>" : ''

    # Handle case with v$S(. when selection is started in the middle of the
    # line. Start/end positions are incorrect in dot-repeating.
    var end_len = strlen(getline(end[1]))
    if visual_dollar && start[1] == end[1] && start[2] == 1 && end[2] != end_len
        start = deepcopy(end)
        end[2] = end_len
    endif

    var s_mode = mode
    if mode == 'line' && start[1] == end[1] && s_with.pair.newline != 1
        s_mode = 'char'
        noautocmd normal! _
        start = getpos('.')
        noautocmd normal! g_
        end = getpos('.')
    elseif mode == 'line' && s_with.pair.newline == -1
        s_mode = 'char'
        noautocmd normal! _
        start = getpos('.')
        setpos('.', end)
        noautocmd normal! g_
        end = getpos('.')
    elseif mode == 'line'
        s_left = trim(s_left)
        s_right = trim(s_right)
    endif

    s_left = trim(s_left, "\n")
    s_right = trim(s_right, "\n")

    if s_mode == 'char'
        StrAddAroundRegion(start, end, repeat(s_left, vcount), repeat(s_right, vcount))
        start[2] += vcount * strlen(s_left)
        setpos('.', start)
    elseif s_mode == 'line'
        exe $":noautocmd :{start[1]}normal! {vcount}O{s_left}"
        exe $":noautocmd :{end[1]}normal! {vcount}j{vcount}o{s_right}"
        if (s_left =~ '[([{]' || s_right =~ '</.\{-}>')
                && ShouldIndent()
            exe $":{start[1]}"
            exe $":silent noautocmd normal! {end[1] - start[1] + vcount * 2 + 1}=="
        endif
        exe $":{start[1] + vcount}"
        exe ":noautocmd normal! _"
    elseif s_mode == "block"
        if visual_dollar
            ## XXX: this approach needs to be investigated
            ## Basically I need to find chunks of contiguous lines where start < virtcol of end line
            ## and run following for each chunk.
            ## All to prevent unnesessary empty surrounds and handling of tabs

            # setcursorcharpos(start[1 :])
            # exe $"noautocmd normal! \<C-v>"
            # setcursorcharpos(end[1 :])
            # exe $"noautocmd normal! I{s_tab}{s_left}"
            # setcursorcharpos(start[1 :])
            # exe "noautocmd normal! \<C-v>"
            # setcursorcharpos(end[1 :])
            # noautocmd normal! $
            # exe $"noautocmd normal! A{s_tab}{s_right}"

            for nr in range(start[1], end[1])
                if strchars(getline(nr)) >= start[2]
                    setcursorcharpos(nr, start[2])
                    var squeeze = ""
                    if getline(nr)[ : start[2] - 1] =~ '^\s*$'
                        squeeze = "_"
                    endif
                    exe $"noautocmd normal! {squeeze}\<C-v>$"
                    exe $"noautocmd normal! I{s_tab}{repeat(s_left, vcount)}"
                    exe "noautocmd normal! \<C-v>$"
                    exe $"noautocmd normal! A{s_tab}{repeat(s_right, vcount)}"
                endif
            endfor
            setpos('.', start)
            exe "noautocmd normal! \<C-v>"
            setpos('.', end)
            exe "noautocmd normal! $\<ESC>"
            start[2] += strlen(s_left)
            setpos('.', start)
        else
            # better undo -- first change should be in the block begining
            # Add letter X and then delete it.
            noautocmd normal! iX
            noautocmd normal! x

            setlocal virtualedit=all
            var line = getline(start[1])
            setline(start[1], line .. repeat(' ', start[2] + start[3] - strlen(line)))
            line = getline(end[1])
            setline(end[1], line .. repeat(' ', end[2] + end[3] - strlen(line)))
            setpos('.', start)
            exe "noautocmd normal! \<C-v>"
            setpos('.', end)
            exe $"noautocmd normal! A{s_tab}{repeat(s_right, vcount)}"
            noautocmd normal! gv
            exe $"noautocmd normal! I{s_tab}{repeat(s_left, vcount)}"

            end[2] += vcount * strlen(s_left)
            setpos('.', end)
            exe "noautocmd normal! \<C-v>"
            start[2] += vcount * strlen(s_left)
            setpos('.', start)
            exe "noautocmd normal! \<ESC>"
        endif
    endif
    return true
enddef

def ProbeSurround(): dict<any>
    var pos = {}
    var pair = {}
    if s_with.trigger == 's'
        var pair_chars = ')}]"`'''
        var pos_list = []
        for char in pair_chars
            var s_pair = Pair(char, false)
            var s_pos = ProbePair(s_pair)
            if !empty(s_pos)
                add(pos_list, {pos: s_pos, pair: s_pair})
            endif
        endfor
        if empty(pos_list)
            return {}
        endif
        var closest = pos_list->sort((v1, v2) => {
            if v1.pos.start[1] == v2.pos.start[1]
                return v1.pos.start[2] == v2.pos.start[2] ? 0 : v1.pos.start[2] > v2.pos.start[2] ? 1 : -1
            elseif v1.pos.start[1] > v2.pos.start[1]
                return 1
            else
                return -1
            endif
        })[-1]
        pos = {
            start: closest.pos.start,
            end: closest.pos.end,
            left: closest.pair.left,
            right: closest.pair.right
        }
    else
        pair = Pair(s_with.trigger, false)
        if get(pair, 'probe', "pair") == "tag"
            pos = ProbeTag()
        elseif get(pair, 'probe', "pair") == "func"
            pos = ProbeFunc(pair)
        else
            pos = ProbePair(pair)
        endif
    endif

    if empty(pos)
        return {}
    endif

    return pos
enddef

def RemoveSurround()
    var save_selection = &selection
    var save_lazyredraw = &lazyredraw
    var save_clipboard = &clipboard
    var save_virtualedit = &l:virtualedit
    set selection=inclusive
    set lazyredraw
    set clipboard=
    setlocal virtualedit=none
    defer () => {
        &selection = save_selection
        &clipboard = save_clipboard
        &l:virtualedit = save_virtualedit
        &lazyredraw = save_lazyredraw
    }()

    if !dotrepeat
        dotrepeat = true
        var char = getcharstr(-1, {cursor: 'keep'})
        if char == "\<Esc>" || char == "\<CR>"
            return
        endif
        if char == 's'
            s_with.pair = {left: char}
        else
            s_with.pair = Pair(char, false)
        endif
        s_with.trigger = char
    endif

    var pos = ProbeSurround()
    if empty(pos)
        return
    endif

    var indent_lines = pos.end[1] - pos.start[1]

    StrRemoveAroundRegion(pos.start, pos.end, pos.left, pos.right)
    if getline(pos.end[1]) =~ '^\s*$'
        setpos('.', pos.end)
        noautocmd normal! "_dd
    endif
    if getline(pos.start[1]) =~ '^\s*$'
        setpos('.', pos.start)
        noautocmd normal! "_dd
    endif
    if indent_lines >= 1
            && (pos.left =~ '[([{]' || s_with.trigger == 't')
            && ShouldIndent()
        exe $":{pos.start[1]}"
        exe $":silent noautocmd normal! {pos.end[1] - pos.start[1] - 1}=="
    endif

    setpos('.', pos.start)
enddef

def ChangeSurround()
    if !dotrepeat
        dotrepeat = true
        var char = getcharstr(-1, {cursor: 'keep'})
        if char == "\<Esc>" || char == "\<CR>"
            return
        endif
        s_with.trigger = char
        s_with.pair = Pair(char, false)

        char = getcharstr(-1, {cursor: 'keep'})
        if char == "\<Esc>" || char == "\<CR>"
            return
        endif
        c_with.trigger = char
        c_with.pair = Pair(char)
    endif

    var pos = ProbeSurround()
    if empty(pos)
        return
    endif
    var with = s_with->deepcopy()
    s_with = c_with->deepcopy()
    if AddSurround('char', pos.start, [pos.end[0], pos.end[1], pos.end[2] + strlen(pos.right) - 1])
        s_with = with->deepcopy()
        RemoveSurround()
    endif
enddef

def SkipEscaped(): bool
    var line = getline(line('.'))[ : col('.') - 2]
    var escaped = matchstr(line, '\\*$')
    return fmod(len(escaped), 2) > 0
enddef

def ProbePair(pair: dict<any>): dict<any>
    if empty(pair)
        return {}
    endif
    var view = winsaveview()
    var unnamed = getreg("")
    defer () => {
        setreg("", unnamed)
        winrestview(view)
    }()
    var start = []
    var end = []
    var cur = getpos('.')

    if trim(pair.left) != trim(pair.right)
        noautocmd normal! yl
        var char = getreg("")
        var flags = 'bW'
        if stridx(pair.left, char) != -1
            flags ..= 'c'
        endif
        if searchpair($'\V{escape(pair.left, '\')}', '', $'\V{escape(pair.right, '\')}', flags, () => SkipEscaped()) > 0
            start = getpos('.')
            # TODO: ignore pairs in strings?
            # can't remove surround here: (s == '(')
            if searchpair($'\V{escape(pair.left, '\')}', '', $'\V{escape(pair.right, '\')}', 'W', () => SkipEscaped()) > 0
                end = getpos('.')
            endif
        endif

        if empty(start) || empty(end)
            return {}
        endif
        return {
            start: start,
            left: pair.left,
            end: end,
            right: pair.right
        }
    else
        if search($'\V{escape(pair.left, '\')}', 'W', line('.'), 200, () => SkipEscaped()) <= 0
            if search($'\V{escape(pair.left, '\')}', 'cW', line('.'), 200, () => SkipEscaped()) <= 0
                return {}
            endif
        endif
        end = getpos('.')
        if search('\V' .. escape(pair.right, '\'), 'bW', line('.'), 200, () => SkipEscaped()) <= 0
            return {}
        endif
        start = getpos('.')

        if start != end
            return {
                start: start,
                left: pair.left,
                end: end,
                right: pair.right
            }
        else
            return {}
        endif
    endif
enddef

def ProbeFunc(pair: dict<any>): dict<any>
    var view = winsaveview()
    var unnamed = getreg("")
    defer () => {
        winrestview(view)
        setreg("", unnamed)
    }()

    var left = trim(pair.left)[-1]
    var leftPrefix = trim(pair.left)[-2]
    var right = trim(pair.right)[-1]
    if left !~ '[{(\[]' && right !~ '[})\]]'
        return {}
    endif

    if expand("<cWORD>") =~ $'\V\k\+{left}'
        var save_pos = getpos('.')
        search($'\V{left}\|{right}', '', line('.'))
        if getline('.')->strpart(save_pos[2], col('.') - save_pos[2]) =~ '\s'
            setpos('.', save_pos)
        endif
    endif

    var cursor = getpos('.')

    exe $"noautocmd normal! ya{left}"
    var count = 1
    while !empty(getreg(""))
        var start = getpos("'[")
        var end = getpos("']")

        var line = getline(end[1])[ : end[2] - 1]
        var s_right = right
        line = getline(start[1])[: start[2] - 1]
        var s_left = matchstr(line, $'\V{escape(leftPrefix, '\')}\k\+{left}\$')

        if !empty(s_right) && !empty(s_left)
            end[2] -= (strlen(s_right) - 1)
            start[2] -= (strlen(s_left) - 1)
            return {
                start: start,
                left: s_left,
                end: end,
                right: s_right
            }
        endif
        count += 1
        setreg("", "")
        setpos('.', cursor)
        exe $"noautocmd normal! {count}ya{left}"
    endwhile
    return {}
enddef

def ProbeTag(): dict<any>
    var view = winsaveview()
    var unnamed = getreg("")
    defer () => {
        winrestview(view)
        setreg("", unnamed)
    }()

    noautocmd normal! yat
    var start = getpos("'[")
    var end = getpos("']")

    var line = getline(end[1])->strpart(0, end[2])
    var s_right = matchstr(line, '</[^<]\{-}>$')
    line = getline(start[1])->strpart(start[2] - 1)
    var s_left = matchstr(line, '^<[^[:punct:][:space:]].\{-}>')

    if !empty(s_right) && !empty(s_left)
        end[2] -= (strlen(s_right) - 1)
        return {
            start: start,
            left: s_left,
            end: end,
            right: s_right
        }
    endif
    return {}
enddef

def StrInsert(src_str: string, src_idx: number, ins_str: string, append: bool = false): string
    var idx = append ? src_idx + strlen(matchstr(src_str, '.', src_idx)) : src_idx
    var str_before = src_str->strpart(0, idx)
    var str_after = src_str->strpart(idx)
    return str_before .. ins_str .. str_after
enddef

def StrRemove(src_str: string, src_idx: number, rem_str: string): string
    var result = src_str->strpart(0, src_idx)
    result ..= src_str->strpart(src_idx + strlen(rem_str))
    return result
enddef

def StrAddAroundRegion(pos_start: list<number>, pos_end: list<number>, sur_start: string, sur_end: string)
    var col_start = pos_start[2] - 1
    var col_end = (pos_start[1] == pos_end[1] ? pos_end[2] + strlen(sur_start) : pos_end[2]) - 1
    setline(pos_start[1], StrInsert(getline(pos_start[1]), col_start, sur_start))
    setline(pos_end[1], StrInsert(getline(pos_end[1]), col_end, sur_end, true))
enddef

def StrRemoveAroundRegion(pos_start: list<number>, pos_end: list<number>, sur_start: string, sur_end: string)
    var col_start = pos_start[2] - 1
    var col_end = pos_end[2] - 1
    setline(pos_end[1], StrRemove(getline(pos_end[1]), col_end, sur_end))
    setline(pos_start[1], StrRemove(getline(pos_start[1]), col_start, sur_start))
enddef
