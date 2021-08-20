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
