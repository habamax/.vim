" Author: Maxim Kim <habamax@gmail.com>


func! s:rx_marked_checkbox() abort
    return '\(\s*✓\s*\)'
endfunc


func! s:rx_rejected_checkbox() abort
    return '\(\s*✗\s*\)'
endfunc


fun! s:toggle_checkbox(lnum)
    let line = getline(a:lnum)
    if s:is_checkbox_marked(line)
        exe a:lnum .. 's/\(' .. &l:formatlistpat .. '\)' .. s:rx_marked_checkbox() .. '/\1✗ /'
    elseif s:is_checkbox_rejected(line)
        exe a:lnum .. 's/\(' .. &l:formatlistpat .. '\)' .. s:rx_rejected_checkbox() .. '/\1/'
    elseif s:is_list_item(line)
        exe a:lnum .. 's/' .. &l:formatlistpat .. '/&✓ /'
    endif
endfu


func! s:is_list_item(line) abort
    return a:line =~ &l:formatlistpat
endfunc


func! s:is_checkbox_marked(line) abort
    let @r = '\%(' .. &l:formatlistpat .. '\)' .. s:rx_marked_checkbox()
    return a:line =~ '\%(' .. &l:formatlistpat .. '\)' .. s:rx_marked_checkbox()
endfunc


func! s:is_checkbox_rejected(line) abort
    return a:line =~ '\%(' .. &l:formatlistpat .. '\)' .. s:rx_rejected_checkbox()
endfunc


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
