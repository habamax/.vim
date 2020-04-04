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
" Sometimes I want syntax to be 'fancy'.
" let g:habamax_fancy = v:true
" use base16-default variation colors for dark background
" use one-light variation colors for light background
"
"
" ==============================================================================
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
        let g:terminal_color_0 = "#fcfffc"
        let g:terminal_color_1 = "#ca1243"
        let g:terminal_color_2 = "#50a14f"
        let g:terminal_color_3 = "#c18401"
        let g:terminal_color_4 = "#4078f2"
        let g:terminal_color_5 = "#a626a4"
        let g:terminal_color_6 = "#0184bc"
        let g:terminal_color_7 = "#383a42"
        let g:terminal_color_8 = "#a0a1a7"
        let g:terminal_color_9 = "#ca1243"
        let g:terminal_color_10 = "#50a14f"
        let g:terminal_color_11 = "#c18401"
        let g:terminal_color_12 = "#4078f2"
        let g:terminal_color_13 = "#a626a4"
        let g:terminal_color_14 = "#0184bc"
        let g:terminal_color_15 = "#090a0b"
        let g:terminal_color_background = g:terminal_color_7
        let g:terminal_color_foreground = g:terminal_color_2
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
    hi Title guifg=#e0385b gui=bold cterm=bold

    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLine guibg=#d3d3d3 gui=NONE cterm=NONE
    hi TabLineFill guibg=#d3d3d3 guifg=fg gui=NONE ctermfg=fg ctermbg=7 cterm=NONE term=NONE

    hi Folded guibg=#e0e4e0 guifg=#454945 gui=NONE guisp=NONE
    hi FoldColumn guibg=#e0e4e0 guifg=#454945 gui=NONE
    hi Visual guibg=#d0d9ea gui=NONE ctermbg=fg ctermfg=bg
    hi LineNr guibg=NONE guifg=#97a49c
    hi CursorLine guibg=#f0f5f0 guifg=NONE gui=NONE cterm=NONE

    hi Underlined gui=underline guisp=SlateBlue

    hi Error guibg=#e07070 guifg=bg
    hi Todo guifg=fg gui=bold

    "" Diff
    hi diffAdd guibg=#c9f9c9
    hi diffChange guibg=#f9f9c9
    hi diffText guibg=#f9d999 guifg=NONE gui=NONE
    hi diffDelete guibg=#f9c9c9 guifg=#707070 gui=NONE

    if get(g:, "habamax_flat", 0)
        hi Statement guifg=#4c6f6c ctermfg=8
        hi Constant guifg=#4c6f6c ctermfg=8
        hi Directory guifg=#4c6f6c ctermfg=8
        hi Comment ctermfg=7
        hi Conceal ctermfg=7
    elseif get(g:, "habamax_fancy", 0)
        hi Identifier guifg=#4078f2 gui=NONE cterm=NONE

        hi Statement guifg=#a626a4 gui=NONE cterm=NONE

        hi Constant guifg=#d75f00 gui=NONE cterm=NONE
        hi String guifg=#50a14f gui=NONE cterm=NONE

        hi PreProc guifg=#c18401 gui=NONE cterm=NONE

        hi Special guifg=#0184bc gui=NONE cterm=NONE
        hi Tag guifg=#c18401 gui=NONE cterm=NONE
        hi Delimiter guifg=#986801 gui=NONE cterm=NONE

        hi Type guifg=#ca1243 gui=NONE cterm=NONE

        hi Operator guifg=#383a42 gui=NONE cterm=NONE

        hi Directory guifg=#4078f2 gui=bold cterm=bold
    else
        " tone down Constant
        hi Constant guifg=#b02cb0
        hi Comment ctermfg=8
        hi Conceal ctermfg=8
    endif

    hi Comment guibg=NONE guifg=#777777 gui=italic cterm=NONE
    hi Conceal guibg=NONE guifg=#777777 gui=NONE cterm=NONE

    " Dark colors {{{1
