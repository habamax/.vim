" Name:         bronzage
" Description:  A tribute to zenburn.
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" License:      Vim License (see `:help license`)
" Last Updated: 09.09.2021 16:32:14

" Generated by Colortemplate v2.1.0

set background=dark

hi clear
let g:colors_name = 'bronzage'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#303030', '#af5f5f', '#87af5f', '#afaf5f', '#5f8787', '#af875f', '#87afaf', '#808080', '#4e4e4e', '#d7875f', '#87af87', '#d7d787', '#87afd7', '#d7af5f', '#87d7d7', '#e4e4e4']
  if has('nvim')
    let g:terminal_color_0 = '#303030'
    let g:terminal_color_1 = '#af5f5f'
    let g:terminal_color_2 = '#87af5f'
    let g:terminal_color_3 = '#afaf5f'
    let g:terminal_color_4 = '#5f8787'
    let g:terminal_color_5 = '#af875f'
    let g:terminal_color_6 = '#87afaf'
    let g:terminal_color_7 = '#808080'
    let g:terminal_color_8 = '#4e4e4e'
    let g:terminal_color_9 = '#d7875f'
    let g:terminal_color_10 = '#87af87'
    let g:terminal_color_11 = '#d7d787'
    let g:terminal_color_12 = '#87afd7'
    let g:terminal_color_13 = '#d7af5f'
    let g:terminal_color_14 = '#87d7d7'
    let g:terminal_color_15 = '#e4e4e4'
  endif
  hi Normal guifg=#d0d0d0 guibg=#3a3a3a gui=NONE cterm=NONE
  hi EndOfBuffer guifg=#4e4e4e guibg=NONE gui=NONE cterm=NONE
  hi Statusline guifg=#3a3a3a guibg=#808080 gui=NONE cterm=NONE
  hi StatuslineNC guifg=#808080 guibg=#4e4e4e gui=NONE cterm=NONE
  hi StatuslineTerm guifg=#3a3a3a guibg=#87afaf gui=NONE cterm=NONE
  hi StatuslineTermNC guifg=#d0d0d0 guibg=#4e4e4e gui=NONE cterm=NONE
  hi VertSplit guifg=#4e4e4e guibg=#4e4e4e gui=NONE cterm=NONE
  hi Pmenu guifg=NONE guibg=#4e4e4e gui=NONE cterm=NONE
  hi PmenuSel guifg=#3a3a3a guibg=#d7d787 gui=NONE cterm=NONE
  hi PmenuSbar guifg=NONE guibg=#808080 gui=NONE cterm=NONE
  hi PmenuThumb guifg=NONE guibg=#e4e4e4 gui=NONE cterm=NONE
  hi TabLine guifg=#808080 guibg=#4e4e4e gui=NONE cterm=NONE
  hi TabLineFill guifg=#87afaf guibg=#4e4e4e gui=NONE cterm=NONE
  hi TabLineSel guifg=#3a3a3a guibg=#808080 gui=NONE cterm=NONE
  hi ToolbarLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
  hi ToolbarButton guifg=#3a3a3a guibg=#87af87 gui=NONE cterm=NONE
  hi NonText guifg=#4e4e4e guibg=NONE gui=NONE cterm=NONE
  hi SpecialKey guifg=#4e4e4e guibg=NONE gui=NONE cterm=NONE
  hi Folded guifg=#808080 guibg=#303030 gui=NONE cterm=NONE
  hi Visual guifg=#3a3a3a guibg=#87afd7 gui=NONE cterm=NONE
  hi VisualNOS guifg=#3a3a3a guibg=#87afd7 gui=NONE cterm=NONE
  hi LineNr guifg=#808080 guibg=#3a3a3a gui=NONE cterm=NONE
  hi FoldColumn guifg=#808080 guibg=#3a3a3a gui=NONE cterm=NONE
  hi CursorLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
  hi CursorColumn guifg=NONE guibg=#303030 gui=NONE cterm=NONE
  hi CursorLineNr guifg=NONE guibg=#303030 gui=NONE cterm=NONE
  hi QuickFixLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
  hi SignColumn guifg=NONE guibg=#3a3a3a gui=NONE cterm=NONE
  hi Underlined guifg=#d7d787 guibg=NONE gui=underline cterm=underline
  hi Error guifg=#af5f5f guibg=NONE gui=NONE cterm=NONE
  hi ErrorMsg guifg=#af5f5f guibg=NONE gui=NONE cterm=NONE
  hi ModeMsg guifg=#3a3a3a guibg=#afaf5f gui=NONE cterm=NONE
  hi WarningMsg guifg=#afaf5f guibg=NONE gui=NONE cterm=NONE
  hi MoreMsg guifg=#87af87 guibg=NONE gui=NONE cterm=NONE
  hi Question guifg=#d7875f guibg=NONE gui=NONE cterm=NONE
  hi Todo guifg=#3a3a3a guibg=#808080 gui=NONE cterm=NONE
  hi MatchParen guifg=#303030 guibg=#afaf5f gui=NONE cterm=NONE
  hi Search guifg=#303030 guibg=#87af5f gui=NONE cterm=NONE
  hi IncSearch guifg=#303030 guibg=#d7d787 gui=NONE cterm=NONE
  hi WildMenu guifg=#3a3a3a guibg=#d7d787 gui=NONE cterm=NONE
  hi ColorColumn guifg=NONE guibg=#303030 gui=NONE cterm=NONE
  hi Cursor guifg=#3a3a3a guibg=#d0d0d0 gui=NONE cterm=NONE
  hi lCursor guifg=#3a3a3a guibg=#af5f5f gui=NONE cterm=NONE
  hi DiffAdd guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffChange guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffText guifg=#3a3a3a guibg=#afaf5f gui=NONE cterm=NONE
  hi DiffDelete guifg=#af5f5f guibg=NONE gui=NONE cterm=NONE
  hi SpellBad guifg=#af5f5f guibg=NONE guisp=#af5f5f gui=undercurl cterm=underline
  hi SpellCap guifg=#d7875f guibg=NONE guisp=#d7875f gui=undercurl cterm=underline
  hi SpellLocal guifg=#afaf5f guibg=NONE guisp=#afaf5f gui=undercurl cterm=underline
  hi SpellRare guifg=#d7d787 guibg=NONE guisp=#d7d787 gui=undercurl cterm=underline
  hi Comment guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi Identifier guifg=#afaf5f guibg=NONE gui=NONE cterm=NONE
  hi Function guifg=#d7d787 guibg=NONE gui=NONE cterm=NONE
  hi Statement guifg=#d7af5f guibg=NONE gui=NONE cterm=NONE
  hi Constant guifg=#d7875f guibg=NONE gui=NONE cterm=NONE
  hi String guifg=#87af87 guibg=NONE gui=NONE cterm=NONE
  hi Character guifg=#87af5f guibg=NONE gui=NONE cterm=NONE
  hi PreProc guifg=#87afaf guibg=NONE gui=NONE cterm=NONE
  hi Type guifg=#af875f guibg=NONE gui=NONE cterm=NONE
  hi Special guifg=#5f8787 guibg=NONE gui=NONE cterm=NONE
  hi SpecialChar guifg=#af875f guibg=NONE gui=NONE cterm=NONE
  hi Tag guifg=#87d7d7 guibg=NONE gui=NONE cterm=NONE
  hi SpecialComment guifg=#87d7d7 guibg=NONE gui=NONE cterm=NONE
  hi Directory guifg=#af875f guibg=NONE gui=bold cterm=bold
  hi Conceal guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Title guifg=#e4e4e4 guibg=NONE gui=bold cterm=bold
  unlet s:t_Co
  finish
