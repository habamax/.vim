vim9script

export def EditInTab(name: string)
    var bufinfo = getbufinfo(name)
    if bufinfo->empty() || bufinfo[0].windows->empty()
        if bufname()->empty() && (&hidden || !&modified)
            exe $"e {name}"
        else
            exe $"tabe {name}"
        endif
    else
        win_gotoid(bufinfo[0].windows[0])
    endif
enddef
