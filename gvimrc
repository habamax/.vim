"
" Однажды в студеную зимнюю пору
" Я из лесу вышел, был сильный мороз.
" З3 -- Z3
"
if has("gui_macvim")
	set gfn=Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
else
	" For some fonts linespace=-1 looks better.
	set linespace=-1
	" set gfn=Iosevka:h14
	" set gfn=Fira\ Mono:h14
	" set gfn=IBM\ Plex\ Mono:h12
	set gfn=IBM\ Plex\ Mono\ Text:h14

	" set linespace&
	" set gfn=Hack:h14
	" set gfn=Consolas:h14
	" set gfn=Cascadia\ Code:h14
	" set gfn=PT\ Mono:h14
	" set gfn=Liberation\ Mono:h14
endif

set columns=136
set lines=30
