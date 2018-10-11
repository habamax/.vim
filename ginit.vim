if has("gui_macvim")
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	" set gfn=Hack\ 10,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
else
	GuiFont! Hack:h10
endif

colo dracula
