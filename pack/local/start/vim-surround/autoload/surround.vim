vim9script

# Maintainer: Maxim Kim <habamax@gmail.com>
# Last Update: 2026-07-01

# Surround/Remove surround with.
var s_with: dict<any> = {}
# Change surround with.
var c_with: dict<any> = {}
# If block selection is done with $
var visual_dollar: bool = false
# Filetypes with indent script to fix indent after surround
var filetypes = []

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
    't': {input: "Tag: ", tag: true, pair: ("<__INPUT__>", "</__INPUT[0]__>"), newline: 1},
    'f': {input: "Function: ", rxleft: '\<\k\+(', pair: ("__INPUT__(", ")")},
    'F': {input: "Function: ", rxleft: '\<\k\+( ', pair: ("__INPUT__( ", " )")},
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
    mess clear
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
                res.left = substitute(res.left, '__INPUT__', in, 'g')
                res.right = substitute(res.right, '__INPUT__', in, 'g')
                res.left = substitute(res.left, '__INPUT\[\(\d\+\)\]__', '\=split(in)[submatch(1)->str2nr()]', 'g')
                res.right = substitute(res.right, '__INPUT\[\(\d\+\)\]__', '\=split(in)[submatch(1)->str2nr()]', 'g')
            endif
        else
            res.tag = get(pair, "tag", false)
            res.left = substitute(res.left, '__INPUT\(\[\d\+\]\)\?__', '', 'g')
            res.right = substitute(res.right, '__INPUT\(\[\d\+\]\)\?__', '', 'g')
            if !adding && get(pair, "trim", 0) == 1
                res.left = res.left->trim()
                res.right = res.right->trim()
            endif
            res.rxleft = get(pair, "rxleft", res.left)
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
    &opfunc = (mode) => AddSurround(mode)
    return 'g@'
enddef

export def Remove(): string
    if !&l:modifiable
        echohl ErrorMsg
        echomsg "E21: Cannot make changes, 'modifiable' is off"
        echohl NONE
        return ''
    endif
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
    dotrepeat = false
    &opfunc = (_) => ChangeSurround()
    return 'g@l'
enddef

def ShouldIndent(): bool
    if empty(filetypes)
        filetypes = globpath(&rtp, 'indent/*.vim', 0, 1)
            ->mapnew((_, v) => fnamemodify(v, ':t:r'))
    endif
    return filetypes->index(&filetype) != -1
enddef

