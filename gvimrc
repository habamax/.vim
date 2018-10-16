if has("gui_macvim")
	set gfn=Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Hack\ 10,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
else
	set gfn=Hack:h10,Consolas:h14
endif
set columns=999
set lines=999

fu! ChangeFontSize(op)
	if has('nvim')
		redir => gfont
		GuiFont
		redir END
		let font = matchlist(gfont, '\(.\{-}\):h\(\d\+\)')
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
		let &guifont = b:fontname.':h'.(font[2] + 1)
	elseif a:op == 'dec'
		let &guifont = b:fontname.':h'.(font[2] - 1)
	else
		let &guifont = b:fontname.':h'.b:fontsize
	endif
	let &lines = b:lines
	let &columns = b:columns
endfu

" looks like this is windows only
nnoremap <A--> :call ChangeFontSize('dec')<CR>
nnoremap <A-=> :call ChangeFontSize('inc')<CR>
nnoremap <A-0> :call ChangeFontSize('restore')<CR>

colo dracula
" colo jellybeans
" colo deep-space
" colo iceberg

let g:gruvbox_contrast_dark  = "medium"
let g:gruvbox_contrast_light = "medium"
let g:gruvbox_invert_selection = 0
" colo gruvbox

" set background=light
" colo paramount
