func! PopupFilter(winid, key) abort
    if a:key == "\<F2>"
	" do something
	return 1
    endif
    if a:key == "\<ESC>"
	call popup_close(a:winid)
	return 1
    endif
    return 1
endfunc

func! Popup() abort
    let winid = popup_dialog('', {
		\ "title": 'hello world',
		\ "pos": 'center',
		\ "zindex": 200,
		\ "border": [],
		\ "borderchars": ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
		\ "padding": [],
		\ "mapping": 0,
		\ "filter": 'PopupFilter',
		\})
    let bufnr = winbufnr(winid)
    call setbufline(bufnr, 1, 'first line')
    call setbufline(bufnr, 2, 'second line')
endfunc

finish

call Popup()
call popup_clear(1)

nnoremap gn :call NextChange()<CR>
func! NextChange() abort
    let line = line('.')

    if diff_hlID(line, col('.')) == 28
        let line += 1
    endif

    while line <= line('$')
        let change_pos = filter(range(1, len(getline(line))), 'diff_hlID(line, v:val) == 28')
        if !empty(change_pos)
            call cursor(line, change_pos[0])
            return
        endif
        let line += 1
    endwhile
endfunc

func! NextChange() abort
    let line = line('.')

    if diff_hlID(line, col('.')) == 28
        let line += 1
    endif

    while line <= line('$')
        let pos = 1
        while pos <= len(getline(line))
            if diff_hlID(line, pos) == 28
                call cursor(line, pos)
                return
            endif
            let pos += 1
        endwhile
        let line += 1
    endwhile
endfunc
