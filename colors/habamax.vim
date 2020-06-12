" habamax.vim -- GUI colorscheme {{{
"
" Name: habamax
" Author: Maxim Kim <habamax@gmail.com>
" License: MIT, but who cares? This is colorscheme.
" URL: https://github.com/habamax/.vim/
" Description: Colors to please my eyes.
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
        let g:terminal_color_0 = "#fafafa"
        let g:terminal_color_1 = "#ca1243"
        let g:terminal_color_2 = "#2a871f"
        let g:terminal_color_3 = "#c18401"
        let g:terminal_color_4 = "#2c5ff5"
        let g:terminal_color_5 = "#a626a4"
        let g:terminal_color_6 = "#0184bc"
        let g:terminal_color_7 = "#383a42"
        let g:terminal_color_8 = "#a0a1a7"
        let g:terminal_color_9 = "#ca1243"
        let g:terminal_color_10 = "#2a871f"
        let g:terminal_color_11 = "#c18401"
        let g:terminal_color_12 = "#2c5ff5"
        let g:terminal_color_13 = "#a626a4"
        let g:terminal_color_14 = "#0184bc"
        let g:terminal_color_15 = "#090a0b"
    elseif has("terminal")
        let g:terminal_ansi_colors = [
                    \ "#fafafa",
                    \ "#ca1243",
                    \ "#2a871f",
                    \ "#c18401",
                    \ "#2c5ff5",
                    \ "#a626a4",
                    \ "#0184bc",
                    \ "#383a42",
                    \ "#a0a1a7",
                    \ "#ca1243",
                    \ "#2a871f",
                    \ "#c18401",
                    \ "#2c5ff5",
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
        hi Normal guibg=#fafafa guifg=#000000 ctermbg=white ctermfg=black
    endif
    hi EndOfBuffer guifg=#d0d0d0 guibg=NONE ctermfg=7 ctermbg=NONE
    hi Statusline guibg=#cacbcc guifg=#000000 gui=bold ctermbg=8 ctermfg=15 cterm=NONE
    hi StatuslineNC guibg=#cacbcc guifg=#707070 gui=NONE ctermbg=8 ctermfg=16 cterm=NONE
    hi VertSplit guibg=#cacbcc guifg=#cacbcc gui=NONE ctermbg=8 ctermfg=8 cterm=NONE

    hi Pmenu guibg=#d5d7da gui=NONE
    hi PmenuSel guibg=#c5c7c7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLine guibg=#cacbcc gui=NONE cterm=NONE
    hi TabLineFill guibg=#cacbcc guifg=NONE gui=NONE ctermfg=NONE ctermbg=7 cterm=NONE term=NONE

    hi Folded guibg=#e0e4e4 guifg=#454945 gui=NONE guisp=NONE
    hi Visual guibg=#d0d9ea gui=NONE
    hi LineNr guibg=NONE guifg=#5f6571 gui=NONE cterm=NONE term=NONE
    hi CursorLine guibg=#e0e4e4 guifg=NONE gui=NONE cterm=NONE term=NONE

    hi Underlined gui=underline guisp=SlateBlue

    hi Error guibg=#e07070 guifg=bg gui=NONE
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

    hi Identifier guifg=#2c5ff5 gui=NONE cterm=NONE
    hi Statement guifg=#ca1243 gui=NONE cterm=NONE
    hi Constant guifg=#d75f00 gui=NONE cterm=NONE
    hi String guifg=#2a871f gui=NONE cterm=NONE
    hi PreProc guifg=#c18401 gui=NONE cterm=NONE
    hi Special guifg=#0184bc gui=NONE cterm=NONE
    hi Tag guifg=#c18401 gui=NONE cterm=NONE
    hi Delimiter guifg=#986801 gui=NONE cterm=NONE
    hi Type guifg=#a626a4 gui=NONE cterm=NONE
    hi Operator guifg=#c18401 gui=NONE cterm=NONE
    hi Directory guifg=#2c5ff5 gui=bold cterm=bold
    hi Comment guibg=NONE guifg=#777887 gui=italic cterm=NONE
    hi Conceal guibg=NONE guifg=#777887 gui=NONE cterm=NONE

    hi Title guifg=#e0385b gui=bold cterm=bold

" Dark colors {{{1
else
    " Neovim terminal colours
    if has("nvim")
        let g:terminal_color_0 = "#202531"
        let g:terminal_color_1 = "#fa7585"
        let g:terminal_color_2 = "#a1b56c"
        let g:terminal_color_3 = "#f7ca88"
        let g:terminal_color_4 = "#5ab0fa"
        let g:terminal_color_5 = "#ba8baf"
        let g:terminal_color_6 = "#86c1b9"
        let g:terminal_color_7 = "#d8d8d8"
        let g:terminal_color_8 = "#585858"
        let g:terminal_color_9 = "#fa7585"
        let g:terminal_color_10 = "#a1b56c"
        let g:terminal_color_11 = "#f7ca88"
        let g:terminal_color_12 = "#5ab0fa"
        let g:terminal_color_13 = "#ba8baf"
        let g:terminal_color_14 = "#86c1b9"
        let g:terminal_color_15 = "#f8f8f8"
    elseif has("terminal")
        let g:terminal_ansi_colors = [
                    \ "#202531",
                    \ "#fa7585",
                    \ "#a1b56c",
                    \ "#f7ca88",
                    \ "#5ab0fa",
                    \ "#ba8baf",
                    \ "#86c1b9",
                    \ "#d8d8d8",
                    \ "#585858",
                    \ "#fa7585",
                    \ "#a1b56c",
                    \ "#f7ca88",
                    \ "#5ab0fa",
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
    hi Statusline guibg=#333b4f guifg=#dedede gui=bold ctermbg=8 ctermfg=15 cterm=bold
    hi StatuslineNC guibg=#333b4f guifg=#636b7f gui=NONE ctermbg=8 ctermfg=16 cterm=NONE
    hi VertSplit guibg=#333b4f guifg=#333b4f gui=NONE ctermbg=8 ctermfg=8 cterm=NONE

    hi Pmenu guibg=#333b4f gui=NONE
    hi PmenuSel guibg=#41485b gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858

    hi TabLine guibg=#333b4f gui=NONE cterm=NONE
    hi TabLineFill guibg=#333b4f guifg=NONE gui=NONE ctermfg=NONE ctermbg=8 cterm=NONE term=NONE

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

    hi Identifier guifg=#5ab0fa gui=NONE cterm=NONE
    hi Statement guifg=#fa7585 gui=NONE cterm=NONE
    hi Constant guifg=#dc9656 gui=NONE cterm=NONE
    hi String guifg=#a1b56c gui=NONE cterm=NONE
    hi PreProc guifg=#f7ca88 gui=NONE cterm=NONE
    hi Special guifg=#86c1b9 gui=NONE cterm=NONE
    hi Tag guifg=#f7ca88 gui=NONE cterm=NONE
    hi Delimiter guifg=#a16946 gui=NONE cterm=NONE
    hi Type guifg=#ba8baf gui=NONE cterm=NONE
    hi Operator guifg=#f7ca88 gui=NONE cterm=NONE
    hi Directory guifg=#5ab0fa gui=bold cterm=bold
    hi Comment guibg=NONE guifg=#6d7079 gui=italic cterm=NONE
    hi Conceal guibg=NONE guifg=#6d7079 gui=NONE cterm=NONE

    hi Title guifg=#ff5b7b gui=bold cterm=bold
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
hi link qfFileName Comment


""" Plugins {{{1

"" Fugitive
hi link gitCommitSummary Title
hi diffAdded guifg=#20a020 gui=NONE ctermfg=green
hi diffRemoved guifg=#ff5050 gui=NONE ctermfg=red
hi! link diffLine diffChange
hi! link diffSubname diffText

"" Coc.nvim
hi! link CocErrorSign diffRemoved