else
    " Neovim terminal colours
    if has("nvim")
        let g:terminal_color_0 = "#202531"
        let g:terminal_color_1 = "#ab4642"
        let g:terminal_color_2 = "#a1b56c"
        let g:terminal_color_3 = "#f7ca88"
        let g:terminal_color_4 = "#7cafc2"
        let g:terminal_color_5 = "#ba8baf"
        let g:terminal_color_6 = "#86c1b9"
        let g:terminal_color_7 = "#d8d8d8"
        let g:terminal_color_8 = "#585858"
        let g:terminal_color_9 = "#ab4642"
        let g:terminal_color_10 = "#a1b56c"
        let g:terminal_color_11 = "#f7ca88"
        let g:terminal_color_12 = "#7cafc2"
        let g:terminal_color_13 = "#ba8baf"
        let g:terminal_color_14 = "#86c1b9"
        let g:terminal_color_15 = "#f8f8f8"
        let g:terminal_color_background = g:terminal_color_0
        let g:terminal_color_foreground = g:terminal_color_5
    elseif has("terminal")
        let g:terminal_ansi_colors = [
                    \ "#202531",
                    \ "#ab4642",
                    \ "#a1b56c",
                    \ "#f7ca88",
                    \ "#7cafc2",
                    \ "#ba8baf",
                    \ "#86c1b9",
                    \ "#d8d8d8",
                    \ "#585858",
                    \ "#ab4642",
                    \ "#a1b56c",
                    \ "#f7ca88",
                    \ "#7cafc2",
                    \ "#ba8baf",
                    \ "#86c1b9",
                    \ "#f8f8f8",
                    \ ]
    endif

    if get(g:, "habamax_contrast", v:false)
        hi Normal guibg=#000000 guifg=#dedede ctermbg=0 ctermfg=15
    else
        hi Normal guibg=#202531 guifg=#dedede ctermbg=0 ctermfg=15
    endif
    hi EndOfBuffer guibg=NONE guifg=#404551 ctermbg=NONE ctermfg=8
    hi Statusline guibg=#333b4f guifg=#dedede gui=NONE ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi VertSplit guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=7 cterm=NONE
    hi Title guifg=#ff5b7b gui=bold cterm=bold

    hi Pmenu guibg=#333b4f gui=NONE
    hi PmenuSel guibg=#41485b gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLine guibg=#434b5f gui=NONE cterm=NONE
    hi TabLineFill guibg=#434b5f guifg=fg gui=NONE ctermfg=fg ctermbg=8 cterm=NONE term=NONE

    hi Folded guibg=#303440 guifg=#909590 gui=NONE guisp=NONE
    hi FoldColumn guibg=#303440 guifg=#909590 gui=NONE
    hi Visual guibg=#394e71 guifg=NONE ctermbg=fg ctermfg=bg
    hi LineNr guibg=NONE guifg=#a1c2aa
    hi CursorLine guibg=#333844 guifg=NONE gui=NONE cterm=NONE

    hi Underlined guifg=#96b0d8 gui=underline guisp=#60708c
    hi Error guibg=#633e43 guifg=NONE
    hi Todo guifg=bg gui=bold

    hi diffAdd guibg=#294929
    hi diffChange guibg=#4f4719
    hi diffText guibg=#2f2f09 guifg=NONE gui=NONE
    hi diffDelete guibg=#492929 guifg=#707070 gui=NONE

    if get(g:, "habamax_flat", 0)
        hi Statement guifg=#9095a1 ctermfg=7
        hi Constant guifg=#9095a1 ctermfg=7
        hi Directory guifg=#9095a1 ctermfg=7
    elseif get(g:, "habamax_fancy", 0)
        hi Identifier guifg=#7cafc2 gui=NONE cterm=NONE

        hi Statement guifg=#ba8baf gui=NONE cterm=NONE

        hi Constant guifg=#dc9656 gui=NONE cterm=NONE
        hi String guifg=#a1b56c gui=NONE cterm=NONE

        hi PreProc guifg=#f7ca88 gui=NONE cterm=NONE

        hi Special guifg=#86c1b9 gui=NONE cterm=NONE
        hi Tag guifg=#f7ca88 gui=NONE cterm=NONE
        hi Delimiter guifg=#a16946 gui=NONE cterm=NONE

        hi Type guifg=#db7672 gui=NONE cterm=NONE

        hi Operator guifg=#d8d8d8 gui=NONE cterm=NONE

        hi Directory guifg=#7cafc2 gui=bold cterm=bold
    endif

    hi Comment guibg=NONE guifg=#777777 gui=italic ctermfg=8 cterm=NONE
    hi Conceal guibg=NONE guifg=#777777 gui=NONE ctermfg=8 cterm=NONE

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
hi StatuslineTerm gui=NONE
hi StatuslineTermNC gui=NONE
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
hi! link Lf_hl_popup_window Normal
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
