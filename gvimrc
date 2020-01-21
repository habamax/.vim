""" Colors {{{1

" If it happens you run vim late, use dark colors
if strftime("%H") >= 20 || strftime("%H") < 8 
	set bg=dark
else
	set bg=light
endif

"" Uncomment if you want random base16 colors (mostly) in your gVim
" call MY_LUCKY_COLORS()

" colorscheme base16-twilight
" colorscheme base16-harmonic-dark


" My timebased default colors -- when no other colorscheme was setup
if get(g:, "colors_name", "default") == "default"
	if &bg == "dark"
		let my_dark_colors = ['lessthan', 'defnoche']
		exe 'colorscheme ' . my_dark_colors[rand() % len(my_dark_colors)]
	else
		colorscheme defminus
	endif
endif


""" Fonts {{{1
"
" Однажды в студеную зимнюю пору
" Я из лесу вышел, был сильный мороз.
" зЗ3 -- Z3
"
if has("gui_macvim")
	set gfn=Iosevka\ Extended:h14,Hack:h14,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
else
	set linespace=0
	set gfn=Iosevka\ Extended:h14
	" set gfn=IBM\ Plex\ Mono:h14
	" set gfn=IBM\ Plex\ Mono\ Medium:h14
	" set gfn=Iosevka:h14
	" set gfn=JetBrains\ Mono:h14
	" set gfn=Hack:h14
	" set gfn=Consolas:h14
	" set gfn=Cascadia\ Code:h14
	" set gfn=Fira\ Mono:h14
	" set gfn=PT\ Mono:h14
	" set gfn=Go\ Mono:h14
endif

set columns=200
set lines=200
