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
	
	call Base16hi("Lf_hl_cursorline", g:base16_gui05, "", g:base16_cterm05, "", "", "")
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
				\ 'base16-default-dark',
				\ ]
	exe 'colorscheme ' . colors[rand() % len(colors)]
endfunc

