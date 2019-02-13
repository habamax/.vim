" Fonts {{{1
if has("gui_macvim")
	set gfn=Fantasque_Sans_Mono:h13,Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Fantasque\ Sans\ Mono\ 13,Hack\ 10,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
elseif has('nvim')
	GuiFont! Fantasque\ Sans\ Mono:h13
else
	" set gfn=Fantasque_Sans_Mono:h13,Hack:h10,Consolas:h14
	set gfn=Iosevka_SS03:h12,Hack:h12,Consolas:h14
endif

" Window size {{{1
if !has('nvim')
	set columns=999
	set lines=999
endif

" pairs of colorschemes I like to use
" let g:duo_themes = ['defminus', 'nord']
" let g:duo_themes = ['defminus', 'jellybeans']
let g:duo_themes = ['defminus', 'badwolf']
fun! ToggleColorscheme()
	if !exists('g:colors_name')
		let g:colors_name = 'default'
	endif
	let color = filter(copy(g:duo_themes), {k, v -> v != g:colors_name})[0]
	exe "colorscheme ".color
endf

" Well, if it happens you run vim late, use dark colorscheme
if strftime("%H") >= 21
	exe "colorscheme ".g:duo_themes[1]
else
" Light colors otherwise
	exe "colorscheme ".g:duo_themes[0]
endif

" Mimic toggling behaviour of Tim Popes unimpaired plugin
nnoremap yot :call ToggleColorscheme()<CR>
