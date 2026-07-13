vim9script

# Maintainer: Maxim Kim <habamax@gmail.com>
# Last Update: 2026-07-13

# Align with
var with: string = ""
# If block selection is done with $
var visual_dollar: bool = false

# If operation is repeated with dot
var dotrepeat = false

export def Op(): string
    if !&l:modifiable
        echohl ErrorMsg
        echomsg "E21: Cannot make changes, 'modifiable' is off"
        echohl NONE
        return ''
    endif
    dotrepeat = false
    visual_dollar = getcursorcharpos()[-1] == v:maxcol
    &opfunc = (mode) => Align(mode)
    return 'g@'
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
        else
            with = char
        endif
        dotrepeat = true
    endif

    var start = pos_start
    var end = pos_end

    if mode != 'block'
    else
        if visual_dollar
        else
        endif
    endif
enddef
