" Maintainer: Maxim Kim <habamax@gmail.com>

""" List item regexes {{{1

" next regex is for numbered lists too but not sure if it makes sense
let s:rx_bullets = '^\(\%(\s*[-*]\+\s\+\)\|\%(\s*\d\+\.\s\+\)\)'
" let s:rx_bullets = '^\(\s*[-*]\+\s*\)'
let s:rx_empty_checkbox = '\(\s*\[ \?\]\+\s*\)'
let s:rx_marked_checkbox = '\(\s*\[[Xx]\]\+\s*\)'

""" List checkboxes {{{1
fun! s:toggle_checkbox(line)
    let line = getline(a:line)
    if line =~ s:rx_bullets && line !~ s:rx_bullets.s:rx_empty_checkbox.'\|'.s:rx_marked_checkbox
        exe a:line.'s/'.s:rx_bullets.'/\1\[ \] /'
    elseif line =~ s:rx_bullets.s:rx_empty_checkbox
        exe a:line.'s/'.s:rx_bullets.s:rx_empty_checkbox.'/\1\[x\] /'
    elseif line =~ s:rx_bullets.s:rx_marked_checkbox
        exe a:line.'s/'.s:rx_bullets.s:rx_marked_checkbox.'/\1\[ \] /'
    endif
endfu

fun! listopad#toggle_checkboxes(line1, line2)
    for line in range(a:line1, a:line2)
        call s:toggle_checkbox(line)
    endfor
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
