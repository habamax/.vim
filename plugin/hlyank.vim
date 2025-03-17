vim9script

def HighlightedYank(hlgroup = 'Pmenu', duration = 250)
    if v:event.operator !=? 'y' | return | endif
    # if clipboard has autoselect (default on linux) exiting from Visual with ESC
    # generates bogus event and this highlights previous yank
    if v:event.regname == "*" && v:event.visual | return | endif

    var type = v:event.regtype ?? 'v'
    var pos = getregionpos(getpos("'["), getpos("']"), {type: type, exclusive: false})
    var hlpos = pos->mapnew((_, v) => {
            var col_beg = v[0][2] + v[0][3]
            var col_end = v[1][2] + v[1][3] + 1
            return [v[0][1], col_beg, col_end - col_beg]
    })
    if hlpos->len() > 0
        var m = matchaddpos(hlgroup, hlpos)
        timer_start(duration, (_) => m->matchdelete(win_getid()))
    endif
enddef

augroup hlyank | au!
    autocmd TextYankPost * HighlightedYank()
augroup END
