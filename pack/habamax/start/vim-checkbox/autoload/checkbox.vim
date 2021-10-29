" Author: Maxim Kim <habamax@gmail.com>

"""
""" List item regexes
"""
func! s:rx_empty_checkbox() abort
    if get(g:, "checkbox_use_unicode", 1)
        return '\(\s*\)'
    else
        return '\(\s*\[ \?\]\+\s*\)'
    endif
endfunc

func! s:rx_marked_checkbox() abort
    if get(g:, "checkbox_use_unicode", 1)
        return '\(\s*✓\s*\)'
    else
        return '\(\s*\[[Xx]\]\+\s*\)'
    endif
endfunc


"""
""" List checkboxes
"""
func! s:is_list_item(line) abort
    return a:line =~ &l:formatlistpat && a:line !~ &l:formatlistpat.s:rx_empty_checkbox().'\|'.s:rx_marked_checkbox()
endfunc

func! s:is_checkbox_empty(line) abort
    return a:line =~ &l:formatlistpat.s:rx_empty_checkbox()
endfunc

func! s:is_checkbox_marked(line) abort
    return a:line =~ &l:formatlistpat.s:rx_marked_checkbox()
endfunc

fun! s:toggle_checkbox(lnum)
    let line = getline(a:lnum)
    if s:is_checkbox_marked(line)
        if get(g:, "checkbox_use_unicode", 1)
            exe a:lnum.'s/\('.&l:formatlistpat.'\)'.s:rx_marked_checkbox().'/\1/'
        else
            exe a:lnum.'s/\('.&l:formatlistpat.'\)'.s:rx_marked_checkbox().'/\1[ \] /'
        endif
    elseif s:is_checkbox_empty(line)
        if get(g:, "checkbox_use_unicode", 1)
            exe a:lnum.'s/\('.&l:formatlistpat.'\)'.s:rx_empty_checkbox().'/\1✓ /'
        else
            exe a:lnum.'s/\('.&l:formatlistpat.'\)'.s:rx_empty_checkbox().'/\1\[x\] /'
        endif
    elseif s:is_list_item(line)
        if get(g:, "checkbox_use_unicode", 1)
            exe a:lnum.'s/'.&l:formatlistpat.'/& /'
        else
            exe a:lnum.'s/'.&l:formatlistpat.'/&\[ \] /'
        endif
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
