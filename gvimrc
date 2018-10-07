if has("gui_macvim")
	set gfn=Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Hack\ 12,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
else
	set gfn=Hack:h12,Consolas:h14
endif
set columns=999
set lines=999

" colo dracula
colo deep-space
" colo iceberg
" colo gruvbox
" colo paramount
