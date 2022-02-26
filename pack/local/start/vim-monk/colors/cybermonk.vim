" Name:         cybermonk
" Description:  Cyber space needs a proper shepherd to guide and protect.
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" License:      Vim License (see `:help license`)
" Last Updated: 26.02.2022 11:40:57

" Generated by Colortemplate v2.1.0

set background=dark

hi clear
let g:colors_name = 'cybermonk'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 1
let s:italics = (&t_ZH != '' && &t_ZH != '[7m') || has('gui_running')

hi! link pythonInclude Statement
hi! link javaScriptFunction Statement
hi! link javaScriptIdentifier Statement
hi! link yamlBlockMappingKey Statement
hi! link rubyDefine Statement
hi! link rubyMacro Statement
hi! link sqlKeyword Statement
hi! link vimVar Normal
hi! link vimOper Normal
hi! link vimSep Normal
hi! link vimParenSep Normal
hi! link gitCommitSummary Title
hi! link fugitiveHeader Title
hi! link fugitiveHeading Title
hi! link fugitiveStagedHeading Title
hi! link fugitiveUnstagedHeading Title
hi! link fugitiveUntrackedHeading Title
hi! link diffRemoved DiffDelete
hi! link diffAdded DiffAdd
hi! link colortemplateKey Title

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#262626', '#d75f5f', '#87af87', '#afaf87', '#5f87af', '#af8787', '#5f8787', '#949494', '#626262', '#d7875f', '#afd7af', '#d7d7af', '#87afd7', '#d7afaf', '#87afaf', '#bcbcbc']
endif
hi Normal guifg=#87af87 guibg=#262626 gui=NONE cterm=NONE
hi Statusline guifg=#262626 guibg=#afd7af gui=NONE cterm=NONE
hi StatuslineNC guifg=#262626 guibg=#5f875f gui=NONE cterm=NONE
hi VertSplit guifg=#5f875f guibg=#5f875f gui=NONE cterm=NONE
hi TabLine guifg=#262626 guibg=#5f875f gui=NONE cterm=NONE
hi TabLineSel guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton guifg=#262626 guibg=#afd7af gui=NONE cterm=NONE
hi QuickFixLine guifg=#afd7af guibg=#262626 gui=reverse cterm=reverse
hi CursorLineNr guifg=#5fff5f guibg=NONE gui=bold cterm=bold
hi LineNr guifg=#444444 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#444444 guibg=NONE gui=NONE cterm=NONE
hi Visual guifg=#262626 guibg=#87af87 gui=NONE cterm=NONE
hi VisualNOS guifg=#262626 guibg=#87af87 gui=NONE cterm=NONE
hi Pmenu guifg=NONE guibg=#1c1c1c gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#87af87 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSel guifg=#262626 guibg=#87af87 gui=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#d75f5f guibg=#262626 gui=reverse cterm=reverse
hi ModeMsg guifg=#afd7af guibg=NONE gui=bold cterm=bold
hi MoreMsg guifg=#87af87 guibg=NONE gui=bold cterm=bold
hi Question guifg=#afd7af guibg=NONE gui=NONE cterm=NONE
hi WarningMsg guifg=#d7875f guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#d7d7af guibg=#262626 gui=reverse cterm=reverse
hi MatchParen guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi Search guifg=#262626 guibg=#87af87 gui=NONE cterm=NONE
hi IncSearch guifg=#262626 guibg=#5fff5f gui=NONE cterm=NONE
hi WildMenu guifg=#262626 guibg=#87af87 gui=NONE cterm=NONE
hi debugPC guifg=#262626 guibg=#5f87af gui=NONE cterm=NONE
hi debugBreakpoint guifg=#262626 guibg=#d7875f gui=NONE cterm=NONE
hi Cursor guifg=#262626 guibg=#5fff5f gui=NONE cterm=NONE
hi lCursor guifg=#262626 guibg=#ffaf5f gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi Folded guifg=#5f875f guibg=#1c1c1c gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#1c1c1c gui=NONE cterm=NONE
hi SpellBad guifg=NONE guibg=NONE guisp=#d75f5f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=underline
hi SpellCap guifg=NONE guibg=NONE guisp=#5f87af gui=undercurl ctermfg=NONE ctermbg=NONE cterm=underline
hi SpellLocal guifg=NONE guibg=NONE guisp=#87af87 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=underline
hi SpellRare guifg=NONE guibg=NONE guisp=#d7afaf gui=undercurl ctermfg=NONE ctermbg=NONE cterm=underline
hi Comment guifg=#5f875f guibg=NONE gui=italic cterm=italic
hi Constant guifg=#afd7af guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#87af87 guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#87af87 guibg=NONE gui=bold cterm=bold
hi PreProc guifg=#87af87 guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#87af87 guibg=NONE gui=bold cterm=bold
hi Special guifg=#87af87 guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
hi Title guifg=#afd7af guibg=NONE gui=bold cterm=bold
hi Directory guifg=#afd7af guibg=NONE gui=bold cterm=bold
hi Conceal guifg=#5f875f guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi! link ErrorMsg Error
hi! link FoldColumn LineNr
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link Terminal Normal
hi! link StatuslineTerm Statusline
hi! link StatuslineTermNC StatuslineNC
hi! link TabLineFill TabLine
hi! link EndOfBuffer NonText
hi! link SpecialKey NonText
hi! link Debug Special
hi! link pythonInclude Statement
hi! link javaScriptFunction Statement
hi! link javaScriptIdentifier Statement
hi! link yamlBlockMappingKey Statement
hi! link rubyDefine Statement
hi! link rubyMacro Statement
hi! link sqlKeyword Statement
hi! link vimVar Normal
hi! link vimOper Normal
hi! link vimSep Normal
hi! link vimParenSep Normal
hi! link gitCommitSummary Title
hi! link fugitiveHeader Title
hi! link fugitiveHeading Title
hi! link fugitiveStagedHeading Title
hi! link fugitiveUnstagedHeading Title
hi! link fugitiveUntrackedHeading Title
hi! link diffRemoved DiffDelete
hi! link diffAdded DiffAdd
hi! link colortemplateKey Title
if !s:italics
  hi Comment gui=NONE cterm=NONE
