"" Customize base16 colors
func! s:base16_setup()
	if '0x'.g:base16_gui00 > 0x777777
		set bg=light
	else
		set bg=dark
	endif

	call Base16hi("Title", "", "", "", "", "bold", "")
	call Base16hi("Statement", "", "", "", "", "NONE", "")

	call Base16hi("DirvishPathTail", g:base16_gui0C, "", g:base16_cterm0C, "", "bold", "")

	call Base16hi("lCursor", "", g:base16_gui0F, "", "", "", "")

	call Base16hi("Lf_hl_popup_window", "", g:base16_gui00, "", "", "", "")

	call Base16hi("Lf_hl_stlName", g:base16_gui03, g:base16_gui02, g:base16_cterm03, g:base16_cterm02, "", "")
	call Base16hi("Lf_hl_stlMode", g:base16_gui0E, g:base16_gui02, g:base16_cterm0E, g:base16_cterm02, "", "")
	call Base16hi("Lf_hl_stlCategory", g:base16_gui03, g:base16_gui01, g:base16_cterm03, g:base16_cterm01, "", "")
	call Base16hi("Lf_hl_stlCwd", g:base16_gui04, g:base16_gui02, g:base16_cterm04, g:base16_cterm02, "", "")
	call Base16hi("Lf_hl_stlNameOnlyMode", g:base16_gui03, g:base16_gui02, g:base16_cterm03, g:base16_cterm02, "", "")
	call Base16hi("Lf_hl_stlRegexMode", g:base16_gui03, g:base16_gui02, g:base16_cterm03, g:base16_cterm02, "", "")
	call Base16hi("Lf_hl_stlFullPathMode", g:base16_gui03, g:base16_gui02, g:base16_cterm03, g:base16_cterm02, "", "")
	call Base16hi("Lf_hl_stlFuzzyMode", g:base16_gui03, g:base16_gui02, g:base16_cterm03, g:base16_cterm02, "", "")
	call Base16hi("Lf_hl_stlTotal", g:base16_gui03, g:base16_gui01, g:base16_cterm03, g:base16_cterm01, "", "")
	call Base16hi("Lf_hl_stlLineInfo", g:base16_gui03, g:base16_gui01, g:base16_cterm03, g:base16_cterm01, "", "")
	call Base16hi("Lf_hl_stlBlank", g:base16_gui03, g:base16_gui02, g:base16_cterm03, g:base16_cterm02, "", "")

endfunc

augroup colorscheme_change | au!
	au ColorScheme base16* call s:base16_setup()
augroup END

"" Nice base16 colors are:
func! MY_LUCKY_COLORS() abort
	let colors = [
				\ 'base16-twilight',
				\ 'base16-one-light',
				\ 'base16-black-metal-gorgoroth',
				\ 'base16-tomorrow-night',
				\ 'base16-oceanicnext',
				\ 'base16-harmonic-dark',
				\ 'base16-tomorrow-night-eighties',
				\ 'base16-darktooth',
				\ 'base16-default-dark'
				\ ]
	exe 'colorscheme ' . colors[rand() % len(colors)]
endfunc

"" Uncomment if you want fancy colors in your gVim
" call MY_LUCKY_COLORS()

" colorscheme base16-twilight
colorscheme base16-harmonic-dark

" My timebased default colors -- when no other colorscheme was setup
if get(g:, "colors_name", "default") == "default"
	" If it happens you run vim late, use dark colorscheme
	if strftime("%H") >= 20 || strftime("%H") < 8 
		colorscheme lessthan
	else
		colorscheme defminus
	endif
endif


"
" Однажды в студеную зимнюю пору
" Я из лесу вышел, был сильный мороз.
" З3 -- Z3
"
if has("gui_macvim")
	set gfn=Iosevka\ Slab\ Extended:h14,Hack:h14,Menlo:h14
	set macmeta
	let macvim_skip_colorscheme = 1
else
	set linespace=0
	set gfn=Iosevka\ Slab\ Extended:h14
	" set gfn=Hack:h14
	" set gfn=Fira\ Mono:h14
	" set gfn=Iosevka:h14
	" set gfn=Iosevka\ Slab:h14
	" set gfn=Consolas:h14
	" set gfn=Cascadia\ Code:h14
	" set gfn=PT\ Mono:h14
	" set gfn=Victor\ Mono\ Medium:h14
	" set gfn=IBM\ Plex\ Mono:h12
	" set gfn=Go\ Mono:h14
endif

set columns=200
set lines=200
