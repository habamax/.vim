" Author: Maxim Kim <habamax@gmail.com>

"""
""" List item regexes
"""

" next regex is for numbered lists too but not sure if it makes sense
let s:rx_bullets = '^\(\%(\s*[-*]\+\s\+\)\|\%(\s*\d\+\.\s\+\)\)'
let s:rx_empty_checkbox = '\(\s*\[ \?\]\+\s*\)'
let s:rx_marked_checkbox = '\(\s*\[[Xx]\]\+\s*\)'
let s:rx_archive = '^\(#\|=\)\+ DONE'

"""
""" List checkboxes
"""
func! s:is_list_item(line) abort
    return a:line =~ s:rx_bullets && a:line !~ s:rx_bullets.s:rx_empty_checkbox.'\|'.s:rx_marked_checkbox
endfunc

func! s:is_checkbox_empty(line) abort
    return a:line =~ s:rx_bullets.s:rx_empty_checkbox
endfunc

func! s:is_checkbox_marked(line) abort
    return a:line =~ s:rx_bullets.s:rx_marked_checkbox
endfunc

fun! s:toggle_checkbox(lnum)
    let line = getline(a:lnum)
    if s:is_list_item(line)
        exe a:lnum.'s/'.s:rx_bullets.'/\1\[ \] /'
    elseif s:is_checkbox_empty(line)
        exe a:lnum.'s/'.s:rx_bullets.s:rx_empty_checkbox.'/\1\[x\] /'
    elseif s:is_checkbox_marked(line)
        exe a:lnum.'s/'.s:rx_bullets.s:rx_marked_checkbox.'/\1\[ \] /'
    endif
endfu

func! checkbox#toggle(line1, line2) abort
    let save_cursor = getcurpos()
    try
        for lnum in range(a:line2, a:line1, -1)
            call s:toggle_checkbox(lnum)
        endfor
    finally
        call setpos('.', save_cursor)
    endtry
endfunc

" operator pending...
fu! checkbox#toggle_op(...)
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    let sel_save = &selection
    let &selection = "inclusive"
    let clipboard_save = &clipboard
    let &clipboard = ""

    if a:1 == 'char'	" Invoked from Visual mode, use gv command.
        silent exe "normal! gvy"
    elseif a:1 == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    call checkbox#toggle(line("'<"), line("'>"))

    let &selection = sel_save
    let &clipboard = clipboard_save
endfu