endif

if s:t_Co >= 256
  hi Normal ctermfg=108 ctermbg=235 cterm=NONE
  hi Statusline ctermfg=235 ctermbg=151 cterm=NONE
  hi StatuslineNC ctermfg=235 ctermbg=65 cterm=NONE
  hi VertSplit ctermfg=65 ctermbg=65 cterm=NONE
  hi TabLine ctermfg=235 ctermbg=65 cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=235 ctermbg=151 cterm=NONE
  hi QuickFixLine ctermfg=151 ctermbg=235 cterm=reverse
  hi CursorLineNr ctermfg=83 ctermbg=NONE cterm=bold
  hi LineNr ctermfg=238 ctermbg=NONE cterm=NONE
  hi NonText ctermfg=238 ctermbg=NONE cterm=NONE
  hi Visual ctermfg=235 ctermbg=108 cterm=NONE
  hi VisualNOS ctermfg=235 ctermbg=108 cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=234 cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=108 cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=235 ctermbg=108 cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=167 ctermbg=235 cterm=reverse
  hi ModeMsg ctermfg=151 ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=108 ctermbg=NONE cterm=bold
  hi Question ctermfg=151 ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=173 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=187 ctermbg=235 cterm=reverse
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Search ctermfg=235 ctermbg=108 cterm=NONE
  hi IncSearch ctermfg=235 ctermbg=83 cterm=NONE
  hi WildMenu ctermfg=235 ctermbg=108 cterm=NONE
  hi debugPC ctermfg=235 ctermbg=67 cterm=NONE
  hi debugBreakpoint ctermfg=235 ctermbg=173 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE
  hi Folded ctermfg=65 ctermbg=234 cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=234 cterm=NONE
  hi SpellBad ctermfg=167 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=67 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=108 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=181 ctermbg=NONE cterm=underline
  hi Comment ctermfg=65 ctermbg=NONE cterm=italic
  hi Constant ctermfg=151 ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=108 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=108 ctermbg=NONE cterm=bold
  hi PreProc ctermfg=108 ctermbg=NONE cterm=NONE
  hi Type ctermfg=108 ctermbg=NONE cterm=bold
  hi Special ctermfg=108 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=151 ctermbg=NONE cterm=bold
  hi Directory ctermfg=151 ctermbg=NONE cterm=bold
  hi Conceal ctermfg=65 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi! link ErrorMsg Error
  hi! link FoldColumn LineNr
  hi! link LineNrAbove LineNr
  hi! link LineNrBelow LineNr
  hi! link Terminal Normal
  hi! link StatuslineTerm Statusline
  hi! link StatuslineTermNC StatuslineNC
  hi! link TabLineFill TabLine
  hi! link EndOfBuffer NonText
  hi! link SpecialKey NonText
  hi! link Debug Special
  hi! link pythonInclude Statement
  hi! link javaScriptFunction Statement
  hi! link javaScriptIdentifier Statement
  hi! link yamlBlockMappingKey Statement
  hi! link rubyDefine Statement
  hi! link rubyMacro Statement
  hi! link sqlKeyword Statement
  hi! link vimVar Normal
  hi! link vimOper Normal
  hi! link vimSep Normal
  hi! link vimParenSep Normal
  hi! link gitCommitSummary Title
  hi! link fugitiveHeader Title
  hi! link fugitiveHeading Title
  hi! link fugitiveStagedHeading Title
  hi! link fugitiveUnstagedHeading Title
  hi! link fugitiveUntrackedHeading Title
  hi! link diffRemoved DiffDelete
  hi! link diffAdded DiffAdd
  hi! link colortemplateKey Title
  if !s:italics
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 16
  hi Normal ctermfg=darkgreen ctermbg=black cterm=NONE
  hi Statusline ctermfg=black ctermbg=green cterm=NONE
  hi StatuslineNC ctermfg=black ctermbg=darkgreen cterm=NONE
  hi VertSplit ctermfg=darkgreen ctermbg=darkgreen cterm=NONE
  hi TabLine ctermfg=black ctermbg=darkgreen cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=black ctermbg=green cterm=NONE
  hi QuickFixLine ctermfg=green ctermbg=black cterm=reverse
  hi CursorLineNr ctermfg=green ctermbg=NONE cterm=bold
  hi LineNr ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi NonText ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Visual ctermfg=black ctermbg=darkgreen cterm=NONE
  hi VisualNOS ctermfg=black ctermbg=darkgreen cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=darkgrey cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=darkgreen cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkgreen cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=black cterm=reverse
  hi ModeMsg ctermfg=green ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=bold
  hi Question ctermfg=green ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=red ctermbg=NONE cterm=NONE
  hi Todo ctermfg=yellow ctermbg=black cterm=reverse
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Search ctermfg=black ctermbg=darkgreen cterm=NONE
  hi IncSearch ctermfg=black ctermbg=green cterm=NONE
  hi WildMenu ctermfg=black ctermbg=darkgreen cterm=NONE
  hi debugPC ctermfg=black ctermbg=blue cterm=NONE
  hi debugBreakpoint ctermfg=black ctermbg=red cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Folded ctermfg=grey ctermbg=NONE cterm=bold
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=blue ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=darkgreen ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
  hi Comment ctermfg=darkgreen ctermbg=NONE cterm=italic
  hi Constant ctermfg=green ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Statement ctermfg=darkgreen ctermbg=NONE cterm=bold
  hi PreProc ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Type ctermfg=darkgreen ctermbg=NONE cterm=bold
  hi Special ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=green ctermbg=NONE cterm=bold
  hi Directory ctermfg=green ctermbg=NONE cterm=bold
  hi Conceal ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi! link ErrorMsg Error
  hi! link FoldColumn LineNr
  hi! link LineNrAbove LineNr
  hi! link LineNrBelow LineNr
  hi! link Terminal Normal
  hi! link StatuslineTerm Statusline
  hi! link StatuslineTermNC StatuslineNC
  hi! link TabLineFill TabLine
  hi! link EndOfBuffer NonText
  hi! link SpecialKey NonText
  hi! link Debug Special
  hi! link pythonInclude Statement
  hi! link javaScriptFunction Statement
  hi! link javaScriptIdentifier Statement
  hi! link yamlBlockMappingKey Statement
  hi! link rubyDefine Statement
  hi! link rubyMacro Statement
  hi! link sqlKeyword Statement
  hi! link vimVar Normal
  hi! link vimOper Normal
  hi! link vimSep Normal
  hi! link vimParenSep Normal
  hi! link gitCommitSummary Title
  hi! link fugitiveHeader Title
  hi! link fugitiveHeading Title
  hi! link fugitiveStagedHeading Title
  hi! link fugitiveUnstagedHeading Title
  hi! link fugitiveUntrackedHeading Title
  hi! link diffRemoved DiffDelete
  hi! link diffAdded DiffAdd
  hi! link colortemplateKey Title
  if !s:italics
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 0
  hi Normal term=NONE
  hi ColorColumn term=reverse
  hi Conceal term=NONE
  hi Cursor term=reverse
  hi CursorColumn term=NONE
  hi CursorLine term=underline
  hi CursorLineNr term=bold
  hi DiffAdd term=reverse
  hi DiffChange term=NONE
  hi DiffDelete term=reverse
  hi DiffText term=reverse
  hi Directory term=NONE
  hi EndOfBuffer term=NONE
  hi ErrorMsg term=bold,reverse
  hi FoldColumn term=NONE
  hi Folded term=NONE
  hi IncSearch term=bold,reverse,underline
  hi LineNr term=NONE
  hi MatchParen term=bold,underline
  hi ModeMsg term=bold
  hi MoreMsg term=NONE
  hi NonText term=NONE
  hi Pmenu term=reverse
  hi PmenuSbar term=reverse
  hi PmenuSel term=bold
  hi PmenuThumb term=NONE
  hi Question term=standout
  hi Search term=reverse
  hi SignColumn term=reverse
  hi SpecialKey term=bold
  hi SpellBad term=underline
  hi SpellCap term=underline
  hi SpellLocal term=underline
  hi SpellRare term=underline
  hi StatusLine term=bold,reverse
  hi StatusLineNC term=bold,underline
  hi TabLine term=bold,underline
  hi TabLineFill term=NONE
  hi Terminal term=NONE
  hi TabLineSel term=bold,reverse
  hi Title term=NONE
  hi VertSplit term=NONE
  hi Visual term=reverse
  hi VisualNOS term=NONE
  hi WarningMsg term=standout
  hi WildMenu term=bold
  hi CursorIM term=NONE
  hi ToolbarLine term=reverse
  hi ToolbarButton term=bold,reverse
  hi Comment term=bold
  hi Constant term=NONE
  hi Error term=bold,reverse
  hi Identifier term=NONE
  hi Ignore term=NONE
  hi PreProc term=NONE
  hi Special term=NONE
  hi Statement term=NONE
  hi Todo term=bold,reverse
  hi Type term=NONE
  hi Underlined term=underline
  unlet s:t_Co s:italics
  finish
