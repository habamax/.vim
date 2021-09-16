" Name: autoload/win.vim
" Author: Maxim Kim <habamax@gmail.com>
" Desc: Windows manipulation functions.


" Delete all hidden buffers
" Usage: command! Bclean call win#delete_buffers()
func! win#delete_buffers()
    let l:buffers = filter(getbufinfo(), {_, v -> v.hidden})
    if !empty(l:buffers)
        execute 'confirm bwipeout' join(map(l:buffers, {_, v -> v.bufnr}))
    endif
endfunc


" Autosize windows.
" There is lens.vim plugin but essentially this simplified version could be used
" instead. Original lens.vim laaaags if switched to a huge file, it
" calculates target width consuming whole file into memory....
"
" Add following lines somewhere in your vimrc:
" augroup autosize_windows | au!
"     au WinEnter * silent! call win#lens()
" augroup end
func! win#lens() abort
    if s:is_lens_disabled()
        return
    endif

    let adjusted_width = s:win_adjusted_width(80)

    let width = max([
                \ get(g:, "lens_pref_width", adjusted_width),
                \ winwidth(0)
                \ ])
    let height = max([
                \ get(g:, "lens_pref_height", 20),
                \ winheight(0)
                \ ])

    execute printf('vertical resize %s', width)
    execute printf('resize %s', height)
    call s:fix_w_h(1)
    wincmd =
    call s:fix_w_h(0)
    normal! ze
endfunc


" Toggle autosize windows. Example mapping:
" nnoremap <silent> <C-w><BS> :call win#lens_toggle()<CR>
func! win#lens_toggle() abort
    let g:lens_disabled = !get(g:, "lens_disabled", v:false)
    if g:lens_disabled
        wincmd =
    else
        call win#lens()
    endif
endfunc


" Return width of a signcolumn
func! s:signcolumn_width() abort
    let sc = matchlist(&signcolumn, '\(yes\|auto\)\%(:\(\d\)\)\?')

    if empty(sc)
        return 0
    endif

    if sc[1] == "yes"
        return (sc[2] == '' ? 2 : sc[2])
    endif

    if sc[1] == "auto" && !empty(sign_getplaced("%")[0].signs)
        return (sc[2] == '' ? 2 : sc[2])
    endif
endfunc


" Return adjusted window width (including linenr and signcolumn)
func! s:win_adjusted_width(width) abort
    let width = a:width
    if &number || &relativenumber
        let width += max([strlen(line('$')), &numberwidth])
    endif
    if &foldcolumn
        let width += max([1, &foldcolumn])
    endif
    let width += s:signcolumn_width()
    return width
endfunc


func! s:is_lens_disabled() abort
    if get(g:, "lens_disabled", v:false)
        return v:true
    endif

    " do not resize windows with filetype
    if index(get(g:, "lens_disabled_filetypes", []), &filetype) != -1
        return v:true
    endif

    return v:false
endfunc


func! s:fix_w_h(val)
    call setwinvar(winnr(), "&winfixwidth", a:val)
    call setwinvar(winnr(), "&winfixheight", a:val)
    for w in range(1, winnr('$'))
        let ft = getbufvar(winbufnr(w), "&filetype", "")
        if index(get(g:, "lens_disabled_filetypes", []), ft) != -1
            call setwinvar(w, "&winfixwidth", a:val)
            call setwinvar(w, "&winfixheight", a:val)
        endif
    endfor
endfunc


" 5 layouts
" layout 1: horizontal
" layout 2: vertical
" layout 3: main horizontal
" layout 4: main vertical
" layout 5: tiled
func! win#layout_toggle() abort
    if winnr('$') == 1
        return "Single window"
    endif

    if winnr('$') == 2
        let win_layouts =
                    \ {1: {"f": "win#layout_horizontal", "next": 2}
                    \ ,2: {"f": "win#layout_vertical", "next": 1}
                    \ }
    elseif winnr('$') == 3
        let win_layouts =
                    \ {1: {"f": "win#layout_horizontal", "next": 2}
                    \ ,2: {"f": "win#layout_vertical", "next": 3}
                    \ ,3: {"f": "win#layout_main_horizontal", "next": 4}
                    \ ,4: {"f": "win#layout_main_vertical", "next": 1}
                    \ }
    else
        let win_layouts =
                    \ {1: {"f": "win#layout_horizontal", "next": 2}
                    \ ,2: {"f": "win#layout_vertical", "next": 3}
                    \ ,3: {"f": "win#layout_main_horizontal", "next": 4}
                    \ ,4: {"f": "win#layout_main_vertical", "next": 5}
                    \ ,5: {"f": "win#layout_tile", "next": 1}
                    \ }
    endif

    let layout_echo = ""
    let layout = min([get(t:, "window_layout", len(win_layouts)), len(win_layouts)])


    let layout_echo = function(win_layouts[layout].f)()
    let t:window_layout = win_layouts[layout].next

    call win#lens()

    return layout_echo
endfunc


func! win#layout_horizontal() abort
    let winid = win_getid()
    windo wincmd L
    call win_gotoid(winid)
    wincmd H
    return "Horizontal layout"
endfunc


func! win#layout_vertical() abort
    let winid = win_getid()
    windo wincmd K
    call win_gotoid(winid)
    wincmd K
    return "Vertical layout"
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

    silent only
    call add(windows, win_getid())

    let half = len(buffers)/2

    let splitbelow = &splitbelow
    let splitright = &splitright
    try
        setl splitbelow
        setl splitright

        for bnr in range(half)
            split
            call add(windows, win_getid())
            silent exe printf("buffer %s", buffers[bnr])
        endfor

        let win_idx = 0
        for bnr in range(half, len(buffers) - 1)
            silent call win_gotoid(windows[win_idx])
            vsplit
            silent exe printf("buffer %s", buffers[bnr])

            let win_idx += 1
        endfor

        silent call win_gotoid(windows[0])
    finally
        let &splitbelow = splitbelow
        let &splitright = splitright
    endtry

    return "Tiled layout"
endfunc
