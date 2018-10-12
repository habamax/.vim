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
