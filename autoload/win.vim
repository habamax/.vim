"" Scroll other window mappings
func! win#scroll_other(dir) abort
    if winnr('$') < 2
        return
    endif
    wincmd w
    let cmd = "normal ".winheight(0)/2
    if a:dir
        let cmd .= "\<c-e>"
    else
        let cmd .= "\<c-y>"
    endif
    exe cmd
    wincmd p
endfunc
