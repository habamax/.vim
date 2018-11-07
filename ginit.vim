" This has to be tuned on mac.
if has("gui_macvim")
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	" set gfn=Hack\ 10,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
else
	GuiFont! Hack:h10
endif

" colo dracula
" colo jellybeans

" let g:github_colors_soft = 1
" colo github

colo base16-tomorrow-night

let g:gruvbox_contrast_dark  = "medium"
let g:gruvbox_contrast_light = "medium"
let g:gruvbox_invert_selection = 0
" colo gruvbox
