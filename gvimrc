"" Fonts {{{1
if has("gui_macvim")
	set gfn=Fira_Mono:h14,Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Fira\ Mono\ 12,Hack\ 10,Monospace\ 12
elseif has('nvim')
	" GuiFont! Hack:h14
	GuiFont! Fira\ Mono:h14
else
	set linespace=0
	"
	" Однажды в студеную зимнюю пору
	" я из лесу вышел был сильный мороз
	"
	set gfn=Hack:h12
	" set gfn=Fira_Mono:h12
	" set gfn=Consolas:h12
	" set gfn=Liberation_Mono:h12
	" set gfn=Anonymous_Pro:h12
	" set gfn=PT_Mono:h12
	" set gfn=Source_Code_Pro:h12
	" set gfn=IBM_Plex_Mono:h12
	" set gfn=Fantasque_Sans_Mono:h12
	" set gfn=Ubuntu_Mono:h12
	" set gfn=Iosevka_Extended:h12
	" set gfn=Iosevka:h12
	" set gfn=Iosevka_SS03:h14
	" set gfn=Pragmata_Pro:h12
endif

"" Window size {{{1
if !has('nvim')
	set columns=999
	set lines=999
endif

"" Colorschemes setup {{{1

" pairs of colorschemes I like to use:
" light is the first one, dark is the second.
" let g:duo_themes = [{'name': 'defminus'}, {'name': 'gruvbox', 'bg': 'dark'}]
" let g:duo_themes = [{'name': 'defminus'}, {'name': 'defnoche'}]
let g:duo_themes = [#{name: 'defminus'}, #{name: 'lessthan'}]
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

let s:force_dark = 0
" Well, if it happens you run vim late, use dark colorscheme
if strftime("%H") >= 20 || s:force_dark
	call s:set_colorscheme(g:duo_themes[1])
else
" Light colors otherwise
	call s:set_colorscheme(g:duo_themes[0])
endif

" Mimic toggling behaviour of Tim Popes unimpaired plugin
nnoremap yot :call ToggleColorscheme()<CR>
