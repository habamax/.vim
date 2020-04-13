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


"" Resize current window to width and height
"" make other windows equal size if possible
func! win#resize(width, height) abort
    exe "vertical resize " . a:width
    exe "resize " a:height
    setlocal winfixwidth
    setlocal winfixheight
    wincmd =
    setlocal nowinfixwidth
    setlocal nowinfixheight
endfunc
