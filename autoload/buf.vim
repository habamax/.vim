vim9script

export def EditInTab(name: string)
    var jbuf = getbufinfo(name)
    if jbuf->empty() || jbuf[0].windows->empty()
        exe $"tabe {name}"
    else
        win_gotoid(jbuf[0].windows[0])
    endif
enddef
