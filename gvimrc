" Fonts {{{1
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
	" set gfn=Hack:h10,Consolas:h14
endif

" Window size {{{1
if !has('nvim')
	set columns=999
	set lines=999
endif

" Colors {{{1
fun! s:base16_customize() abort "{{{
	call Base16hi("Title", "", "", "", "", "bold", "")
	" call Base16hi("Statement", "", "", "", "", "", "")
	call Base16hi("Comment", "", "", "", "", "italic", "")
	call Base16hi("Underlined", "", "", "", "", "underline", "")
	call Base16hi("StatusLine", "", "", "", "", "bold", "")
	call Base16hi("htmlBold", g:base16_gui05, "", "", "", "bold", "")
	call Base16hi("LineNr", "", g:base16_gui00, "", "", "", "")
	call Base16hi("SignColumn", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterAdd", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterChange", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterDelete", "", g:base16_gui00, "", "", "", "")
	call Base16hi("GitGutterChangeDelete", "", g:base16_gui00, "", "", "", "")
	hi! link lCursor IncSearch
endfun
" }}}

fun! s:base16_zenburn_customize() abort "{{{
	call Base16hi("Delimiter", "8f8f8f", "", "", "", "", "")
	call Base16hi("SpecialChar", "dca3a3", "", "", "", "", "")
endfun
" }}}

fun! s:base16_tomorrow_customize() abort "{{{
	call Base16hi("StatusLine", "505050", "", "", "", "", "")
endfun
" }}}

fun! s:leaderf_customize() abort "{{{
	hi! link Lf_hl_match Title
	" customize leaderF
	if exists('g:colors_name') && g:colors_name =~ '^base16.*'
		" Palette {{{
		let g:Lf_StlPalette = {
				\   'stlName': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlCategory': {'gui': 'bold', 'guifg': '#'.g:base16_gui0D, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm0D, 'ctermbg': g:base16_cterm02},
				\   'stlNameOnlyMode': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlFullPathMode': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlFuzzyMode': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlRegexMode': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlCwd': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlBlank': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlLineInfo': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02},
				\   'stlTotal': {'gui': 'NONE', 'guifg': '#'.g:base16_gui04, 'guibg': '#'.g:base16_gui02, 'cterm': 'bold', 'ctermfg': g:base16_cterm04, 'ctermbg': g:base16_cterm02}
				\ }
		"}}}
	else
		" Palette {{{
		let g:Lf_StlPalette = { 'stlName': { 'gui': 'bold', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#98C379', 'cterm': 'bold', 'ctermfg': '16', 'ctermbg': '76' },
            \   'stlCategory': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#E06C75', 'cterm': 'NONE', 'ctermfg': '16', 'ctermbg': '168' },
            \   'stlNameOnlyMode': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#61AFEF', 'cterm': 'NONE', 'ctermfg': '16', 'ctermbg': '75' },
            \   'stlFullPathMode': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#61AFEF', 'cterm': 'NONE', 'ctermfg': '16', 'ctermbg': '147' },
            \   'stlFuzzyMode': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#E5C07B', 'cterm': 'NONE', 'ctermfg': '16', 'ctermbg': '180' },
            \   'stlRegexMode': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#98C379', 'cterm': 'NONE', 'ctermfg': '16', 'ctermbg': '76' },
            \   'stlCwd': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#ABB2BF', 'guibg': '#475265', 'cterm': 'NONE', 'ctermfg': '145', 'ctermbg': '236' },
            \   'stlBlank': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#ABB2BF', 'guibg': '#3E4452', 'cterm': 'NONE', 'ctermfg': '145', 'ctermbg': '235' },
            \   'stlLineInfo': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#98C379', 'cterm': 'NONE', 'ctermfg': '16', 'ctermbg': '76'  },
            \   'stlTotal': { 'gui': 'NONE', 'font': 'NONE', 'guifg': '#3E4452', 'guibg': '#98C379', 'cterm': 'NONE', 'ctermfg': '16', 'ctermbg': '76' }
            \ }
		"}}}
	endif
	let g:leaderf#colorscheme#default#palette = g:Lf_StlPalette
endfun
" }}}

augroup on_change_colorscheme
	au!
	au ColorScheme base16* call s:base16_customize()
	au ColorScheme base16-zenburn call s:base16_zenburn_customize()
	au ColorScheme base16-tomorrow call s:base16_tomorrow_customize()
	au ColorScheme * call s:leaderf_customize()
augroup END

let g:duo_themes = ['base16-one-light', 'base16-tomorrow-night']
" let g:duo_themes = ['base16-grayscale-light', 'base16-grayscale-dark']
" let g:duo_themes = ['base16-one-light', 'base16-default-dark']
" let g:duo_themes = ['base16-one-light', 'base16-oceanicnext']
fun! ToggleColorscheme()
	if !exists('g:colors_name')
		let g:colors_name = 'default'
	endif
	let color = filter(copy(g:duo_themes), {k, v -> v != g:colors_name})[0]
	exe "colorscheme ".color
endf

exe "colorscheme ".g:duo_themes[0]

" Mimic toggling behaviour of Tim Popes unimpaired plugin
nnoremap yot :call ToggleColorscheme()<CR>
