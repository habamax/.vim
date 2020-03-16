" habamax.vim -- GUI colorscheme with almost default syntax highlighting
"
" Name:       habamax
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT, but who cares? This is colorscheme.
"
" Syntax colors stays default
" - backgrounds are different
" - bold and italic styles are added and removed here and there
" - chrome is different (statuslines, folding, etc)
" - colors for plugins I use (leaderf etc)
" 
" Works OK for gui and with set termguicolors
" Otherwise it is kind of meh, but readable (uses default 16 colors palette)

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'habamax'

if &background == 'light'
    " hi Normal guibg=#ffffff guifg=#000000
    " hi Normal guibg=#e9f5ec guifg=#000000
    " hi Normal guibg=#f9fffb guifg=#000000
    hi Normal guibg=#fcfffc guifg=#000000 ctermbg=15 ctermfg=16
    hi EndOfBuffer guifg=#e0e0e0 guibg=NONE ctermfg=7 ctermbg=NONE
    hi Statusline guibg=#707080 guifg=#ffffff gui=NONE ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#707080 guifg=#c0c0c0 gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi VertSplit guibg=#707080 guifg=#c0c0c0 gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi Title guifg=#e0385b

    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi Folded guibg=#e0e4e0 guifg=#454945 gui=NONE
    hi Visual guibg=#d0d9ea gui=NONE ctermbg=fg ctermfg=bg
    hi LineNr guibg=NONE guifg=#97a49c

    hi CursorLine guibg=gray90 gui=NONE ctermbg=7 cterm=NONE
    hi CursorLineNr guibg=NONE guifg=#767982 gui=NONE ctermbg=7 cterm=NONE
else
    hi Normal guibg=#202531 guifg=#dedede ctermbg=0 ctermfg=15
    hi EndOfBuffer guibg=NONE guifg=#404551 ctermbg=NONE ctermfg=8
    hi Statusline guibg=#333b4f guifg=#dedede gui=NONE ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi VertSplit guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi Title guifg=#f0486b

    hi Pmenu guibg=#333b4f gui=NONE
    hi PmenuSel guibg=#41485b gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi Folded guibg=#303440 guifg=fg gui=NONE
    hi Visual guibg=#394e71 guifg=NONE ctermbg=fg ctermfg=bg
    hi LineNr guibg=NONE guifg=#a1c2aa

    hi CursorLine guibg=#303440 gui=NONE ctermbg=7 cterm=NONE
    hi CursorLineNr guibg=NONE guifg=#767982 gui=NONE ctermbg=7 cterm=NONE

    hi Underlined guifg=#96b0d8 gui=underline guisp=#60708c
    hi Error guibg=#633e43 guifg=NONE
endif

hi Comment guibg=NONE guifg=#777777 gui=italic ctermfg=8 cterm=NONE
hi Conceal guibg=NONE guifg=#777777 gui=NONE ctermfg=8 cterm=NONE
hi Statement gui=NONE cterm=NONE
hi Type gui=NONE cterm=NONE

hi Directory gui=bold

" hi! link WildMenu PmenuSel
hi! link FoldColumn Folded
hi! link NonText EndOfBuffer
hi! link CursorColumn CursorLine
hi! link QuickFixLine CursorLine
hi SignColumn guibg=NONE
hi lCursor guibg=#ff7070
hi link TabLine StatusLineNC
hi link TabLineFill TabLine
hi link TabLineSel Normal


""" Plugins

"" Asciidoctor
if &background == 'light'
    hi asciidoctorIndented guifg=#555555 gui=NONE
else
    hi asciidoctorIndented guifg=#999999 gui=NONE
endif

"" LeaderF
hi link Lf_hl_bufDirname Comment
hi link Lf_hl_funcDirname Comment
hi link Lf_hl_rgFilename Comment
hi link Lf_hl_rgTagFile Comment
hi link Lf_hl_tagFile Comment
hi link Lf_hl_tagType Comment
hi link Lf_hl_tagKeyword Comment
hi link Lf_hl_buftagKind Comment
hi link Lf_hl_buftagScopeType Comment
hi link Lf_hl_buftagScope Comment
hi link Lf_hl_buftagDirname Comment
hi link Lf_hl_buftagCode Comment
hi link Lf_hl_helpTagfile Comment
hi link Lf_hl_gtagsFileName Comment
hi Lf_hl_cursorline guifg=fg

" Leaderf "chrome"
hi link Lf_hl_stlName StatuslineNC
hi link Lf_hl_stlMode StatuslineNC
hi link Lf_hl_stlCategory StatuslineNC
hi link Lf_hl_stlSeparator0 StatuslineNC
hi link Lf_hl_stlSeparator1 StatuslineNC
hi link Lf_hl_stlSeparator2 StatuslineNC
hi link Lf_hl_stlSeparator3 StatuslineNC
hi link Lf_hl_stlSeparator4 StatuslineNC
hi link Lf_hl_stlSeparator5 StatuslineNC
hi link Lf_hl_stlLineInfo StatuslineNC
hi link Lf_hl_stlNameOnlyMode StatuslineNC
hi link Lf_hl_stlRegexMode StatuslineNC
hi link Lf_hl_stlFullPathMode StatuslineNC
hi link Lf_hl_stlFuzzyMode StatuslineNC
hi link Lf_hl_stlCwd Statusline
hi link Lf_hl_stlTotal StatuslineNC
hi link Lf_hl_stlBlank Statusline


" Leaderf Popup
hi! link Lf_hl_popup_window GodotoNormal
hi! link Lf_hl_popup_inputMode StatusLineNC
hi! link Lf_hl_popup_inputText StatusLine
hi! link Lf_hl_popup_prompt StatusLine
hi! link Lf_hl_popup_spin StatusLineNC
hi! link Lf_hl_popup_mode StatusLineNC
hi! link Lf_hl_popup_category StatusLineNC
hi! link Lf_hl_popup_cwd StatusLine
hi! link Lf_hl_popup_separator0 StatusLineNC
hi! link Lf_hl_popup_separator1 StatusLineNC
hi! link Lf_hl_popup_separator2 StatusLineNC
hi! link Lf_hl_popup_separator3 StatusLineNC
hi! link Lf_hl_popup_separator4 StatusLineNC
hi! link Lf_hl_popup_separator5 StatusLineNC
hi! link Lf_hl_popup_lineInfo StatusLineNC
hi! link Lf_hl_popup_nameOnlyMode StatusLineNC
hi! link Lf_hl_popup_regexMode StatusLineNC
hi! link Lf_hl_popup_fullPathMode StatusLineNC
hi! link Lf_hl_popup_fuzzyMode StatusLineNC
hi! link Lf_hl_popup_total StatusLineNC
hi! link Lf_hl_popup_blank StatusLineNC
