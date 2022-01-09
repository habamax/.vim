vim9script

# Name: autoload/win.vim
# Author: Maxim Kim <habamax@gmail.com>
# Desc: Windows manipulation functions.


# Delete all hidden buffers
# Usage: command! Bclean call win#delete_buffers()
def win#delete_buffers()
    var buffers = filter(getbufinfo(), (_, v) => v.hidden)
    if !empty(buffers)
        execute 'confirm bwipeout' join(map(buffers, (_, v) => v.bufnr))
    endif
enddef


# Autosize windows.
# There is lens.vim plugin but essentially this simplified version could be used
# instead.
#
# Add following lines somewhere in your vimrc:
# augroup autosize_windows | au!
#     au WinEnter * silent! call win#lens()
# augroup end
def win#lens()
    if s:is_lens_disabled()
        return
    endif

    var adjusted_width = s:win_adjusted_width(80)

    var width = max([
                    get(g:, "lens_pref_width", adjusted_width),
                    winwidth(0)
                ])
    var height = max([
                    get(g:, "lens_pref_height", 20),
                    winheight(0)
                ])

    execute printf('vertical resize %s', width)
    execute printf('resize %s', height)
    s:fix_w_h(1)
    wincmd =
    s:fix_w_h(0)
    normal! ze
enddef


# Toggle autosize windows. Example mapping:
# nnoremap <silent> <C-w><BS> :call win#lens_toggle()<CR>
def win#lens_toggle()
    g:lens_disabled = !get(g:, "lens_disabled", v:false)
    if g:lens_disabled
        wincmd =
    else
        win#lens()
    endif
enddef


# Return width of a signcolumn
def s:signcolumn_width(): number
    var sc = matchlist(&signcolumn, '\(yes\|auto\)\%(:\(\d\)\)\?')

    if empty(sc)
        return 0
    endif

    if sc[1] == "yes"
        return (sc[2] == '' ? 2 : sc[2])
    endif

    if sc[1] == "auto" && !empty(sign_getplaced("%")[0].signs)
        return (sc[2] == '' ? 2 : sc[2])
    endif

    return 0
enddef


# Return adjusted window width (including linenr and signcolumn)
def s:win_adjusted_width(width: number): number
    var w = width
    if &number || &relativenumber
        w += max([strlen(line('$')), &numberwidth])
    endif
    if &foldcolumn
        w += max([1, &foldcolumn])
    endif
    w += s:signcolumn_width()
    return w
enddef


def s:is_lens_disabled(): bool
    if get(g:, "lens_disabled", v:false)
        return v:true
    endif

    # do not resize windows with filetype
    if index(get(g:, "lens_disabled_filetypes", []), &filetype) != -1
        return v:true
    endif

    return v:false
enddef


def s:fix_w_h(val: number)
    setwinvar(winnr(), "&winfixwidth", val)
    setwinvar(winnr(), "&winfixheight", val)
    for w in range(1, winnr('$'))
        var ft = getbufvar(winbufnr(w), "&filetype", "")
        if index(get(g:, "lens_disabled_filetypes", []), ft) != -1
            setwinvar(w, "&winfixwidth", val)
            setwinvar(w, "&winfixheight", val)
        endif
    endfor
enddef


# 5 layouts
# layout 1: horizontal
# layout 2: vertical
# layout 3: main horizontal
# layout 4: main vertical
# layout 5: tiled
def win#layout_toggle(): string
    if winnr('$') == 1
        return "Single window"
    endif

    var win_layouts = {}

    if winnr('$') == 2
        win_layouts = {
            1: {"f": "win#layout_horizontal", "next": 2},
            2: {"f": "win#layout_vertical", "next": 1}
        }
    elseif winnr('$') == 3
        win_layouts = {
            1: {"f": "win#layout_horizontal", "next": 2},
            2: {"f": "win#layout_vertical", "next": 3},
            3: {"f": "win#layout_main_horizontal", "next": 4},
            4: {"f": "win#layout_main_vertical", "next": 1}
        }
    else
        win_layouts = {
            1: {"f": "win#layout_horizontal", "next": 2},
            2: {"f": "win#layout_vertical", "next": 3},
            3: {"f": "win#layout_main_horizontal", "next": 4},
            4: {"f": "win#layout_main_vertical", "next": 5},
            5: {"f": "win#layout_tile", "next": 1}
        }
    endif

    var layout_echo = ""
    var layout = min([get(t:, "window_layout", len(win_layouts)), len(win_layouts)])


    layout_echo = function(win_layouts[layout].f)()
    t:window_layout = win_layouts[layout].next

    win#lens()

    return layout_echo
enddef


def win#layout_horizontal(): string
    var winid = win_getid()
    windo wincmd L
    win_gotoid(winid)
    wincmd H
    return "Horizontal layout"
enddef


def win#layout_vertical(): string
    var winid = win_getid()
    windo wincmd K
    win_gotoid(winid)
    wincmd K
    return "Vertical layout"
enddef


def win#layout_main_horizontal(): string
    var winid = win_getid()
    windo wincmd L
    win_gotoid(winid)
    wincmd K
    return "Main horizontal layout"
enddef


def win#layout_main_vertical(): string
    var winid = win_getid()
    windo wincmd K
    win_gotoid(winid)
    wincmd H
    return "Main vertical layout"
enddef


def win#layout_tile(): string
    var windows = []
    var buffers = []

    for w in range(1, winnr('$'))
        if w != winnr()
            add(buffers, winbufnr(w))
        endif
    endfor

    silent only
    add(windows, win_getid())

    var half = len(buffers) / 2

    var splitbelow = &splitbelow
    var splitright = &splitright
    try
        setl splitbelow
        setl splitright

        for bnr in range(half)
            split
            add(windows, win_getid())
            silent exe printf("buffer %s", buffers[bnr])
        endfor

        var win_idx = 0
        for bnr in range(half, len(buffers) - 1)
            silent win_gotoid(windows[win_idx])
            vsplit
            silent exe printf("buffer %s", buffers[bnr])

            win_idx += 1
        endfor

        silent win_gotoid(windows[0])
    finally
        &splitbelow = splitbelow
        &splitright = splitright
    endtry

    return "Tiled layout"
enddef
