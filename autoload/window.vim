vim9script

export def BotRight(): string
    var res = "botright "
    if &columns * 0.6 < winwidth(winnr()) && &columns > 99
        res = "vertical " .. res
    endif
    return res
enddef

# close other windows:
# - popup windows
# - fugitive status
# - terminals
# - location lists
# - quickfix
# - preview
export def CloseThem()
    if !empty(popup_list())
        popup_clear(true)
        return
    endif

    var fugitive_closed = false
    for window in getwininfo()->filter((_, v) => v.variables->has_key("fugitive_status"))
        win_execute(window.winid, "silent! wincmd c")
        fugitive_closed = true
    endfor
    if fugitive_closed
        return
    endif

    var term_closed = false
    for window in getwininfo()->filter((_, v) => v.terminal == 1)
        win_execute(window.winid, "silent! wincmd c")
        term_closed = true
    endfor
    if term_closed
        return
    endif

    var loc_closed = false
    for window in getwininfo()->filter((_, v) => v.loclist == 1)
        win_execute(window.winid, "lclose")
        loc_closed = true
    endfor
    if loc_closed
        return
    endif

    for window in getwininfo()->filter((_, v) => v.quickfix == 1)
        cclose
        return
    endfor
    pclose
enddef
