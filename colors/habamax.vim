" habamax.vim -- GUI colorscheme {{{
"
" Name: habamax
" Author: Maxim Kim <habamax@gmail.com>
" License: MIT, but who cares? This is colorscheme.
" URL: https://github.com/habamax/.vim/
" Description: Colors to please my eyes.
" Syntax colors are based on base16-default-dark and base16-onelight
"
" Works OK for gui and with set termguicolors
" Otherwise it is kind of meh, but readable (uses default 16 colors palette)
" 
" ------------------------------------------------------------------------------
"
" Sometimes I want my syntax to be 'boring'.
" let g:habamax_flat = v:true
" make it FLAT:
" * comments
" * statements
" * constants
"
" ------------------------------------------------------------------------------
"
" To add more contrast, use:
" let g:habamax_contrast = v:true
"
" }}}

hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'habamax'

"" Light colors {{{
if &background == 'light'

    " Neovim terminal colours
    if has("nvim")
        let g:terminal_color_0 = "#f5f6f7"
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
                    \ "#f5f6f7",
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

    if get(g:, "habamax_transparent", v:false)
        hi Normal NONE
    elseif get(g:, "habamax_contrast", v:false)
        hi Normal guibg=#ffffff guifg=#000000 ctermbg=white ctermfg=black
    else
        hi Normal guibg=#f5f6f7 guifg=#000000 ctermbg=white ctermfg=black
    endif
    hi EndOfBuffer guifg=#d0d0d0 guibg=NONE ctermfg=7 ctermbg=NONE
    hi Statusline guibg=#707080 guifg=#ffffff gui=NONE ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#707080 guifg=#c0c0c0 gui=NONE ctermbg=8 ctermfg=16 cterm=NONE
    hi VertSplit guibg=#707080 guifg=#707080 gui=NONE ctermbg=8 ctermfg=8 cterm=NONE

    hi Pmenu guibg=#d5d7da gui=NONE
    hi PmenuSel guibg=#c5c7c7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLine guibg=#d3d3d3 gui=NONE cterm=NONE
    hi TabLineFill guibg=#d3d3d3 guifg=NONE gui=NONE ctermfg=NONE ctermbg=7 cterm=NONE term=NONE

    hi Folded guibg=#e0e4e4 guifg=#454945 gui=NONE guisp=NONE
    hi Visual guibg=#d0d9ea gui=NONE
    hi LineNr guibg=NONE guifg=#5f6571 gui=NONE cterm=NONE term=NONE
    hi CursorLine guibg=#e0e4e4 guifg=NONE gui=NONE cterm=NONE term=NONE

    hi Underlined gui=underline guisp=SlateBlue

    hi Error guibg=#e07070 guifg=NONE
    hi Todo guibg=#e0e070 guifg=NONE gui=bold
    hi MatchParen guibg=#abf0f0 guifg=NONE gui=NONE
    hi Search guibg=#c18401 guifg=bg gui=NONE cterm=NONE
    hi IncSearch guibg=#d75f00 guifg=bg gui=NONE cterm=NONE
    hi WildMenu guibg=#c18401 guifg=bg gui=NONE cterm=NONE

    "" Diff
    hi diffAdd guibg=#c9f9c9
    hi diffChange guibg=#f9f9c9
    hi diffText guibg=#f9d999 guifg=NONE gui=NONE
    hi diffDelete guibg=#f9c9c9 guifg=#707070 gui=NONE

    if get(g:, "habamax_flat", 0)
        hi Title guifg=#000000 gui=bold cterm=bold
        hi Directory guifg=#475767 ctermfg=8
        hi Statement guifg=#475767 gui=NONE ctermfg=8 cterm=NONE
        hi Constant guifg=#475767 gui=NONE ctermfg=8 cterm=NONE
        hi clear Special
        hi clear PreProc
        hi clear Type
        hi clear Identifier
        hi Comment guibg=NONE guifg=#777777 gui=italic cterm=NONE
        hi Conceal guibg=NONE guifg=#777777 gui=NONE cterm=NONE
    else
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

        hi Comment guibg=NONE guifg=#777777 gui=italic cterm=NONE
        hi Conceal guibg=NONE guifg=#777777 gui=NONE cterm=NONE

        hi Title guifg=#e0385b gui=bold cterm=bold
    endif

" Dark colors {{{1
else
    " Neovim terminal colours
    if has("nvim")
        let g:terminal_color_0 = "#202531"
        let g:terminal_color_1 = "#db7672"
        let g:terminal_color_2 = "#a1b56c"
        let g:terminal_color_3 = "#f7ca88"
        let g:terminal_color_4 = "#7cafc2"
        let g:terminal_color_5 = "#ba8baf"
        let g:terminal_color_6 = "#86c1b9"
        let g:terminal_color_7 = "#d8d8d8"
        let g:terminal_color_8 = "#585858"
        let g:terminal_color_9 = "#db7672"
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
                    \ "#db7672",
                    \ "#a1b56c",
                    \ "#f7ca88",
                    \ "#7cafc2",
                    \ "#ba8baf",
                    \ "#86c1b9",
                    \ "#d8d8d8",
                    \ "#585858",
                    \ "#db7672",
                    \ "#a1b56c",
                    \ "#f7ca88",
                    \ "#7cafc2",
                    \ "#ba8baf",
                    \ "#86c1b9",
                    \ "#f8f8f8",
                    \ ]
    endif

    if get(g:, "habamax_transparent", v:false)
        hi Normal NONE
    elseif get(g:, "habamax_contrast", v:false)
        hi Normal guibg=#000000 guifg=#dedede ctermbg=black ctermfg=white
    else
        hi Normal guibg=#202531 guifg=#dedede ctermbg=black ctermfg=white
    endif
    hi EndOfBuffer guibg=NONE guifg=#404551 ctermbg=NONE ctermfg=8
    hi Statusline guibg=#333b4f guifg=#dedede gui=NONE ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=16 cterm=NONE
    hi VertSplit guibg=#333b4f guifg=#333b4f gui=NONE ctermbg=8 ctermfg=8 cterm=NONE

    hi Pmenu guibg=#333b4f gui=NONE
    hi PmenuSel guibg=#41485b gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLine guibg=#434b5f gui=NONE cterm=NONE
    hi TabLineFill guibg=#434b5f guifg=NONE gui=NONE ctermfg=NONE ctermbg=8 cterm=NONE term=NONE

    hi Folded guibg=#262b37 guifg=#909590 gui=NONE guisp=NONE
    hi Visual guibg=#394e71 guifg=NONE
    hi LineNr guibg=NONE guifg=#5f6571 gui=NONE cterm=NONE term=NONE
    hi CursorLine guibg=#333844 guifg=NONE gui=NONE cterm=NONE term=NONE

    hi Underlined guifg=#96b0d8 gui=underline guisp=#60708c
    hi Error guibg=#633e43 guifg=NONE
    hi Todo guibg=#93933e guifg=#202531 gui=bold
    hi MatchParen guibg=#006060 guifg=NONE gui=NONE
    hi Search guibg=#f7ca88 guifg=#262b37 gui=NONE cterm=NONE
    hi IncSearch guibg=#dc9656 guifg=#262b37 gui=NONE cterm=NONE
    hi WildMenu guibg=#f7ca88 guifg=#262b37 gui=NONE cterm=NONE

    hi diffAdd guibg=#294929
    hi diffChange guibg=#4f4719
    hi diffText guibg=#2f2f09 guifg=NONE gui=NONE
    hi diffDelete guibg=#492929 guifg=#707070 gui=NONE

    if get(g:, "habamax_flat", 0)
        hi Title guifg=#ffffff gui=bold cterm=bold
        hi Directory guifg=#9095a1 ctermfg=7
        hi Statement guifg=#9095a1 gui=NONE ctermfg=7 cterm=NONE
        hi Constant guifg=#9095a1 gui=NONE ctermfg=7 cterm=NONE
        hi clear Special
        hi clear PreProc
        hi clear Type
        hi clear Identifier
        hi Comment guibg=NONE guifg=#777777 gui=italic cterm=NONE
        hi Conceal guibg=NONE guifg=#777777 gui=NONE cterm=NONE
    else
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

        hi Comment guibg=NONE guifg=#777777 gui=italic cterm=NONE
        hi Conceal guibg=NONE guifg=#777777 gui=NONE cterm=NONE

        hi Title guifg=#ff5b7b gui=bold cterm=bold
    endif

endif


" Common Chrome {{{1
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link FoldColumn LineNr
hi TabLineSel gui=NONE
hi Directory gui=bold
hi! link NonText EndOfBuffer
hi! link SpecialKey EndOfBuffer
hi! link CursorColumn CursorLine
hi! link CursorLineNr CursorLine
hi! link QuickFixLine CursorLine
hi SignColumn guibg=NONE ctermbg=NONE
hi lCursor guibg=#ff7070
hi MatchParen guifg=NONE ctermfg=NONE


""" Plugins {{{1

"" FZF.vim statusline
hi! link fzf1 StatusLine
hi! link fzf2 StatusLine
hi! link fzf3 StatusLine

if !has('win32')
    let g:fzf_colors =
                \ {
                \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+': ['fg', 'Statement'],
                \ 'gutter': ['bg', 'Normal']
                \ }
endif


"" Fugitive && Gitgutter
hi link gitCommitSummary Title
hi diffAdded guifg=#20a020 gui=NONE ctermfg=green
hi diffRemoved guifg=#ff5050 gui=NONE ctermfg=red
hi! link diffLine diffChange
hi! link diffSubname diffText
hi! link GitGutterAdd diffAdded
hi! link GitGutterDelete diffRemoved
hi! GitGutterChange guifg=#c18401 ctermfg=yellow

"" Coc.nvim
hi! link CocErrorSign diffRemoved

"" Asciidoctor
if &background == 'light'
    hi asciidoctorIndented guifg=#555555 gui=NONE ctermfg=1 cterm=NONE
else
    hi asciidoctorIndented guifg=#999999 gui=NONE ctermfg=1 cterm=NONE
endif
if get(g:, "habamax_flat", v:false)
    hi link asciidoctorOption Constant
    hi link asciidoctorBlock Constant
    hi link asciidoctorAttribute Constant
    hi link asciidoctorTableCell Constant
    hi link asciidoctorInlineAnchor Constant
    hi link asciidoctorBlockOptions Constant
    hi link asciidoctorOrderedListMarker Constant
    hi link asciidoctorListMarker Constant
    hi link asciidoctorMacro Constant

    hi link fugitiveHeading Constant
    hi link fugitiveStagedHeading Constant
    hi link fugitiveUnstagedHeading Constant
    hi link fugitiveUntrackedHeading Constant
    hi link fugitiveHash Constant
    hi link fugitiveModifier Constant
    hi link fugitiveUntrackedModifier Constant
    hi link fugitiveUnstagedModifier Constant
    hi link fugitiveStagedModifier Constant
else
    " restore default fugitive colors (as of 2020-04-25)
    hi link fugitiveHeader Label
    hi link fugitiveHeading PreProc
    hi link fugitiveUntrackedHeading PreCondit
    hi link fugitiveUnstagedHeading Macro
    hi link fugitiveStagedHeading Include
    hi link fugitiveModifier Type
    hi link fugitiveUntrackedModifier StorageClass
    hi link fugitiveUnstagedModifier Structure
    hi link fugitiveStagedModifier Typedef
    hi link fugitiveInstruction Type
    hi link fugitiveStop Function
    hi link fugitiveHash Identifier
    hi link fugitiveSymbolicRef Function
    hi link fugitiveCount Number
end



finish
"" I don't use leaderf at the moment so just stop here 2020-05-13
"" Check in 6+ months and delete it


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

" This exact highlight group for leaderf can only be overwritten with linking
" another group which is not what I would expect from 
" :highlight def Lf_hl_cursorline
" definition
hi DumbNONE guifg=NONE
hi link Lf_hl_cursorline DumbNONE

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
hi link Lf_hl_stlBlank Statusline
hi link Lf_hl_stlSpin StatuslineNC
hi link Lf_hl_stlTotal StatuslineNC

" Leaderf Popup
hi! link Lf_hl_popup_window Normal
hi! link Lf_hl_popup_inputMode StatusLineNC
hi! link Lf_hl_popup_inputText StatusLine
hi! link Lf_hl_popup_prompt StatusLineNC
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
hi! link Lf_hl_popup_blank StatusLine