endif

" Background: dark
" Color: color00       #262626        235            black
" Color: color08       #626262        241            darkgrey
" Color: color01       #D75F5F        167            darkred
" Color: color09       #D7875F        173            red
" Color: color02       #87AF87        108            darkgreen
" Color: color10       #AFD7AF        151            green
" Color: color03       #AFAF87        144            darkyellow
" Color: color11       #D7D7AF        187            yellow
" Color: color04       #5F87AF        67             blue
" Color: color12       #87AFD7        110            blue
" Color: color05       #AF8787        138            darkmagenta
" Color: color13       #D7AFAF        181            magenta
" Color: color06       #5F8787        66             darkcyan
" Color: color14       #87AFAF        109            cyan
" Color: color07       #949494        246            grey
" Color: color15       #BCBCBC        250            white
" Color: colorLine     #303030        236            darkgrey
" Color: colorB        #1C1C1C        234            darkgrey
" Color: colorNonT     #444444        238            darkgrey
" Color: colorCm       #5F875F        65             darkgreen
" Color: colorC        #5FFF5F        83             green
" Color: colorlC       #FFAF5F        215            red
" Term colors: color00 color01 color02 color03 color04 color05 color06 color07
" Term colors: color08 color09 color10 color11 color12 color13 color14 color15
" vim: et ts=2 sw=2