endif

if s:t_Co >= 256
  hi Normal ctermfg=252 ctermbg=237 cterm=NONE
  if !has('patch-8.0.0616') && !has('nvim') " Fix for Vim bug
    set background=dark
  endif
  hi EndOfBuffer ctermfg=239 ctermbg=NONE cterm=NONE
  hi Statusline ctermfg=237 ctermbg=244 cterm=NONE
  hi StatuslineNC ctermfg=244 ctermbg=239 cterm=NONE
  hi StatuslineTerm ctermfg=237 ctermbg=109 cterm=NONE
  hi StatuslineTermNC ctermfg=252 ctermbg=239 cterm=NONE
  hi VertSplit ctermfg=239 ctermbg=239 cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=239 cterm=NONE
  hi PmenuSel ctermfg=237 ctermbg=186 cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=244 cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=254 cterm=NONE
  hi TabLine ctermfg=244 ctermbg=239 cterm=NONE
  hi TabLineFill ctermfg=109 ctermbg=239 cterm=NONE
  hi TabLineSel ctermfg=237 ctermbg=244 cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=236 cterm=NONE
  hi ToolbarButton ctermfg=237 ctermbg=108 cterm=NONE
  hi NonText ctermfg=239 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=239 ctermbg=NONE cterm=NONE
  hi Folded ctermfg=244 ctermbg=236 cterm=NONE
  hi Visual ctermfg=237 ctermbg=110 cterm=NONE
  hi VisualNOS ctermfg=237 ctermbg=110 cterm=NONE
  hi LineNr ctermfg=244 ctermbg=237 cterm=NONE
  hi FoldColumn ctermfg=244 ctermbg=237 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=236 cterm=NONE
  hi QuickFixLine ctermfg=NONE ctermbg=236 cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=237 cterm=NONE
  hi Underlined ctermfg=186 ctermbg=NONE cterm=underline
  hi Error ctermfg=131 ctermbg=NONE cterm=NONE
  hi ErrorMsg ctermfg=131 ctermbg=NONE cterm=NONE
  hi ModeMsg ctermfg=237 ctermbg=143 cterm=NONE
  hi WarningMsg ctermfg=143 ctermbg=NONE cterm=NONE
  hi MoreMsg ctermfg=108 ctermbg=NONE cterm=NONE
  hi Question ctermfg=173 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=237 ctermbg=244 cterm=NONE
  hi MatchParen ctermfg=236 ctermbg=143 cterm=NONE
  hi Search ctermfg=236 ctermbg=107 cterm=NONE
  hi IncSearch ctermfg=236 ctermbg=186 cterm=NONE
  hi WildMenu ctermfg=237 ctermbg=186 cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=236 cterm=NONE
  hi Cursor ctermfg=237 ctermbg=252 cterm=NONE
  hi lCursor ctermfg=237 ctermbg=131 cterm=NONE
  hi DiffAdd ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffText ctermfg=237 ctermbg=143 cterm=NONE
  hi DiffDelete ctermfg=131 ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=131 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=173 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=143 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=186 ctermbg=NONE cterm=underline
  hi Comment ctermfg=244 ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=143 ctermbg=NONE cterm=NONE
  hi Function ctermfg=186 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=179 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=173 ctermbg=NONE cterm=NONE
  hi String ctermfg=108 ctermbg=NONE cterm=NONE
  hi Character ctermfg=107 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=109 ctermbg=NONE cterm=NONE
  hi Type ctermfg=137 ctermbg=NONE cterm=NONE
  hi Special ctermfg=66 ctermbg=NONE cterm=NONE
  hi SpecialChar ctermfg=137 ctermbg=NONE cterm=NONE
  hi Tag ctermfg=116 ctermbg=NONE cterm=NONE
  hi SpecialComment ctermfg=116 ctermbg=NONE cterm=NONE
  hi Directory ctermfg=137 ctermbg=NONE cterm=bold
  hi Conceal ctermfg=244 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Title ctermfg=254 ctermbg=NONE cterm=bold
  unlet s:t_Co
  finish
endif

" Background: dark
" Color: foreground #D0D0D0 252
" Color: background #3A3A3A 237
" Color: color00    #303030 236
" Color: color08    #4E4E4E 239
" Color: color01    #AF5F5F 131
" Color: color09    #D7875F 173
" Color: color02    #87AF5f 107
" Color: color10    #87AF87 108
" Color: color03    #AFAF5F 143
" Color: color11    #D7D787 186
" Color: color04    #5f8787 66
" Color: color12    #87AFD7 110
" Color: color05    #AF875F 137
" Color: color13    #D7AF5F 179
" Color: color06    #87AFAF 109
" Color: color14    #87D7D7 116
" Color: color07    #808080 244
" Color: color15    #E4E4E4 254
" Term colors: color00 color01 color02 color03 color04 color05 color06 color07
" Term colors: color08 color09 color10 color11 color12 color13 color14 color15
" vim: et ts=2 sw=2
