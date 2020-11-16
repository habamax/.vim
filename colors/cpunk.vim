" Name:         cpunk
" Description:  Black background heavily spiced with colors.
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" License:      Vim License (see `:help license`)
" Last Updated: 16.11.2020 22:41:42

" Generated by Colortemplate v2.1.0

set background=dark

hi clear
let g:colors_name = 'cpunk'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#ff4d6f', '#60ff94', '#ffb450',
        \ '#46b8ff', '#ff75e1', '#68ffe1', '#303234', '#808080', '#ff4d6f',
        \ '#60ff94', '#ffb450', '#46b8ff', '#ff75e1', '#68ffe1', '#dadada']
  if has('nvim')
    let g:terminal_color_0 = '#000000'
    let g:terminal_color_1 = '#ff4d6f'
    let g:terminal_color_2 = '#60ff94'
    let g:terminal_color_3 = '#ffb450'
    let g:terminal_color_4 = '#46b8ff'
    let g:terminal_color_5 = '#ff75e1'
    let g:terminal_color_6 = '#68ffe1'
    let g:terminal_color_7 = '#303234'
    let g:terminal_color_8 = '#808080'
    let g:terminal_color_9 = '#ff4d6f'
    let g:terminal_color_10 = '#60ff94'
    let g:terminal_color_11 = '#ffb450'
    let g:terminal_color_12 = '#46b8ff'
    let g:terminal_color_13 = '#ff75e1'
    let g:terminal_color_14 = '#68ffe1'
    let g:terminal_color_15 = '#dadada'
  endif
  if get(g:, 'cpunk_transp_bg', 0) && !has('gui_running')
    hi Normal guifg=#dadada guibg=NONE gui=NONE cterm=NONE
  else
    hi Normal guifg=#dadada guibg=#000000 gui=NONE cterm=NONE
  endif
  hi EndOfBuffer guifg=#303234 guibg=NONE gui=NONE cterm=NONE
  hi Statusline guifg=#50ffff guibg=#303234 gui=bold cterm=bold
  hi StatuslineNC guifg=#808080 guibg=#303234 gui=NONE cterm=NONE
  hi StatuslineTerm guifg=#50ffff guibg=#303234 gui=bold cterm=bold
  hi StatuslineTermNC guifg=#808080 guibg=#303234 gui=NONE cterm=NONE
  hi VertSplit guifg=#303234 guibg=#303234 gui=NONE cterm=NONE
  hi Pmenu guifg=NONE guibg=#303234 gui=NONE cterm=NONE
  hi PmenuSel guifg=#000000 guibg=#ffb450 gui=NONE cterm=NONE
  hi PmenuSbar guifg=NONE guibg=#303234 gui=NONE cterm=NONE
  hi PmenuThumb guifg=NONE guibg=#808080 gui=NONE cterm=NONE
  hi TabLine guifg=#808080 guibg=#303234 gui=NONE cterm=NONE
  hi TabLineFill guifg=NONE guibg=#303234 gui=NONE cterm=NONE
  hi TabLineSel guifg=NONE guibg=#000000 gui=NONE cterm=NONE
  hi ToolbarLine guifg=#000000 guibg=#181a1f gui=NONE cterm=NONE
  hi ToolbarButton guifg=#50ffff guibg=#414956 gui=bold cterm=bold
  hi NonText guifg=#303234 guibg=NONE gui=NONE cterm=NONE
  hi SpecialKey guifg=#303234 guibg=NONE gui=NONE cterm=NONE
  hi Folded guifg=#808080 guibg=#181a1f gui=NONE cterm=NONE
  hi Visual guifg=NONE guibg=#414956 gui=NONE cterm=NONE
  hi VisualNOS guifg=NONE guibg=#808080 gui=NONE cterm=NONE
  hi LineNr guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi FoldColumn guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi CursorLine guifg=NONE guibg=#181a1f gui=NONE cterm=NONE
  hi CursorColumn guifg=NONE guibg=#181a1f gui=NONE cterm=NONE
  hi CursorLineNr guifg=NONE guibg=#181a1f gui=NONE cterm=NONE
  hi QuickFixLine guifg=NONE guibg=#181a1f gui=NONE cterm=NONE
  hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Underlined guifg=#46b8ff guibg=NONE gui=underline cterm=underline
  hi Error guifg=#dadada guibg=#ff3070 gui=NONE cterm=NONE
  hi ErrorMsg guifg=#dadada guibg=#ff3070 gui=NONE cterm=NONE
  hi WarningMsg guifg=#ffb450 guibg=#000000 gui=NONE cterm=NONE
  hi MoreMsg guifg=#dadada guibg=#000000 gui=NONE cterm=NONE
  hi ModeMsg guifg=#46b8ff guibg=#000000 gui=bold cterm=bold
  hi Question guifg=#60ff94 guibg=NONE gui=NONE cterm=NONE
  hi Todo guifg=#000000 guibg=#808080 gui=NONE cterm=NONE
  hi MatchParen guifg=#000000 guibg=#68ffe1 gui=NONE cterm=NONE
  hi Search guifg=#000000 guibg=#ffb450 gui=NONE cterm=NONE
  hi IncSearch guifg=#000000 guibg=#60ff94 gui=NONE cterm=NONE
  hi WildMenu guifg=#000000 guibg=#50ffff gui=bold cterm=bold
  hi ColorColumn guifg=NONE guibg=#181a1f gui=NONE cterm=NONE
  hi Cursor guifg=#000000 guibg=#dadada gui=NONE cterm=NONE
  hi lCursor guifg=#dadada guibg=#ffff00 gui=NONE cterm=NONE
  hi DiffAdd guifg=NONE guibg=#294929 gui=NONE cterm=NONE
  hi DiffChange guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffText guifg=NONE guibg=#005080 gui=NONE cterm=NONE
  hi DiffDelete guifg=#492929 guibg=#000000 gui=NONE cterm=NONE
  hi SpellBad guifg=#ff4d6f guibg=NONE guisp=#ff4d6f gui=undercurl cterm=underline
  hi SpellCap guifg=#60ff94 guibg=NONE guisp=#60ff94 gui=undercurl cterm=underline
  hi SpellLocal guifg=#68ffe1 guibg=NONE guisp=#68ffe1 gui=undercurl cterm=underline
  hi SpellRare guifg=#ff75e1 guibg=NONE guisp=#ff75e1 gui=undercurl cterm=underline
  hi Identifier guifg=#46b8ff guibg=NONE gui=NONE cterm=NONE
  hi Statement guifg=#ff75e1 guibg=NONE gui=NONE cterm=NONE
  hi Constant guifg=#ffff00 guibg=NONE gui=NONE cterm=NONE
  hi String guifg=#60ff94 guibg=NONE gui=NONE cterm=NONE
  hi PreProc guifg=#ffb450 guibg=NONE gui=NONE cterm=NONE
  hi Special guifg=#68ffe1 guibg=NONE gui=NONE cterm=NONE
  hi Tag guifg=#ffb450 guibg=NONE gui=NONE cterm=NONE
  hi Delimiter guifg=#ff7d32 guibg=NONE gui=NONE cterm=NONE
  hi Type guifg=#ff4d6f guibg=NONE gui=NONE cterm=NONE
  hi Directory guifg=#46b8ff guibg=NONE gui=bold cterm=bold
  hi Comment guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi Conceal guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Title guifg=#ff75e1 guibg=NONE gui=bold cterm=bold
  hi! link colortemplateKey Statement
  hi! link colortemplateAttr String
  hi! link vimNotation Type
  hi! link vimFuncSID PreProc
  hi! link vimHiTerm Identifier
  hi! link helpNotVi Comment
  hi! link helpExample PreProc
  hi! link gdscriptFunctionName Function
  hi! link gitCommitSummary Title
  hi! link cocErrorSign Type
  hi asciidoctorOption guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi asciidoctorLiteralBlock guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi asciidoctorIndented guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi asciidoctorCaption guifg=#ff4d6f guibg=NONE gui=NONE cterm=NONE
  hi SelectDirectoryPrefix guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 256
  if get(g:, 'cpunk_transp_bg', 0)
    hi Normal ctermfg=253 ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=253 ctermbg=16 cterm=NONE
    if !has('patch-8.0.0616') && !has('nvim') " Fix for Vim bug
      set background=dark
    endif
  endif
  hi EndOfBuffer ctermfg=236 ctermbg=NONE cterm=NONE
  hi Statusline ctermfg=87 ctermbg=236 cterm=bold
  hi StatuslineNC ctermfg=244 ctermbg=236 cterm=NONE
  hi StatuslineTerm ctermfg=87 ctermbg=236 cterm=bold
  hi StatuslineTermNC ctermfg=244 ctermbg=236 cterm=NONE
  hi VertSplit ctermfg=236 ctermbg=236 cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE
  hi PmenuSel ctermfg=16 ctermbg=215 cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=236 cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=244 cterm=NONE
  hi TabLine ctermfg=244 ctermbg=236 cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=236 cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=16 cterm=NONE
  hi ToolbarLine ctermfg=16 ctermbg=234 cterm=NONE
  hi ToolbarButton ctermfg=87 ctermbg=238 cterm=bold
  hi NonText ctermfg=236 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=236 ctermbg=NONE cterm=NONE
  hi Folded ctermfg=244 ctermbg=234 cterm=NONE
  hi Visual ctermfg=NONE ctermbg=238 cterm=NONE
  hi VisualNOS ctermfg=NONE ctermbg=244 cterm=NONE
  hi LineNr ctermfg=244 ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=244 ctermbg=NONE cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=234 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=234 cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=234 cterm=NONE
  hi QuickFixLine ctermfg=NONE ctermbg=234 cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=39 ctermbg=NONE cterm=underline
  hi Error ctermfg=253 ctermbg=197 cterm=NONE
  hi ErrorMsg ctermfg=253 ctermbg=197 cterm=NONE
  hi WarningMsg ctermfg=215 ctermbg=16 cterm=NONE
  hi MoreMsg ctermfg=253 ctermbg=16 cterm=NONE
  hi ModeMsg ctermfg=39 ctermbg=16 cterm=bold
  hi Question ctermfg=84 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=16 ctermbg=244 cterm=NONE
  hi MatchParen ctermfg=16 ctermbg=86 cterm=NONE
  hi Search ctermfg=16 ctermbg=215 cterm=NONE
  hi IncSearch ctermfg=16 ctermbg=84 cterm=NONE
  hi WildMenu ctermfg=16 ctermbg=87 cterm=bold
  hi ColorColumn ctermfg=NONE ctermbg=234 cterm=NONE
  hi Cursor ctermfg=16 ctermbg=253 cterm=NONE
  hi lCursor ctermfg=253 ctermbg=226 cterm=NONE
  hi DiffAdd ctermfg=NONE ctermbg=22 cterm=NONE
  hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffText ctermfg=NONE ctermbg=24 cterm=NONE
  hi DiffDelete ctermfg=52 ctermbg=16 cterm=NONE
  hi SpellBad ctermfg=204 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=84 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=86 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=206 ctermbg=NONE cterm=underline
  hi Identifier ctermfg=39 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=206 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=226 ctermbg=NONE cterm=NONE
  hi String ctermfg=84 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=215 ctermbg=NONE cterm=NONE
  hi Special ctermfg=86 ctermbg=NONE cterm=NONE
  hi Tag ctermfg=215 ctermbg=NONE cterm=NONE
  hi Delimiter ctermfg=202 ctermbg=NONE cterm=NONE
  hi Type ctermfg=204 ctermbg=NONE cterm=NONE
  hi Directory ctermfg=39 ctermbg=NONE cterm=bold
  hi Comment ctermfg=244 ctermbg=NONE cterm=NONE
  hi Conceal ctermfg=244 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Title ctermfg=206 ctermbg=NONE cterm=bold
  hi! link colortemplateKey Statement
  hi! link colortemplateAttr String
  hi! link vimNotation Type
  hi! link vimFuncSID PreProc
  hi! link vimHiTerm Identifier
  hi! link helpNotVi Comment
  hi! link helpExample PreProc
  hi! link gdscriptFunctionName Function
  hi! link gitCommitSummary Title
  hi! link cocErrorSign Type
  hi asciidoctorOption ctermfg=244 ctermbg=NONE cterm=NONE
  hi asciidoctorLiteralBlock ctermfg=244 ctermbg=NONE cterm=NONE
  hi asciidoctorIndented ctermfg=244 ctermbg=NONE cterm=NONE
  hi asciidoctorCaption ctermfg=204 ctermbg=NONE cterm=NONE
  hi SelectDirectoryPrefix ctermfg=244 ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

" Background: dark
" Color: comment    #808080 ~
" Color: constant   #ffff00 ~
" Color: string     #60ff94 ~
" Color: identifier #46b8ff ~
" Color: statement  #ff75e1 ~
" Color: preproc    #ffb450 ~
" Color: type       #ff4d6f ~
" Color: special    #68ffe1 ~
" Color: delimiter  #ff7d32 ~
" Color: fg0        #dadada ~
" Color: bg0        #000000 ~
" Color: bg1        #303234 ~
" Color: folded     #181a1f ~
" Color: visual     #414956 ~
" Color: error      #ff3070 ~
" Color: diffadd    #294929 ~
" Color: difftext   #005080 ~
" Color: diffdelete #492929 ~
" Color: statusline #50ffff ~
" Term colors: bg0     type string preproc identifier statement special bg1
" Term colors: comment type string preproc identifier statement special fg0
" vim: et ts=2 sw=2
