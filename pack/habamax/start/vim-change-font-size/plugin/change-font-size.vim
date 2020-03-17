" change-font-size.vim - Create directories on file save
" Maintainer:   Maxim Kim <habamax@gmail.com>

if exists("g:loaded_change_font_size") || &cp || v:version < 700
	finish
endif

let s:is_gui_neovim = get(g:, "GuiLoaded", v:false) || get(g:, "neovide", v:false)

if !(has("gui_running") || s:is_gui_neovim)
	finish
endif

let s:is_guifont = has("gui_running") || get(g:, "neovide", v:false)

let g:loaded_change_font_size = 1

"""""""""""""""""""""""""""""""""""""""""""""""""
"  This is Windows specific at the moment...    "
"""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:getCurrentFont()
    if s:is_guifont
        let guifont = &guifont
    else
        let guifont = g:GuiFont
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

