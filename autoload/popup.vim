vim9script

# Returns winnr of created popup window
export def ShowAtCursor(text: any): number
    var winnr = popup_atcursor(text, {
            padding: [0, 1, 0, 1],
            border: [],
            # borderchars: ['━', '┃', '━', '┃', '┏', '┓', '┛', '┗'],
            borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
            pos: "botleft",
            filter: "PopupFilter",
            filtermode: 'n',
            mapping: 0
          })
    return winnr
enddef

def PopupFilter(winid: number, key: string): bool
    if key == "\<Space>"
        win_execute(winid, "normal! \<C-d>\<C-d>")
        return true
    endif
    if key == "j"
        win_execute(winid, "normal! \<C-d>")
        return true
    endif
    if key == "k"
        win_execute(winid, "normal! \<C-u>")
        return true
    endif
    if key == "\<ESC>"
        popup_close(winid)
        return true
    endif
    return true
enddef
