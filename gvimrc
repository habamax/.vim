"" Fonts {{{1
if has("gui_macvim")
	set gfn=Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Hack\ 10,Monospace\ 12
elseif has('nvim')
	set linespace=-1
	set gfn=Iosevka:h14
else
	set linespace=-1
	"
	" Однажды в студеную зимнюю пору
	" Я из лесу вышел, был сильный мороз.
	"
	" set gfn=Hack:h14
	set gfn=Iosevka:h14
	" set gfn=Consolas:h14
	" set gfn=Fira_Mono:h12
	" set gfn=PT_Mono:h13
	" set gfn=Liberation_Mono:h12
	" set gfn=Pragmata_Pro:h14
	" set gfn=IBM_Plex_Mono:h12
	" set gfn=Go_Mono:h12
endif

"" Window size {{{1
if !has('nvim')
	set columns=999
	set lines=999
endif

"" Colorschemes setup {{{1

" pairs of colorschemes I like to use:
" light is the first one, dark is the second.
" let g:duo_themes = [{'name': 'solarized8', 'bg': 'light'}, {'name': 'gruvbox8', 'bg': 'dark'}]
" let g:duo_themes = [{'name': 'defminus'}, {'name': 'solarized8', 'bg': 'dark'}]
" let g:duo_themes = [{'name': 'defminus'}, {'name': 'defnoche'}]
let g:duo_themes = [{'name': 'defminus'}, {'name': 'lessthan'}]
func! s:set_colorscheme(color)
	if has_key(a:color, 'bg')
		let &bg = a:color['bg']
	endif
	if has_key(a:color, 'name')
		exe "colorscheme ".a:color['name']
	endif
endfunc
func! ToggleColorscheme()
	if !exists('g:colors_name')
		let g:colors_name = 'default'
	endif
	let color = filter(copy(g:duo_themes), {k, v -> v['name'] != g:colors_name})[0]
	call s:set_colorscheme(color)
endfunc

" If it happens you run vim late, use dark colorscheme
" Unless you have forced it
let s:force_dark = 1
if strftime("%H") >= 20 || strftime("%H") < 7 || s:force_dark
	call s:set_colorscheme(g:duo_themes[1])
else
" Light colors otherwise
	call s:set_colorscheme(g:duo_themes[0])
endif

" Mimic toggling behaviour of Tim Popes unimpaired plugin
nnoremap yot :call ToggleColorscheme()<CR>
" nnoremap нще :call ToggleColorscheme()<CR>
nmap нще yot
