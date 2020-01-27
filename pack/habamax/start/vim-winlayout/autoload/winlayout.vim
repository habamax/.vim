let s:winlayout_max = get(g:, "winlayout_max", 20)
let s:winlayout_index = -1
let s:layouts=[]
let s:resize_cmds=[]

func! winlayout#inspect() abort
	let @* = json_encode(s:layouts)
	echom @*
endfunc

func! s:eq_layouts(layout1, layout2) abort
	if len(a:layout1) != len(a:layout2)
		return v:false
	endif

	return a:layout1 == a:layout2
endfunc

func! winlayout#save() abort
	call add(s:layouts, winlayout())
	call add(s:resize_cmds, winrestcmd())
	let s:winlayout_index = len(s:layouts) - 1
	call s:add_buf_to_layout(s:layouts[-1])

	" Delete consecutive duplicate layouts
	if len(s:layouts) > 1 && s:eq_layouts(s:layouts[-1], s:layouts[-2])
		call remove(s:layouts, -1)
		call remove(s:resize_cmds, -1)
	endif

	" Keep only g:winlayout_max layouts
	if len(s:layouts) > s:winlayout_max
		call remove(s:layouts, 0)
		call remove(s:resize_cmds, 0)
	endif
endfunc


" add bufnr to leaf
func! s:add_buf_to_layout(layout) abort
	if a:layout[0] ==# 'leaf'
		" replace win_id with buffer number
		let a:layout[1] = winbufnr(a:layout[1])
		" call add(a:layout, winbufnr(a:layout[1]))
	else
		for child_layout in a:layout[1]
			call s:add_buf_to_layout(child_layout)
		endfor
	endif
endfunc

func! winlayout#restore(direction) abort
	if empty(s:layouts)
		return
	endif

	let s:winlayout_index += a:direction
	if s:winlayout_index < 0 
		let s:winlayout_index = 0
	endif
	if s:winlayout_index >= len(s:layouts)
		let s:winlayout_index = len(s:layouts) - 1
	endif

	
	" Close other windows
	silent wincmd o

	" recursively restore buffers
	call s:apply_layout(s:layouts[s:winlayout_index])

	" resize
	exe s:resize_cmds[s:winlayout_index]

endfunc

func! s:apply_layout(layout) abort

	if a:layout[0] ==# 'leaf'

		" load buffer for leaf
		if bufexists(a:layout[1])
			exe printf('b %d', a:layout[1])
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


