if has("gui_macvim")
	set gfn=Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Hack\ 10,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
else
	set gfn=Fantasque_Sans_Mono:h14,Hack:h10,Consolas:h14
	" set gfn=Hack:h10,Consolas:h14
endif
set columns=999
set lines=999

fun! s:base16_customize() abort "{{{
	call Base16hi("Title", "", "", "", "", "bold", "")
	call Base16hi("Statement", "", "", "", "", "none", "")
	hi link Lf_hl_match Title
endfun

augroup on_change_colorschema
	autocmd!
	autocmd ColorScheme base16* call s:base16_customize()
augroup END
" }}}
" Next are good base16 themes AKA themes I like
" DARK
" colo base16-irblack
" colo base16-tomorrow-night
" colo base16-grayscale-dark
" colo base16-nord
" colo base16-eighties
" colo base16-twilight
" colo base16-onedark
" colo base16-chalk
" colo base16-default-dark
" colo base16-zenburn
" colo base16-flat
" LIGHT
colo base16-one-light
" colo base16-grayscale-light
" colo base16-solarized-light
" colo base16-atelier-forest-light
" colo base16-atelier-savanna-light
" colo base16-atelier-sulphurpool-light
" colo base16-atelier-estuary-light
" colo base16-atelier-cave-light
