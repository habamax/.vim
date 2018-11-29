"""""""""""""""""""""""""""""""""""""""""""""""""
"  This is Windows specific at the moment...    "
"""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:getCurrentFont()
	if has('nvim')
		redir => gfont
		silent GuiFont
		redir END
		let font = matchlist(substitute(gfont, '\n', '', ''), '\(.\{-}\):h\(\d\+\)')
	else
		let font = matchlist(&guifont, '\(.\{-}\):h\(\d\+\)')
	endif
	return [font[1], font[2]]
endfu


fun! s:changeFontSize(op)
	let [fontname,fontsize] = s:getCurrentFont()

	if a:op == 'inc'
		let new_font = fontname.':h'.(fontsize + 1)
	elseif a:op == 'dec'
		let new_font = fontname.':h'.(fontsize - 1)
	elseif !has('nvim')
		let new_font = g:init_fontname.':h'.g:init_fontsize
	endif

	if has('nvim')
		exe 'GuiFont! '. new_font
	else
		let &guifont = new_font
		let &lines = g:init_lines
		let &columns = g:init_columns
	endif
endfu

fun! s:save_init_size()
	if has('gui_running')
		let g:init_lines = &lines
		let g:init_columns = &columns
		let [g:init_fontname, g:init_fontsize] = s:getCurrentFont()
	endif
endf

augroup GVIM_SAVE_INIT_SIZE
	au!
	autocmd VimEnter * call s:save_init_size()
augroup end

" looks like this is windows only
nnoremap <A--> :call <sid>changeFontSize('dec')<CR>
nnoremap <A-=> :call <sid>changeFontSize('inc')<CR>
nnoremap <A-0> :call <sid>changeFontSize('restore')<CR>

