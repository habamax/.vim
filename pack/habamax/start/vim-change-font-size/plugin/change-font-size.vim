fu! ChangeFontSize(op)
	if has('nvim')
		redir => gfont
		silent GuiFont
		redir END
		let font = matchlist(substitute(gfont, '\n', '', ''), '\(.\{-}\):h\(\d\+\)')
	else
		let font = matchlist(&guifont, '\(.\{-}\):h\(\d\+\)')
	endif
	if !exists('b:fontsize')
		let b:fontname = font[1]
		let b:fontsize = font[2]
		let b:lines = &lines
		let b:columns = &columns
	endif

	let lines = &lines

	if a:op == 'inc'
		let new_font = b:fontname.':h'.(font[2] + 1)
	elseif a:op == 'dec'
		let new_font = b:fontname.':h'.(font[2] - 1)
	else
		let new_font = b:fontname.':h'.b:fontsize
	endif

	if has('nvim')
		echomsg 'GuiFont! '. new_font
		exe 'GuiFont! '. new_font
	else
		let &guifont = new_font
	endif

	let &lines = b:lines
	let &columns = b:columns
endfu

" looks like this is windows only
nnoremap <A--> :call ChangeFontSize('dec')<CR>
nnoremap <A-=> :call ChangeFontSize('inc')<CR>
nnoremap <A-0> :call ChangeFontSize('restore')<CR>

