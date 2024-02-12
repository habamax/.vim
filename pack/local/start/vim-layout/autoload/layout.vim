vim9script

const layout_max = 20

var layout_index = -1
var layouts = []
var resize_cmds = []
var views = []

var is_restoring_layout = false
var prev_event = ''

def AddBuf(layout: list<any>)
    if layout[0] ==# 'leaf'
        layout[1] = winbufnr(layout[1])
    else
        for child_layout in layout[1]
            AddBuf(child_layout)
        endfor
    endif
enddef

def Apply(layout: list<any>)
    if layout[0] ==# 'leaf'
        if bufexists(layout[1])
            exe printf('b %d', layout[1])
        endif
    else
        # split cols or rows, split n-1 times
        var split_method = layout[0] ==# 'col' ? 'rightbelow split' : 'rightbelow vsplit'
        var wins = [win_getid()]
        for child_layout in layout[1][1 : ]
            exe split_method
            wins += [win_getid()]
        endfor

        # recursive into child windows
        for index in range(len(wins) )
            win_gotoid(wins[index])
            Apply(layout[1][index])
        endfor
    endif
enddef

export def Save(event: string = '')
    if is_restoring_layout
        return
    endif

    var restcmd = winrestcmd()
    var layout = winlayout()
    var view = winsaveview()

    if !empty(layouts) && layout == layouts[-1] # && restcmd == resize_cmds[-1]
        return
    endif

    AddBuf(layout)

    # if previous event was WinNew and Current event is BufEnter (like split
    # fires 2 of them) delete previous
    if event == "BufEnter" && prev_event == "WinNew"
        remove(layouts, -1)
        remove(resize_cmds, -1)
        remove(views, -1)
    endif
    prev_event = event

    add(layouts, layout)
    add(resize_cmds, restcmd)
    add(views, [winnr(), view])

    if len(layouts) > layout_max
        remove(layouts, 0)
        remove(resize_cmds, 0)
        remove(views, 0)
    endif

    layout_index = len(layouts) - 1
enddef

export def Restore(direction: number)
    is_restoring_layout = true
    try
        if empty(layouts)
            return
        endif

        layout_index += direction
        if layout_index < 0
            layout_index = 0
            return
        endif
        if layout_index >= len(layouts)
            layout_index = len(layouts) - 1
            return
        endif

        silent wincmd o

        Apply(layouts[layout_index])

        exe resize_cmds[layout_index]

        exe printf(":noautocmd :%dwincmd w", views[layout_index][0])
        winrestview(views[layout_index][1])
    finally
        is_restoring_layout = false
    endtry
enddef
