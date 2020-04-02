" habamax.vim -- GUI colorscheme with almost default syntax highlighting
"
" Name:       habamax
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT, but who cares? This is colorscheme.
"
" Syntax colors stays default, except:
" - backgrounds are different
" - bold and italic styles are added and removed here and there
" - chrome is different (statuslines, folding, etc)
" - colors for plugins I use (leaderf etc)
" 
" Works OK for gui and with set termguicolors
" Otherwise it is kind of meh, but readable (uses default 16 colors palette)
"
"
" 
" ==============================================================================
"
" Sometimes I want my syntax to be 'boring'.
" let g:habamax_flat = v:true
" make it FLAT:
" * comments
" * statements
" * constants
"
"
" ==============================================================================
"
" Sometimes I want syntax to be 'fancy'. Make it look like Godot game engine:
" let g:habamax_godot = v:true
" use godot colors for dark background
"
" ==============================================================================
"
"
" To be even more boring with black background as dark and white background as
" light, use:
" let g:habamax_contrast = v:true
"

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'habamax'

"" Light colors {{{
if &background == 'light'

    " Neovim terminal colours
    if has("nvim")
        let g:terminal_color_0 =  "#fcfffc"
        let g:terminal_color_1 =  "#ca1243"
        let g:terminal_color_2 =  "#50a14f"
        let g:terminal_color_3 =  "#c18401"
        let g:terminal_color_4 =  "#4078f2"
        let g:terminal_color_5 =  "#a626a4"
        let g:terminal_color_6 =  "#0184bc"
        let g:terminal_color_7 =  "#383a42"
        let g:terminal_color_8 =  "#a0a1a7"
        let g:terminal_color_9 =  "#ca1243"
        let g:terminal_color_10 = "#50a14f"
        let g:terminal_color_11 = "#c18401"
        let g:terminal_color_12 = "#4078f2"
        let g:terminal_color_13 = "#a626a4"
        let g:terminal_color_14 = "#0184bc"
        let g:terminal_color_15 = "#090a0b"
        let g:terminal_color_background = g:terminal_color_0
        let g:terminal_color_foreground = g:terminal_color_5
        if &background == "light"
            let g:terminal_color_background = g:terminal_color_7
            let g:terminal_color_foreground = g:terminal_color_2
        endif
    elseif has("terminal")
        let g:terminal_ansi_colors = [
                    \ "#fcfffc",
                    \ "#ca1243",
                    \ "#50a14f",
                    \ "#c18401",
                    \ "#4078f2",
                    \ "#a626a4",
                    \ "#0184bc",
                    \ "#383a42",
                    \ "#a0a1a7",
                    \ "#ca1243",
                    \ "#50a14f",
                    \ "#c18401",
                    \ "#4078f2",
                    \ "#a626a4",
                    \ "#0184bc",
                    \ "#090a0b",
                    \ ]
    endif

    if get(g:, "habamax_contrast", v:false)
        hi Normal guibg=#ffffff guifg=#000000 ctermbg=15 ctermfg=16
    else
        hi Normal guibg=#fcfffc guifg=#000000 ctermbg=15 ctermfg=16
    endif
    hi EndOfBuffer guifg=#e0e0e0 guibg=NONE ctermfg=7 ctermbg=NONE
    hi Statusline guibg=#707080 guifg=#ffffff gui=NONE ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#707080 guifg=#c0c0c0 gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi VertSplit guibg=#707080 guifg=#c0c0c0 gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi Title guifg=#e0385b

    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLineFill guibg=#d3d3d3 guifg=fg gui=underline ctermfg=fg ctermbg=7 cterm=underline term=NONE

    hi Folded guibg=#e0e4e0 guifg=#454945 gui=NONE guisp=NONE
    hi FoldColumn guibg=#e0e4e0 guifg=#454945 gui=NONE
    hi Visual guibg=#d0d9ea gui=NONE ctermbg=fg ctermfg=bg
    hi LineNr guibg=NONE guifg=#97a49c
    hi CursorLine guibg=#f0f5f0 guifg=NONE

    hi Underlined gui=underline guisp=SlateBlue

    hi Error guibg=#e07070 guifg=bg
    hi Todo guifg=fg gui=bold

    "" Diff
    hi diffAdd guibg=#c9f9c9
    hi diffChange guibg=#f9f9c9
    hi diffText guibg=#f9d999 guifg=NONE gui=NONE
    hi diffDelete guibg=#f9c9c9 guifg=#707070 gui=NONE

    if get(g:, "habamax_flat", 0)
        hi Statement guifg=#5c5f5c
        hi Constant guifg=#5c5f5c
    else
        " tone down Constant
        hi Constant guifg=#b02cb0
    endif

    hi Comment guibg=NONE guifg=#777777 gui=italic ctermfg=8 cterm=NONE
    hi Conceal guibg=NONE guifg=#777777 gui=NONE ctermfg=8 cterm=NONE

    " Dark colors {{{1
else
    let g:terminal_ansi_colors =
                \ ['#000000', '#a05050', '#50a050', '#a0a050',
                \ '#5050a0', '#a050a0', '#50a0a0', '#c0c0c0',
                \ '#808080', '#ff7070', '#70ff70', '#7070ff',
                \ '#ff70ff', '#70ffff', '#ffffff', '#000000']

    if get(g:, "habamax_contrast", v:false)
        hi Normal guibg=#000000 guifg=#dedede ctermbg=0 ctermfg=15
    else
        hi Normal guibg=#202531 guifg=#dedede ctermbg=0 ctermfg=15
    endif
    hi EndOfBuffer guibg=NONE guifg=#404551 ctermbg=NONE ctermfg=8
    hi Statusline guibg=#333b4f guifg=#dedede gui=NONE ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi VertSplit guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi Title guifg=#ff5b7b

    hi Pmenu guibg=#333b4f gui=NONE
    hi PmenuSel guibg=#41485b gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLine guibg=#434b5f gui=underline cterm=underline
    hi TabLineFill guibg=#434b5f guifg=fg gui=underline ctermfg=fg ctermbg=8 cterm=underline term=NONE

    hi Folded guibg=#303440 guifg=#909590 gui=NONE guisp=NONE
    hi FoldColumn guibg=#303440 guifg=#909590 gui=NONE
    hi Visual guibg=#394e71 guifg=NONE ctermbg=fg ctermfg=bg
    hi LineNr guibg=NONE guifg=#a1c2aa
    hi CursorLine guibg=#333844 guifg=NONE

    hi Underlined guifg=#96b0d8 gui=underline guisp=#60708c
    hi Error guibg=#633e43 guifg=NONE
    hi Todo guifg=bg gui=bold

    hi diffAdd guibg=#294929
    hi diffChange guibg=#4f4719
    hi diffText guibg=#2f2f09 guifg=NONE gui=NONE
    hi diffDelete guibg=#492929 guifg=#707070 gui=NONE

    if get(g:, "habamax_godot", 0)
        hi Comment guibg=NONE guifg=#7e8189 gui=italic ctermfg=8 cterm=NONE
        hi Conceal guibg=NONE guifg=#7e8189 gui=NONE ctermfg=8 cterm=NONE
    else
        hi Comment guibg=NONE guifg=#777777 gui=italic ctermfg=8 cterm=NONE
        hi Conceal guibg=NONE guifg=#777777 gui=NONE ctermfg=8 cterm=NONE
    endif

    if get(g:, "habamax_flat", 0)
        hi Statement guifg=#9095a1 ctermfg=7
        hi Constant guifg=#9095a1 ctermfg=7
    elseif get(g:, "habamax_godot", 0)
        hi Constant guifg=#a1ffe0 gui=NONE
        hi String guifg=#ffeca1 gui=NONE
        hi Identifier guifg=#66e6ff gui=NONE
        hi Statement guifg=#ff7085 gui=NONE
        hi PreProc guifg=#63c259 gui=NONE
        hi Type guifg=#c6ffed gui=NONE
        hi Structure guifg=#8effda gui=NONE
        hi Typedef guifg=#42ffc2 gui=NONE
        hi Special guifg=#bce0ff gui=NONE
    endif
endif

" Dark and Light Syntax Highlighting {{{1

hi Statement gui=NONE cterm=NONE
hi Type gui=NONE cterm=NONE

if get(g:, "habamax_flat", 0)
    hi clear Type
    hi clear Identifier
    hi clear PreProc
    hi clear Special
endif


" Common Chrome {{{1
hi TabLineSel gui=NONE
hi Directory gui=bold
hi! link NonText EndOfBuffer
hi! link SpecialKey EndOfBuffer
hi! link CursorColumn CursorLine
hi! link CursorLineNr CursorLine
hi! link QuickFixLine CursorLine
hi SignColumn guibg=NONE
hi lCursor guibg=#ff7070
hi link TabLine StatusLineNC
hi link TabLineFill TabLine
hi link TabLineSel Normal
hi MatchParen guifg=fg ctermfg=fg


""" Plugins {{{1

"" Fugitive
hi link gitCommitSummary Title
hi! link diffRemoved diffDelete
hi! link diffAdded diffAdd
hi! link diffLine diffChange
hi! link diffSubname diffChange

"" Asciidoctor
if &background == 'light'
    hi asciidoctorIndented guifg=#555555 gui=NONE ctermbg=7 cterm=NONE
else
    hi asciidoctorIndented guifg=#999999 gui=NONE ctermbg=8 cterm=NONE
endif

"" Flat Syntax
if get(g:, "habamax_flat", 0)
    hi fugitiveUntrackedHeading gui=bold cterm=bold
    hi fugitiveUnstagedHeading gui=bold cterm=bold
    hi fugitiveStagedHeading gui=bold cterm=bold
    hi fugitiveHeading gui=bold cterm=bold
    hi fugitiveHeader gui=bold cterm=bold
    hi! link fugitiveUntrackedModifier Statement
    hi! link fugitiveUnstagedModifier Statement
    hi! link fugitiveStagedModifier Statement
    hi! link fugitiveHash Statement
    hi! link fugitiveSymbolicRef Statement

    hi! link asciidoctorListMarker Statement
    hi! link asciidoctorOrderedListMarker Statement
    hi! link asciidoctorListContinuation Statement
    hi! link asciidoctorIndented Statement
    hi! link asciidoctorPlus Statement
    hi! link asciidoctorPageBreak Statement
    hi! link asciidoctorCallout Statement
    hi! link asciidoctorCalloutDesc Statement
    hi! link asciidoctorListingBlock asciidoctorIndented
    hi! link asciidoctorLiteralBlock asciidoctorIndented
    hi! link asciidoctorAttribute Statement
    hi! link asciidoctorCode Constant
    hi! link asciidoctorBlock Statement
    hi! link asciidoctorOption Statement
    hi! link asciidoctorBlockOptions Statement
    hi! link asciidoctorTableSep Statement
    hi! link asciidoctorTableCell Statement
    hi! link asciidoctorTableEmbed Statement
    hi! link asciidoctorInlineAnchor Statement

    hi! link helpHeader Title
    hi! link helpSectionDelim Constant
    hi! link helpOption Constant
    hi! link helpHyperTextJump Underlined
    hi! link helpUrl Underlined

    hi! link pythonInclude Statement

    hi! link rubyInclude Statement
    hi! link rubyDefine Statement
    hi! link rubyStringDelimiter Constant
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
