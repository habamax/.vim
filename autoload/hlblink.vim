vim9script

export def Line(nr: number = line("."), duration: number = 300, hlgroup: string = "CursorLine")
    var beg = [bufnr(), nr, 1, 0]
    var end = [bufnr(), nr, col('$'), 0]
    var pos = getregionpos(beg, end, {type: 'v', exclusive: false})
    var m = matchaddpos(hlgroup, pos->mapnew((_, v) => {
        var col_beg = v[0][2] + v[0][3]
        var col_end = v[1][2] + v[1][3] + 1
        return [v[0][1], col_beg, col_end - col_beg]
    }))
    var winid = win_getid()
    timer_start(duration, (_) => m->matchdelete(winid))
enddef
