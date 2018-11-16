if has("gui_macvim")
	set gfn=Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Hack\ 10,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
else
	set gfn=Fantasque_Sans_Mono:h11,Hack:h10,Consolas:h14
endif
set columns=999
set lines=999

fun! s:base16_customize() abort "{{{
	call Base16hi("Title", "", "", "", "", "bold", "")
	call Base16hi("Statement", "", "", "", "", "none", "")
	call Base16hi("Underlined", "", "", "", "", "underline", "")
	call Base16hi("LineNr", "", g:base16_gui00, "", "", "", "")
	call Base16hi("SignColumn", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterAdd", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterChange", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterDelete", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterChangeDelete", "", g:base16_gui00, "", "", "", "")
	hi! link lCursor IncSearch
	hi link Lf_hl_match Title
endfun
" }}}

fun! s:base16_zenburn_customize() abort "{{{
	call Base16hi("Delimiter", "8f8f8f", "", "", "", "", "")
	call Base16hi("SpecialChar", "dca3a3", "", "", "", "", "")
endfun

augroup on_change_colorscheme
	autocmd!
	autocmd ColorScheme base16* call s:base16_customize()
	autocmd ColorScheme base16-zenburn call s:base16_zenburn_customize()
augroup END
" }}}

" Next are good base16 themes AKA themes I like
" DARK
colo base16-oceanicnext
" colo base16-tomorrow-night
" colo base16-irblack
" colo base16-default-dark
" colo base16-grayscale-dark
" colo base16-nord
" colo base16-eighties
" colo base16-onedark
" colo base16-twilight
" colo base16-default-dark
" LIGHT
" colo base16-one-light
" colo base16-grayscale-light
" colo base16-solarized-light
" colo base16-atelier-forest-light
" colo base16-atelier-savanna-light
" colo base16-atelier-sulphurpool-light
" colo base16-atelier-estuary-light
" colo base16-atelier-cave-light