def AddSurround(mode: string, pos_start: list<number> = getcharpos("'["), pos_end: list<number> = getcharpos("']"))
    var save_lazyredraw = &lazyredraw
    var save_virtualedit = &l:virtualedit
    var save_indentkeys = &l:indentkeys
    var save_autoindent = &l:autoindent
    var save_comments = &l:comments
    set lazyredraw
    setlocal virtualedit=block
    setlocal indentkeys=
    setlocal autoindent
    setlocal comments=
    defer () => {
        &lazyredraw = save_lazyredraw
        &l:virtualedit = save_virtualedit
        &l:indentkeys = save_indentkeys
        &l:autoindent = save_autoindent
        &l:comments = save_comments
    }()

    if !dotrepeat
        dotrepeat = true
        var char = getcharstr(-1, {cursor: 'keep'})
        if char == "\<Esc>" || char == "\<CR>"
            winrestview(cancel_view)
            return
        endif
        s_with = {trigger: char, pair: Pair(char)}
    endif

    if empty(s_with.pair)
        return
    endif

    var start = pos_start
    var end = pos_end

    var s_left = s_with.pair.left
    var s_right = s_with.pair.right

    var s_tab = s_with.pair.left == "\<tab>" ? "\<C-v>" : ''

    # Handle case with v$S(. when selection is started in the middle of the
    # line. Start/end positions are incorrect in dot-repeating.
    var end_len = strcharlen(getline(end[1]))
    if visual_dollar && start[1] == end[1] && start[2] == 1 && end[2] != end_len
        start = deepcopy(end)
        end[2] = end_len
    endif

    var s_mode = mode
    if mode == 'line' && start[1] == end[1] && s_with.pair.newline != 1
        s_mode = 'char'
        noautocmd normal! _
        start = getcursorcharpos()
        noautocmd normal! g_
        end = getcursorcharpos()
    elseif mode == 'line' && s_with.pair.newline == -1
        s_mode = 'char'
        noautocmd normal! _
        start = getcursorcharpos()
        setcharpos('.', end)
        noautocmd normal! g_
        end = getcharpos('.')
    elseif mode == 'line'
        s_left = trim(s_left)
        s_right = trim(s_right)
    endif

    s_left = trim(s_left, "\n")
    s_right = trim(s_right, "\n")

    if s_mode == 'char'
        setlocal virtualedit=all
        setcharpos('.', start)
        if col('.') == col('$')
                || getline('.') =~ '^\s*$'
                || getline('.')[col('.') - 1] =~ '\s'
            s_left = trim(s_left)
        endif
        exe $"noautocmd normal! i{s_tab}{s_left}"
        setlocal virtualedit=none
        if start[1] == end[1]
            end[2] += strchars(s_left)
        endif
        start[2] += strchars(s_left)
        setcharpos('.', end)
        if getline('.') =~ '^\s*$' || getline('.')[col('.') - 1] =~ '\s'
            s_right = trim(s_right)
        endif
        if empty(getline(end[1]))
            setline(end[1], s_right)
        else
            exe $"noautocmd normal! a{s_tab}{s_right}"
        endif
        setcharpos('.', start)
    elseif s_mode == 'line'
        exe $":noautocmd :{start[1]}normal! O{s_left}"
        exe $":noautocmd :{end[1]}normal! jo{s_right}"
        if (s_left =~ '[([{]' || s_right =~ '</.\{-}>')
            && ShouldIndent()
            exe $":{start[1]}"
            exe $":silent noautocmd normal! {end[1] - start[1] + 2}=="
        endif
        exe $":{start[1] + 1}"
        exe ":noautocmd normal! _"
    elseif s_mode == "block"
        if visual_dollar
            for nr in range(start[1], end[1])
                if strchars(getline(nr)) >= start[2]
                    setcursorcharpos(nr, start[2])
                    var squeeze = ""
                    if getline(nr)[ : start[2] - 1] =~ '^\s*$'
                        squeeze = "_"
                    endif
                    exe $"noautocmd normal! {squeeze}\<C-v>$"
                    exe $"noautocmd normal! I{s_tab}{s_left}"
                    exe "noautocmd normal! \<C-v>$"
                    exe $"noautocmd normal! A{s_tab}{s_right}"

                endif
            endfor
            setcursorcharpos(start[1 :])
            exe "noautocmd normal! \<C-v>"
            setcursorcharpos(end[1 :])
            exe "noautocmd normal! $\<ESC>"
            start[2] += strchars(s_left)
            setcursorcharpos(start[1 :])
        else
            # better undo -- first change should be in the block begining
            # Add letter X and then delete it.
            noautocmd normal! iX
            noautocmd normal! x

            noautocmd normal! gv
            var v_pos = getregionpos(getpos("v"), getpos('.'), {mode: visualmode()})
            var v_start = v_pos[0][0]
            if v_start[1 : ] != start[1 : ]
                exe "noautocmd normal! \<ESC>"
                setlocal virtualedit=all
                # setcursorcharpos(...) can't navigate to an empty location
                MoveCursor(end[1], end[2] + end[3])
                if strchars(getline(end[1])) < end[2] + end[3]
                    exe "noautocmd normal! i\<space>"
                endif
                exe "noautocmd normal! \<C-v>"
                MoveCursor(start[1], start[2] + start[3])
            endif
            exe $"noautocmd normal! A{s_tab}{s_right}"
            noautocmd normal! gv
            exe $"noautocmd normal! I{s_tab}{s_left}"

            setcursorcharpos(end[1], end[2] + end[3] + strchars(s_left))
            exe "noautocmd normal! \<C-v>"
            setcursorcharpos(start[1], start[2] + start[3] + strchars(s_left))
            exe "noautocmd normal! \<ESC>"
        endif
    endif
enddef

