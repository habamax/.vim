let g:winlayout_index = -1
let s:layouts=[]
let s:resize_cmds=[]



func! winlayout#save() abort
	" FIXME: do not save duplicate layouts
	" FIXME: rotate up to N (20) layouts?
	call add(s:layouts, winlayout())
	call add(s:resize_cmds, winrestcmd())
	let g:winlayout_index = len(s:layouts) - 1
	call s:add_buf_to_layout(s:layouts[-1])
	" echo s:layouts
endfunc


" add bufnr to leaf
func! s:add_buf_to_layout(layout) abort
	if a:layout[0] ==# 'leaf'
		call add(a:layout, winbufnr(a:layout[1]))
	else
		for child_layout in a:layout[1]
			call s:add_buf_to_layout(child_layout)
		endfor
	endif
endfunc

func! winlayout#restore(direction) abort
	if len(s:layouts) == 0
		return
	endif

	let g:winlayout_index += a:direction
	if g:winlayout_index < 0 
		let g:winlayout_index = 0
	endif
	if g:winlayout_index >= len(s:layouts)
		let g:winlayout_index = len(s:layouts) - 1
	endif

	
	" create clean window
	new
	wincmd o

	" recursively restore buffers
	call s:apply_layout(s:layouts[g:winlayout_index])

	" resize
	exe s:resize_cmds[g:winlayout_index]

endfunc

func! s:apply_layout(layout) abort

	if a:layout[0] ==# 'leaf'

		" load buffer for leaf
		if bufexists(a:layout[2])
			exe printf('b %d', a:layout[2])
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


