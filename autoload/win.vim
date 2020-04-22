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


"" 4 layouts
"" layout 1: even horizontal
"" layout 2: even vertical
"" layout 3: main horizontal
"" layout 4: main vertical
func! win#toggle_layout() abort
    let win_layout = get(t:, "window_layout", 4)
    let winid = win_getid()

    if win_layout == 4
        windo wincmd L
        call win_gotoid(winid)
        let t:window_layout = 1
    elseif win_layout == 1
        windo wincmd K
        call win_gotoid(winid)
        let t:window_layout = 2
    elseif win_layout == 2
        windo wincmd L
        call win_gotoid(winid)
        wincmd K
        let t:window_layout = 3
    elseif win_layout == 3
        windo wincmd K
        call win_gotoid(winid)
        wincmd H
        let t:window_layout = 4
    endif

    if exists('g:lens#loaded')
        call lens#run()
    endif
endfunc

