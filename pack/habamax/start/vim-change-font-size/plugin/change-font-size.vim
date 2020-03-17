" change-font-size.vim - Create directories on file save
" Maintainer:   Maxim Kim <habamax@gmail.com>

if exists("g:loaded_change_font_size") || &cp || v:version < 700
	finish
endif

if !(has("gui_running") || get(g:, "GuiLoaded", 0) || get(g:, "neovide", v:false))
	finish
endif

let g:loaded_change_font_size = 1

"""""""""""""""""""""""""""""""""""""""""""""""""
"  This is Windows specific at the moment...    "
"""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:getCurrentFont()
    if has('nvim') && !exists("g:neovide")
        let guifont = g:GuiFont
    else
        let guifont = &guifont
    endif

    let font = matchlist(guifont, '\(.\{-}\):h\(\d\+\)')

	if !exists("s:orig_guifont")
		let s:orig_guifont = guifont
	endif

	return [font[1], font[2]]
endfu


fun! s:changeFontSize(op)
	let [fontname,fontsize] = s:getCurrentFont()

	if a:op == 'inc'
		let new_font = fontname.':h'.(fontsize + 1)
	elseif a:op == 'dec'
		let new_font = fontname.':h'.(fontsize - 1)
	else
	 	let new_font = s:orig_guifont
	endif

    exe printf('set guifont=%s', escape(new_font, ' '))

	wincmd =
endfu

" looks like this is windows only
nnoremap <A--> :call <sid>changeFontSize('dec')<CR>
nnoremap <A-=> :call <sid>changeFontSize('inc')<CR>
nnoremap <A-0> :call <sid>changeFontSize('restore')<CR>

