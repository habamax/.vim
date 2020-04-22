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
"" layout 5: tiled
func! win#toggle_layout() abort
    let win_layout = get(t:, "window_layout", 5)
    let winid = win_getid()

    if win_layout == 5
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
    elseif win_layout == 4
        call win#tile()
        let t:window_layout = 5
    endif

    if exists('g:lens#loaded')
        call lens#run()
    else
        wincmd =
    endif
endfunc


func! win#tile() abort
    let windows = []
    let buffers = []

    for w in range(1, winnr('$'))
        if w != winnr()
            call add(buffers, winbufnr(w))
        endif
    endfor

    only
    call add(windows, win_getid())

    let half = len(buffers)/2

    for bnr in range(0, half-1)
        split
        call add(windows, win_getid())
        exe printf("buffer %s", buffers[bnr])
    endfor

    let win_idx = 0
    for bnr in range(half, len(buffers) - 1)
        call win_gotoid(windows[win_idx])
        vsplit
        exe printf("buffer %s", buffers[bnr])

        let win_idx += 1
    endfor

    call win_gotoid(windows[0])
endfunc
