" Name:         miday
" Description:  Light background colorscheme
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" License:      Vim License (see `:help license`)
" Last Updated: 16.11.2020 22:11:37

" Generated by Colortemplate v2.1.0

set background=light

hi clear
let g:colors_name = 'miday'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#ffffff', '#a52a2a', '#2a872f', '#6a0dad',
        \ '#005f87', '#af00af', '#6a5acd', '#c7c7c7', '#808080', '#a52a2a',
        \ '#2a872f', '#6a0dad', '#005f87', '#af00af', '#6a5acd', '#000000']
  if has('nvim')
    let g:terminal_color_0 = '#ffffff'
    let g:terminal_color_1 = '#a52a2a'
    let g:terminal_color_2 = '#2a872f'
    let g:terminal_color_3 = '#6a0dad'
    let g:terminal_color_4 = '#005f87'
    let g:terminal_color_5 = '#af00af'
    let g:terminal_color_6 = '#6a5acd'
    let g:terminal_color_7 = '#c7c7c7'
    let g:terminal_color_8 = '#808080'
    let g:terminal_color_9 = '#a52a2a'
    let g:terminal_color_10 = '#2a872f'
    let g:terminal_color_11 = '#6a0dad'
    let g:terminal_color_12 = '#005f87'
    let g:terminal_color_13 = '#af00af'
    let g:terminal_color_14 = '#6a5acd'
    let g:terminal_color_15 = '#000000'
  endif
  if get(g:, 'miday_transp_bg', 0) && !has('gui_running')
    hi Normal guifg=#000000 guibg=NONE gui=NONE cterm=NONE
  else
    hi Normal guifg=#000000 guibg=#ffffff gui=NONE cterm=NONE
  endif
  hi EndOfBuffer guifg=#c7c7c7 guibg=NONE gui=NONE cterm=NONE
  hi Statusline guifg=#000000 guibg=#c7c7c7 gui=bold cterm=bold
  hi StatuslineNC guifg=#808080 guibg=#c7c7c7 gui=NONE cterm=NONE
  hi StatuslineTerm guifg=#005f87 guibg=#c7c7c7 gui=bold cterm=bold
  hi StatuslineTermNC guifg=#005f87 guibg=#c7c7c7 gui=NONE cterm=NONE
  hi VertSplit guifg=#c7c7c7 guibg=#c7c7c7 gui=NONE cterm=NONE
  hi Pmenu guifg=NONE guibg=#c7c7c7 gui=NONE cterm=NONE
  hi PmenuSel guifg=#000000 guibg=#d7d75f gui=bold cterm=bold
  hi PmenuSbar guifg=NONE guibg=#c7c7c7 gui=NONE cterm=NONE
  hi PmenuThumb guifg=NONE guibg=#808080 gui=NONE cterm=NONE
  hi TabLine guifg=#808080 guibg=#c7c7c7 gui=NONE cterm=NONE
  hi TabLineFill guifg=NONE guibg=#c7c7c7 gui=NONE cterm=NONE
  hi TabLineSel guifg=NONE guibg=#ffffff gui=NONE cterm=NONE
  hi ToolbarLine guifg=#ffffff guibg=#e0e0e0 gui=NONE cterm=NONE
  hi ToolbarButton guifg=NONE guibg=#c7c7c7 gui=bold cterm=bold
  hi NonText guifg=#c7c7c7 guibg=NONE gui=NONE cterm=NONE
  hi SpecialKey guifg=#c7c7c7 guibg=NONE gui=NONE cterm=NONE
  hi Folded guifg=#808080 guibg=#e0e0e0 gui=NONE cterm=NONE
  hi Visual guifg=NONE guibg=#d7d7af gui=NONE cterm=NONE
  hi VisualNOS guifg=NONE guibg=#808080 gui=NONE cterm=NONE
  hi LineNr guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi FoldColumn guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi CursorLine guifg=NONE guibg=#f0f0f0 gui=NONE cterm=NONE
  hi CursorColumn guifg=NONE guibg=#f0f0f0 gui=NONE cterm=NONE
  hi CursorLineNr guifg=NONE guibg=#f0f0f0 gui=NONE cterm=NONE
  hi QuickFixLine guifg=NONE guibg=#f0f0f0 gui=NONE cterm=NONE
  hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Underlined guifg=#005f87 guibg=NONE gui=underline cterm=underline
  hi Error guifg=#ffffff guibg=#d70000 gui=NONE cterm=NONE
  hi ErrorMsg guifg=#ffffff guibg=#d70000 gui=NONE cterm=NONE
  hi ModeMsg guifg=#000000 guibg=NONE gui=bold cterm=bold
  hi WarningMsg guifg=#6a0dad guibg=NONE gui=bold cterm=bold
  hi MoreMsg guifg=#2a872f guibg=NONE gui=bold cterm=bold
  hi Question guifg=#2a872f guibg=NONE gui=bold cterm=bold
  hi Todo guifg=#ffffff guibg=#808080 gui=NONE cterm=NONE
  hi MatchParen guifg=#ffffff guibg=#6a5acd gui=NONE cterm=NONE
  hi Search guifg=#000000 guibg=#d7d75f gui=NONE cterm=NONE
  hi IncSearch guifg=#ffffff guibg=#2a872f gui=NONE cterm=NONE
  hi WildMenu guifg=#000000 guibg=#d7d75f gui=bold cterm=bold
  hi ColorColumn guifg=NONE guibg=#e0e0e0 gui=NONE cterm=NONE
  hi Cursor guifg=#ffffff guibg=#000000 gui=NONE cterm=NONE
  hi lCursor guifg=#000000 guibg=#d7005f gui=NONE cterm=NONE
  hi DiffAdd guifg=NONE guibg=#c9f9c9 gui=NONE cterm=NONE
  hi DiffChange guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffText guifg=NONE guibg=#f9f9c9 gui=NONE cterm=NONE
  hi DiffDelete guifg=#f9c9c9 guibg=NONE gui=NONE cterm=NONE
  hi SpellBad guifg=#a52a2a guibg=NONE guisp=#a52a2a gui=undercurl cterm=underline
  hi SpellCap guifg=#2a872f guibg=NONE guisp=#2a872f gui=undercurl cterm=underline
  hi SpellLocal guifg=#6a5acd guibg=NONE guisp=#6a5acd gui=undercurl cterm=underline
  hi SpellRare guifg=#af00af guibg=NONE guisp=#af00af gui=undercurl cterm=underline
  hi Identifier guifg=#005f87 guibg=NONE gui=NONE cterm=NONE
  hi Statement guifg=#a52a2a guibg=NONE gui=NONE cterm=NONE
  hi Constant guifg=#d7005f guibg=NONE gui=NONE cterm=NONE
  hi String guifg=#2a872f guibg=NONE gui=NONE cterm=NONE
  hi PreProc guifg=#6a0dad guibg=NONE gui=NONE cterm=NONE
  hi Special guifg=#6a5acd guibg=NONE gui=NONE cterm=NONE
  hi Tag guifg=#6a0dad guibg=NONE gui=NONE cterm=NONE
  hi Type guifg=#af00af guibg=NONE gui=NONE cterm=NONE
  hi Directory guifg=#005f87 guibg=NONE gui=bold cterm=bold
  hi Comment guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi Conceal guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Title guifg=#a52a2a guibg=NONE gui=bold cterm=bold
  hi qfError guifg=#d70000 guibg=NONE gui=NONE cterm=NONE
  hi! link colortemplateKey Statement
  hi! link colortemplateAttr String
  hi! link vimNotation Type
  hi! link vimFuncSID PreProc
  hi! link vimHiTerm Identifier
  hi! link helpNotVi Comment
  hi! link helpExample PreProc
  hi! link gitCommitSummary Title
  hi! link cocErrorSign Type
  hi! link markdownUrl Underlined
  hi SelectDirectoryPrefix guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi asciidoctorOption guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi asciidoctorLiteralBlock guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  hi asciidoctorIndented guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 256
  if get(g:, 'miday_transp_bg', 0)
    hi Normal ctermfg=16 ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=16 ctermbg=231 cterm=NONE
  endif
  hi EndOfBuffer ctermfg=251 ctermbg=NONE cterm=NONE
  hi Statusline ctermfg=16 ctermbg=251 cterm=bold
  hi StatuslineNC ctermfg=244 ctermbg=251 cterm=NONE
  hi StatuslineTerm ctermfg=30 ctermbg=251 cterm=bold
  hi StatuslineTermNC ctermfg=30 ctermbg=251 cterm=NONE
  hi VertSplit ctermfg=251 ctermbg=251 cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=251 cterm=NONE
  hi PmenuSel ctermfg=16 ctermbg=185 cterm=bold
  hi PmenuSbar ctermfg=NONE ctermbg=251 cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=244 cterm=NONE
  hi TabLine ctermfg=244 ctermbg=251 cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=251 cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=231 cterm=NONE
  hi ToolbarLine ctermfg=231 ctermbg=254 cterm=NONE
  hi ToolbarButton ctermfg=NONE ctermbg=251 cterm=bold
  hi NonText ctermfg=251 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=251 ctermbg=NONE cterm=NONE
  hi Folded ctermfg=244 ctermbg=254 cterm=NONE
  hi Visual ctermfg=NONE ctermbg=187 cterm=NONE
  hi VisualNOS ctermfg=NONE ctermbg=244 cterm=NONE
  hi LineNr ctermfg=244 ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=244 ctermbg=NONE cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=254 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=254 cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=254 cterm=NONE
  hi QuickFixLine ctermfg=NONE ctermbg=254 cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=30 ctermbg=NONE cterm=underline
  hi Error ctermfg=231 ctermbg=160 cterm=NONE
  hi ErrorMsg ctermfg=231 ctermbg=160 cterm=NONE
  hi ModeMsg ctermfg=16 ctermbg=NONE cterm=bold
  hi WarningMsg ctermfg=55 ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=28 ctermbg=NONE cterm=bold
  hi Question ctermfg=28 ctermbg=NONE cterm=bold
  hi Todo ctermfg=231 ctermbg=244 cterm=NONE
  hi MatchParen ctermfg=231 ctermbg=62 cterm=NONE
  hi Search ctermfg=16 ctermbg=185 cterm=NONE
  hi IncSearch ctermfg=231 ctermbg=28 cterm=NONE
  hi WildMenu ctermfg=16 ctermbg=185 cterm=bold
  hi ColorColumn ctermfg=NONE ctermbg=254 cterm=NONE
  hi Cursor ctermfg=231 ctermbg=16 cterm=NONE
  hi lCursor ctermfg=16 ctermbg=161 cterm=NONE
  hi DiffAdd ctermfg=NONE ctermbg=194 cterm=NONE
  hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffText ctermfg=NONE ctermbg=222 cterm=NONE
  hi DiffDelete ctermfg=224 ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=124 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=28 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=62 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=127 ctermbg=NONE cterm=underline
  hi Identifier ctermfg=30 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=124 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=161 ctermbg=NONE cterm=NONE
  hi String ctermfg=28 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=55 ctermbg=NONE cterm=NONE
  hi Special ctermfg=62 ctermbg=NONE cterm=NONE
  hi Tag ctermfg=55 ctermbg=NONE cterm=NONE
  hi Type ctermfg=127 ctermbg=NONE cterm=NONE
  hi Directory ctermfg=30 ctermbg=NONE cterm=bold
  hi Comment ctermfg=244 ctermbg=NONE cterm=NONE
  hi Conceal ctermfg=244 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Title ctermfg=124 ctermbg=NONE cterm=bold
  hi qfError ctermfg=160 ctermbg=NONE cterm=NONE
  hi! link colortemplateKey Statement
  hi! link colortemplateAttr String
  hi! link vimNotation Type
  hi! link vimFuncSID PreProc
  hi! link vimHiTerm Identifier
  hi! link helpNotVi Comment
  hi! link helpExample PreProc
  hi! link gitCommitSummary Title
  hi! link cocErrorSign Type
  hi! link markdownUrl Underlined
  hi SelectDirectoryPrefix ctermfg=244 ctermbg=NONE cterm=NONE
  hi asciidoctorOption ctermfg=244 ctermbg=NONE cterm=NONE
  hi asciidoctorLiteralBlock ctermfg=244 ctermbg=NONE cterm=NONE
  hi asciidoctorIndented ctermfg=244 ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

" Background: light
" Color: comment    #808080 244
" Color: constant   #d7005f 161
" Color: string     #2a872f 28
" Color: identifier #005f87 30
" Color: statement  #a52a2a 124
" Color: preproc    #6a0dad 55
" Color: type       #af00af 127
" Color: special    #6a5acd 62
" Color: fg0        #000000 16
" Color: bg0        #ffffff 231
" Color: bg1        #c7c7c7 251
" Color: folded     #e0e0e0 254
" Color: cursorline #f0f0f0 254
" Color: visual     #d7d7af 187
" Color: error      #d70000 160
" Color: wildmenu   #d7d75f 185
" Color: diffadd    #c9f9c9 194
" Color: difftext   #f9f9c9 222
" Color: diffdelete #f9c9c9 224
" Term colors: bg0     statement string preproc identifier type special bg1
" Term colors: comment statement string preproc identifier type special fg0
" vim: et ts=2 sw=2