def RemoveSurround(delete_empty_lines: bool = true): list<list<number>>
    var save_clipboard = &clipboard
    var save_virtualedit = &l:virtualedit
    set clipboard=
    setlocal virtualedit=none
    defer () => {
        &clipboard = save_clipboard
        &l:virtualedit = save_virtualedit
    }()

    if !dotrepeat
        dotrepeat = true
        var char = getcharstr(-1, {cursor: 'keep'})
        if char == "\<Esc>" || char == "\<CR>"
            return []
        endif
        if char == 's'
            s_with.pair = {left: char}
        else
            s_with.pair = Pair(char, false)
        endif
        s_with.trigger = char
    endif

    var view = winsaveview()
    var cursor = getcursorcharpos()
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
            return []
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
        pos = closest.pos
        pair = closest.pair
    else
        pair = Pair(s_with.trigger, false)
        if get(pair, 'tag', false)
            [pos, pair] = ProbeTag()
        else
            pos = ProbePair(pair)
        endif
    endif

    if empty(pos)
        winrestview(view)
        return []
    endif

    setcharpos('.', pos.start)
    var indent_lines = pos.end[0] - pos.start[0]

    if pos.start[1] == cursor[1] && pos.end[1] == cursor[1]
        pos.end[2] -= pos.startlen
    endif
    if delete_empty_lines && getline('.') =~ $'\V\^\s\*{escape(pair.left, '\')}\$'
        noautocmd normal! "_dd
        pos.end[1] -= 1
    else
        exe $'noautocmd normal! {pos.startlen}"_x'
    endif
    setcharpos('.', pos.end)
    if delete_empty_lines && getline('.') =~ $'\V\^\s\*{escape(pair.right, '\')}\$'
        noautocmd normal! "_dd
        pos.end[1] -= 1
    else
        var move_left = charcol('.') < charcol('$') - pos.endlen
        exe $'noautocmd normal! {pos.endlen}"_x'
        if move_left
            noautocmd normal! h
        endif
        pos.end[2] = charcol('.')
    endif
    if delete_empty_lines && indent_lines >= 1
            && (pair.left =~ '[([{]' || s_with.trigger == 't')
            && ShouldIndent()
        exe $":{pos.start[0] - 1}"
        exe $":silent noautocmd normal! {pos.end[1] - pos.start[1] + 2}=="
    endif
    winrestview(view)
    setcharpos('.', pos.start)

    return [pos.start, pos.end]
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

    var pos = RemoveSurround(false)
    var with = s_with->deepcopy()
    if !empty(pos)
        var [start, end] = pos
        if getline(start[1]) =~ '^\s*$'
            defer () => {
                noautocmd normal! 2_
            }()
        endif
        s_with = c_with->deepcopy()
        AddSurround('char', start, end)
        s_with = with->deepcopy()
    endif
enddef

def SkipEscaped(): bool
    var line = getline(line('.'))[ : col('.') - 2]
    var escaped = matchstr(line, '\\*$')
    return fmod(len(escaped), 2) > 0
enddef

def ProbePair(pair: dict<any>): dict<any>
    var view = winsaveview()
    var unnamed = getreg("")
    defer () => {
        setreg("", unnamed)
        winrestview(view)
    }()
    var rxleft = get(pair, "rxleft", pair.left)
    var startlen = strchars(pair.left)

    if trim(pair.left) != trim(pair.right)
        noautocmd normal! yl
        var char = getreg("")
        var flags = 'bW'
        if stridx(pair.right, char) != -1
            if search('\V' .. escape(pair.right, '\'), 'cbW', line('.')) == 0
                flags ..= 'c'
            endif
        else
            flags ..= 'c'
        endif
        if searchpair($'\V{rxleft}', '', '\V' .. escape(pair.right, '\'), flags, () => SkipEscaped()) <= 0
            return {}
        endif
        var start = getcursorcharpos()
        if search(rxleft, 'ce', line('.')) != -1
            startlen = (getcursorcharpos()[2] - start[2]) + 1
        endif

        if searchpair($'\V{rxleft}', '', '\V' .. escape(pair.right, '\'), 'W', () => SkipEscaped()) <= 0
            return {}
        endif
        var end = getcursorcharpos()
        return {
            start: start,
            startlen: startlen,
            end: end,
            endlen: strchars(pair.right)
        }
    else
        if search($'\V{rxleft}', 'bW', line('.'), 200, () => SkipEscaped()) <= 0
            if search($'\V{rxleft}', 'cbW', line('.'), 200, () => SkipEscaped()) <= 0
                return {}
            endif
        endif
        var start = getcursorcharpos()
        if search('\V' .. escape(pair.right, '\'), 'W', line('.'), 200, () => SkipEscaped()) <= 0
            return {}
        endif
        var end = getcursorcharpos()

        if start != [0, 0] && end != [0, 0] && start != end
            return {
                start: start,
                startlen: startlen,
                end: end,
                endlen: strchars(pair.right)
            }
        else
            return {}
        endif
    endif
enddef

def ProbeTag(): list<dict<any>>
    var view = winsaveview()
    var unnamed = getreg("")
    defer () => {
        winrestview(view)
        setreg("", unnamed)
    }()

    var tagregion = []
    try
        noautocmd normal! yat
        var start = getcharpos("'[")
        var end = getcharpos("']")

        var line = getline(end[1])[ : end[2] - 1]
        var s_right = matchstr(line, '</\S\{-}>$')
        line = getline(start[1])[start[2] - 1 :]
        var s_left = matchstr(line, '^<[^[:punct:][:space:]].\{-}>')

        if !empty(s_right) && !empty(s_left)
            end[2] -= (strchars(s_right) - 1)
            return [{
                start: start,
                startlen: strchars(s_left),
                end: end,
                endlen: strchars(s_right)
            }, {left: s_left, right: s_right}]
        endif
    catch
    finally
        exe "noautocmd normal! \<esc>"
    endtry
    return [{}, {}]
enddef

def MoveCursor(lnum: number, col: number)
    exe $":{lnum}"
    noautocmd normal! 0
    if col > 1
        exe $"noautocmd normal! {col - 1}l"
    endif
enddef
