vim9script

export def Line(nr: number = line("."), duration: number = 300, hlgroup: string = "CursorLine")
    var m = matchaddpos(hlgroup, [nr])
    var winid = win_getid()
    timer_start(duration, (_) => m->matchdelete(winid))
enddef
