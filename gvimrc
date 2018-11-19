if has("gui_macvim")
	set gfn=Fantasque_Sans_Mono:h13,Hack:h12,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
elseif has("unix")
	set gfn=Fantasque\ Sans\ Mono\ 13,Hack\ 10,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
elseif has('nvim')
	GuiFont! Fantasque\ Sans\ Mono:h13
else
	set gfn=Fantasque_Sans_Mono:h13,Hack:h10,Consolas:h14
endif

if !has('nvim')
	set columns=999
	set lines=999
endif

fun! s:base16_customize() abort "{{{
	call Base16hi("Title", "", "", "", "", "bold", "")
	call Base16hi("Statement", "", "", "", "", "none", "")
	call Base16hi("Underlined", "", "", "", "", "underline", "")
	call Base16hi("StatusLine", "", "", "", "", "bold", "")
	call Base16hi("LineNr", "", g:base16_gui00, "", "", "", "")
	call Base16hi("SignColumn", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterAdd", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterChange", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterDelete", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterChangeDelete", "", g:base16_gui00, "", "", "", "")
	hi! link lCursor IncSearch
	hi! link Lf_hl_match Title
endfun
" }}}

fun! s:base16_zenburn_customize() abort "{{{
	call Base16hi("Delimiter", "8f8f8f", "", "", "", "", "")
	call Base16hi("SpecialChar", "dca3a3", "", "", "", "", "")
endfun
" }}}

fun! s:base16_tomorrow_cusomize() abort "{{{
	call Base16hi("StatusLine", "505050", "", "", "", "", "")
endfun
" }}}

augroup on_change_colorscheme
	autocmd!
	autocmd ColorScheme base16* call s:base16_customize()
	autocmd ColorScheme base16-zenburn call s:base16_zenburn_customize()
	autocmd ColorScheme base16-tomorrow call s:base16_tomorrow_cusomize()
augroup END

" DARK
" colo base16-oceanicnext
" colo base16-tomorrow-night
" colo base16-grayscale-dark
" LIGHT
" colo base16-one-light
colo base16-tomorrow
" colo base16-grayscale-light

" let g:duo_themes = ['base16-oceanicnext', 'base16-one-light']
let g:duo_themes = ['base16-tomorrow-night', 'base16-tomorrow']
" let g:duo_themes = ['base16-grayscale-light', 'base16-grayscale-dark']
fun! ToggleColorscheme()
	let color = filter(copy(g:duo_themes), {k,v-> v != g:colors_name})[0]
	exe "colorscheme ".color
endf

" Mimic toggling behaviour of Tim Popes unimpaired plugin
nnoremap yot :call ToggleColorscheme()<CR>
