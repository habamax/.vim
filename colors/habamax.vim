" habamax.vim -- colorscheme with almost default syntax highlighting
"
" Name:       habamax
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT, but who cares? This is colorscheme.

hi clear
if exists('syntax_on')
	syntax reset
endif


hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'habamax'

if &background == 'light'
    " hi Normal guibg=#ecf5ec guifg=#000000
    hi Normal guibg=#e9f5ec guifg=#000000
    hi EndOfBuffer guibg=NONE guifg=#e0e0e0
    hi Statusline guibg=#707080 guifg=#ffffff gui=NONE
    hi StatuslineNC guibg=#707080 guifg=#c0c0c0 gui=NONE
    hi VertSplit guibg=#707080 guifg=#c0c0c0 gui=NONE
    hi Title guifg=#e0385b

    hi Pmenu guibg=#c7d5cc gui=NONE
    hi PmenuSel guibg=#b0c0b0 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858
else
    hi Normal guibg=#202531 guifg=#dedede
    hi EndOfBuffer guibg=NONE guifg=#404551
    hi Statusline guibg=#333b4f guifg=#dedede gui=NONE
    hi StatuslineNC guibg=#333b4f guifg=#636b7f gui=NONE
    hi VertSplit guibg=#333b4f guifg=#636b7f gui=NONE
    hi Title guifg=#f0486b

    hi Pmenu guibg=#333b4f gui=NONE
    hi PmenuSel guibg=#41485b gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi Folded guibg=#303440 guifg=fg gui=NONE
    hi Visual guibg=#394e71 guifg=NONE
    hi LineNr guibg=NONE guifg=#a1c2aa

    hi CursorLine guibg=#303440
    hi CursorLineNr guibg=NONE guifg=#767982 gui=NONE

    hi Underlined guifg=#96b0d8 gui=underline guisp=#60708c
    hi Error guibg=#633e43 guifg=NONE
endif

hi Comment guifg=#777777 gui=italic
hi Conceal guifg=#777777 guibg=NONE gui=NONE
hi Statement gui=NONE
hi Type gui=NONE

hi Directory gui=bold

" hi! link WildMenu PmenuSel
hi! link FoldColumn Folded
hi! link CursorColumn CursorLine
hi SignColumn guibg=NONE
hi lCursor guibg=#ff7070
hi link TabLine StatusLineNC
hi link TabLineFill TabLine
hi link TabLineSel Normal


""" Plugins

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
hi! link Lf_hl_popup_inputMode StatusLine 
hi! link Lf_hl_popup_inputText StatusLineNC
hi! link Lf_hl_popup_prompt StatusLine
hi! link Lf_hl_popup_spin StatusLine
hi! link Lf_hl_popup_mode StatusLine 
hi! link Lf_hl_popup_category StatusLine
hi! link Lf_hl_popup_cwd StatusLine
hi! link Lf_hl_popup_separator0 StatusLine
hi! link Lf_hl_popup_separator1 StatusLine
hi! link Lf_hl_popup_separator2 StatusLine
hi! link Lf_hl_popup_separator3 StatusLine
hi! link Lf_hl_popup_separator4 StatusLine
hi! link Lf_hl_popup_separator5 StatusLine
hi! link Lf_hl_popup_lineInfo StatusLine
hi! link Lf_hl_popup_nameOnlyMode StatusLine 
hi! link Lf_hl_popup_regexMode StatusLine 
hi! link Lf_hl_popup_fullPathMode StatusLine 
hi! link Lf_hl_popup_fuzzyMode StatusLine 
hi! link Lf_hl_popup_total StatusLine 
hi! link Lf_hl_popup_blank StatusLine
