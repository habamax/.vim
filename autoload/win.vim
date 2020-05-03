"" Scroll other(previous) window
func! win#scroll_other(dir) abort
    if winnr('$') < 2
        return
    endif
    wincmd p
    let cmd = "normal ".winheight(0)
    if a:dir
        let cmd .= "\<c-e>"
    else
        let cmd .= "\<c-y>"
    endif
    exe cmd
    wincmd p
endfunc


"" Autosize windows. {{{1
"" There is lens.vim plugin but essentially this simplified version could be used
"" instead. Original lens.vim laaaags if switched to a huge file, it
"" calculates target width consuming whole file into memory....
""
"" Add following lines somewhere in you vimrc:
"" augroup autosize_windows | au!
""     au BufWinEnter,WinEnter * silent! call win#comfy()
"" augroup end
func! win#lens() abort
    if s:is_lens_disabled()
        return
    endif

    let width = max([
                \ get(g:, "lens_pref_width", 90),
                \ winwidth(0)
                \ ])
    let height = max([
                \ get(g:, "lens_pref_height", 20),
                \ winheight(0)
                \ ])

    execute 'vertical resize ' . width
    execute 'resize ' . height
    setlocal winfixheight
    setlocal winfixwidth
    wincmd =
    setlocal nowinfixheight
    setlocal nowinfixwidth
    normal! zzze
endfunction


func! s:is_lens_disabled() abort
    " do not resize floating windows
    if exists('*nvim_win_get_config')
        if nvim_win_get_config(0)['relative'] != ''
            return v:true
        endif
    endif

    " do not resize windows with filetype
    if index(get(g:, "lens_disabled_filetypes", []), &filetype) != -1
        return v:true
    endif

    return v:false
endfunc


"" 5 layouts
"" layout 1: even horizontal
"" layout 2: even vertical
"" layout 3: main horizontal
"" layout 4: main vertical
"" layout 5: tiled
func! win#layout_toggle() abort
    let layout_echo = ""
    let win_layout = get(t:, "window_layout", 5)

    if win_layout == 5
        let layout_echo = win#layout_horizontal()
        let t:window_layout = 1
    elseif win_layout == 1
        let layout_echo = win#layout_vertical()
        let t:window_layout = 2
    elseif win_layout == 2
        let layout_echo = win#layout_main_horizontal()
        let t:window_layout = 3
    elseif win_layout == 3
        let layout_echo = win#layout_main_vertical()
        let t:window_layout = 4
    elseif win_layout == 4
        let layout_echo = win#layout_tile()
        let t:window_layout = 5
    endif

    call win#lens()

    return layout_echo
endfunc


func! win#layout_horizontal() abort
    let winid = win_getid()
    windo wincmd L
    call win_gotoid(winid)
    return "Even horizontal layout"
endfunc


func! win#layout_vertical() abort
    let winid = win_getid()
    windo wincmd K
    call win_gotoid(winid)
    return "Even vertical layout"
endfunc


func! win#layout_main_horizontal() abort
    let winid = win_getid()
    windo wincmd L
    call win_gotoid(winid)
    wincmd K
    return "Main horizontal layout"
endfunc


func! win#layout_main_vertical() abort
    let winid = win_getid()
    windo wincmd K
    call win_gotoid(winid)
    wincmd H
    return "Main vertical layout"
endfunc


func! win#layout_tile() abort
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

    for bnr in range(half)
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

    return "Tiled layout"
endfunc



""" Save and Restore window layout {{{1

let s:layout = []
let s:winrestcmd = ""
let s:cursor = []

func! win#layout_save(...) abort
    let s:winrestcmd = winrestcmd()
    let s:layout = winlayout()
    let s:cursor = [winnr(), getcurpos()]
    call s:add_buf_to_layout(s:layout)
    return "Layout is saved"
endfunc


func! win#layout_restore() abort
    if empty(s:layout)
        return "No saved layout to restore"
    endif

    " Close other windows
    silent wincmd o

    " recursively restore buffers
    call s:apply_layout(s:layout)

    " resize
    exe s:winrestcmd

    " goto saved window
    exe printf("%dwincmd w", s:cursor[0])

    " set cursor
    call setpos('.', s:cursor[1])

    return "Layout is restored"
endfunc


" add bufnr to leaf
func! s:add_buf_to_layout(layout) abort
    if a:layout[0] ==# 'leaf'
        " replace win_id with buffer number
        let a:layout[1] = winbufnr(a:layout[1])
    else
        for child_layout in a:layout[1]
            call s:add_buf_to_layout(child_layout)
        endfor
    endif
endfunc


func! s:apply_layout(layout) abort

    if a:layout[0] ==# 'leaf'

        " load buffer for leaf
        if bufexists(a:layout[1])
            exe printf('b %d', a:layout[1])
        endif
    else

        " split cols or rows, split n-1 times
        let split_method = a:layout[0] ==# 'col' ? 'rightbelow split' : 'rightbelow vsplit'
        let wins = [win_getid()]
        for child_layout in a:layout[1][1:]
            exe split_method
            let wins += [win_getid()]
        endfor

        " recursive into child windows
        for index in range(len(wins) )
            call win_gotoid(wins[index])
            call s:apply_layout(a:layout[1][index])
        endfor

    endif
endfunc
