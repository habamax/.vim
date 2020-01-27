""" Customize colors {{{1
func! s:base16_setup()
	if '0x'.g:base16_gui00 > 0x777777
		set bg=light
	else
		set bg=dark
	endif

	"" Standard
	call Base16hi("Title", "", "", "", "", "bold", "")
	call Base16hi("Comment", "", "", "", "", "italic", "")
	call Base16hi("Statement", "", "", "", "", "NONE", "")
	call Base16hi("lCursor", "", g:base16_gui0F, "", "", "", "")
	call Base16hi("Conceal", g:base16_gui03, "", "", "", "", "")
	call Base16hi("NonText", g:base16_gui01, "", "", "", "NONE", "")
	call Base16hi("SpecialKey", g:base16_gui01, "", "", "", "NONE", "")
	call Base16hi("MatchParen", "", g:base16_gui01, "", "", "", "")

	"" Vimscript
	call Base16hi("vimVar", g:base16_gui05, "", "", "", "", "")
	call Base16hi("vimFBVar", g:base16_gui0C, "", "", "", "", "")

	"" Dirvish
	call Base16hi("DirvishPathTail", g:base16_gui0C, "", g:base16_cterm0C, "", "bold", "")

	"" Fugitive
	call Base16hi("gitcommitSummary", g:base16_gui0D, "", "", "", "bold", "")


	"" Asciidoctor
	call Base16hi("AsciidoctorOption", g:base16_gui03, "", "", "", "", "")
	call Base16hi("AsciidoctorBlock", g:base16_gui03, "", "", "", "", "")
	call Base16hi("AsciidoctorBlockOptions", g:base16_gui03, "", "", "", "", "")
	call Base16hi("AsciidoctorTableCell", g:base16_gui03, "", "", "", "", "")
	call Base16hi("AsciidoctorLiteralBlock", g:base16_gui04, "", "", "", "", "")
	call Base16hi("AsciidoctorIndented", g:base16_gui04, "", "", "", "", "")
	call Base16hi("AsciidoctorCaption", g:base16_gui0B, "", "", "", "", "")
	call Base16hi("AsciidoctorListMarker", g:base16_gui03, "", "", "", "", "")


	"" LeaderF
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

func! s:my_colorschemes_setup() abort
	hi Comment gui=italic
endfunc

augroup colorscheme_change | au!
	au ColorScheme base16* call s:base16_setup()
	au ColorScheme defminus,defnoche,lessthan call s:my_colorschemes_setup()
augroup END

"" Nice base16 colors are:
func! MY_LUCKY_COLORS() abort
	let colors = [
				\ 'base16-twilight',
				\ 'base16-one-light',
				\ 'base16-tomorrow-night',
				\ 'base16-oceanicnext',
				\ 'base16-harmonic-dark',
				\ 'base16-tomorrow-night-eighties',
				\ 'base16-darktooth',
				\ 'base16-default-dark',
				\ ]
	exe 'colorscheme ' . colors[rand() % len(colors)]
endfunc


""" Colorschemes {{{1

" If it happens you run vim late, use dark colors
if strftime("%H") >= 20 || strftime("%H") < 8 
	set bg=dark
else
	set bg=light
endif

"" Uncomment if you want random base16 colors (mostly) in your gVim
" call MY_LUCKY_COLORS()

" colorscheme base16-twilight
" colorscheme base16-harmonic-dark
colorscheme base16-oceanicnext
" colorscheme base16-one-light
" colorscheme base16-default-dark


" My timebased default colors -- when no other colorscheme was setup
if get(g:, "colors_name", "default") == "default"
	if &bg == "dark"
		let my_dark_colors = ['lessthan', 'defnoche']
		exe 'colorscheme ' . my_dark_colors[rand() % len(my_dark_colors)]
	else
		colorscheme defminus
	endif
endif


