vim9script

# Maintainer: Maxim Kim <habamax@gmail.com>
# Last Update: 2026-07-18

# Align with
var with: string = ""

# Align up to how many occurences (0 == all)
var vcount: number = 0

# Align after the occurence (add spaces after)
var space_after: bool = false

# If block selection is done with $
var visual_dollar: bool = false

# If operation is repeated with dot
var dotrepeat = false

export def Op(after: bool = false): string
    if !&l:modifiable
        echohl ErrorMsg
        echomsg "E21: Cannot make changes, 'modifiable' is off"
        echohl NONE
        return ''
    endif
    dotrepeat = false
    visual_dollar = getcursorcharpos()[-1] == v:maxcol
    vcount = v:count
    space_after = after
    &opfunc = (mode) => Align(mode)
    if mode() == 'n'
        return ":\<C-U>\<CR>g@"
    else
        return "g@"
    endif
enddef

def Align(mode: string, pos_start: list<number> = getcharpos("'["), pos_end: list<number> = getcharpos("']"))
    var save_lazyredraw = &lazyredraw
    set lazyredraw
    defer () => {
        &lazyredraw = save_lazyredraw
    }()

    if !dotrepeat
        var char = getcharstr(-1, {cursor: 'keep'})
        if char == "\<Esc>" || char == "\<CR>"
            return
        endif
        if char == '/'
            var regex = input("Pattern: ")
            if empty(trim(regex))
                return
            endif
            with = regex
        elseif char == ' '
            with = '\V\S\s\+\zs'
        else
            with = '\V\C' .. char
        endif
        dotrepeat = true
    endif

    # hello = w = 10 = is = here
    # h = wo = 100 = isnt = here
    # he = wor = 1000 = is bla = here
    # hel = worl = 10000 = isabella = here

    if mode != 'block'
        var [lnum_start, lnum_end] = AdjustRange(pos_start, pos_end)
        if lnum_start == lnum_end
            return
        endif

        var step = 1
        while true
            var lpositions = LPositions(lnum_start, lnum_end, step)
            if !AlignRange(lnum_start, lnum_end, lpositions)
                break
            endif
            if vcount == step
                break
            endif
            step += 1
        endwhile
    else
        if visual_dollar
        else
        endif
    endif
enddef

def AdjustRange(start: list<number>, end: list<number>): list<number>
    var lnum_start = start[1]
    var lnum_end = end[1]
    if lnum_start == lnum_end && getline(lnum_start) !~ '^\s*$'
        var indent = indent(lnum_start)
        while lnum_start > 1 && getline(lnum_start - 1) !~ '^\s*$' && indent(lnum_start - 1) >= indent
            lnum_start -= 1
        endwhile
        while lnum_end < line('$') && getline(lnum_end + 1) !~ '^\s*$' && indent(lnum_end + 1) >= indent
            lnum_end += 1
        endwhile
    endif
    return [lnum_start, lnum_end]
enddef

def LPositions(lnum_start: number, lnum_end: number, count: number): list<any>
    var longest = -1
    var positions = []
    for nr in range(lnum_start, lnum_end)
        var line = getline(nr)
        var pos = match(line, with, 0, count)
        if space_after && pos != -1
            pos = match(line, '\S', pos + 1)
        endif
        positions += [pos]
        if pos != -1
            longest = max([longest, virtcol([nr, pos])])
        endif
    endfor
    return [longest, positions]
enddef

def AlignRange(lnum_start: number, lnum_end: number, lpositions: list<any>): bool
    var longest = lpositions[0]
    if longest == -1
        return false
    endif
    var positions = lpositions[1]
    for nr in range(lnum_start, lnum_end)
        var pos = positions[nr - lnum_start]
        var vpos = virtcol([nr, pos])
        if pos == -1 || vpos == -1
            continue
        endif
        var line = getline(nr)
        var space = repeat(' ', longest - vpos)
        setline(nr, line->strpart(0, pos) .. space .. line->strpart(pos))
    endfor
    return true
enddef
