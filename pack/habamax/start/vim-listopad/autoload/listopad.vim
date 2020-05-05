" Maintainer: Maxim Kim <habamax@gmail.com>

""" List item regexes {{{1

" next regex is for numbered lists too but not sure if it makes sense
let s:rx_bullets = '^\(\%(\s*[-*]\+\s\+\)\|\%(\s*\d\+\.\s\+\)\)'
" let s:rx_bullets = '^\(\s*[-*]\+\s*\)'
let s:rx_empty_checkbox = '\(\s*\[ \?\]\+\s*\)'
let s:rx_marked_checkbox = '\(\s*\[[Xx]\]\+\s*\)'

""" List checkboxes {{{1
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

fun! listopad#toggle_checkboxes(line1, line2)
    let save_cursor = getcurpos()
    try
        for lnum in range(a:line2, a:line1, -1)
            call s:toggle_checkbox(lnum)
            if get(g:, "listopad_auto_archive", v:false)
                call s:list_item_archive(lnum)
            endif
        endfor
    finally
        call setpos('.', save_cursor)
    endtry
endfu

" operator pending...
fu! listopad#op_toggle_checkboxes(...)
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

    call listopad#toggle_checkboxes(line("'<"), line("'>"))

    let &selection = sel_save
    let &clipboard = clipboard_save
endfu


""" Archiving {{{1

func! s:list_item_archive(lnum) abort
    " identify current list item bounds including sublist items
    " do nothing if not a list item or without checkbox or checkbox is empty
    " (including sublist items)
    " simplified version :)
    if !s:is_checkbox_marked(getline(a:lnum))
        return
    endif

    " identify archive placement
    let archive_pos = search("ARCHIVE", "nW")
    if archive_pos == 0
        return
    endif
    " move list item under archive placements
    exe 'move'.archive_pos
endfunc


func! listopad#archive() abort
    call s:list_item_archive(line('.'))
endfunc
