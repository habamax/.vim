vim9script

def HighlightedYank(hlgroup = 'Pmenu', duration = 250)
    if v:event.operator !=? 'y' | return | endif
    # if clipboard has autoselect (default on linux) exiting from Visual with ESC
    # generates bogus event and this highlights previous yank
    if v:event.regname == "*" && v:event.visual | return | endif

    var type = v:event.regtype ?? 'v'
    var pos = getregionpos(getpos("'["), getpos("']"), {type: type})
    var end_offset = (type == 'V' || v:event.inclusive) ? 1 : 0
    var m = matchaddpos(hlgroup, pos->mapnew((_, v) => {
        var col_beg = v[0][2] + v[0][3]
        var col_end = v[1][2] + v[1][3] + end_offset
        return [v[0][1], col_beg, col_end - col_beg]
    }))
    timer_start(duration, (_) => m->matchdelete(win_getid()))
enddef

augroup hlyank | au!
    autocmd TextYankPost * HighlightedYank()
augroup END
