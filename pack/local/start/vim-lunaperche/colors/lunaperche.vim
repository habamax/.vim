" Name:         Portofino? Dimmi la luna perchè?
" Description:  Black colorscheme with not so many colors.
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" License:      Vim License (see `:help license`)
" Last Updated: 2022-07-09 20:30:17

" Generated by Colortemplate v2.2.0

set background=dark

hi clear
let g:colors_name = 'lunaperche'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 1

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#af5f5f', '#5fd75f', '#af875f', '#5f87af', '#d787af', '#5fafaf', '#c6c6c6', '#878787', '#ff5f5f', '#87ff5f', '#ffdf87', '#87afd7', '#ffafd7', '#87dfdf', '#ffffff']
endif
hi! link helpVim Title
hi! link helpHeader Title
hi! link helpHyperTextJump Underlined
hi! link fugitiveSymbolicRef Type
hi! link fugitiveHeading Statement
hi! link fugitiveStagedHeading Statement
hi! link fugitiveUnstagedHeading Statement
hi! link fugitiveStagedModifier Special
hi! link fugitiveUnstagedModifier Special
hi! link fugitiveHash Constant
hi! link diffFile Preproc
hi! link markdownHeadingDelimiter PreProc
hi! link rstSectionDelimiter Statement
hi! link rstDirective Special
hi! link rstHyperlinkReference Special
hi! link rstFieldName Special
hi! link rstDelimiter Special
hi! link colortemplateKey Statement
hi! link xmlTagName Statement
hi! link javaScriptFunction Statement
hi! link javaScriptIdentifier Statement
hi! link sqlKeyword Statement
hi! link yamlBlockMappingKey Statement
hi! link rubyMacro Statement
hi! link rubyDefine Statement
hi! link vimGroup Normal
hi! link vimVar Normal
hi! link vimOper Normal
hi! link vimSep Normal
hi! link vimParenSep Normal
hi! link vimCommentString Comment
hi! link pythonInclude Statement
hi! link elixirOperator Statement
hi! link elixirKeyword Statement
hi! link elixirBlockDefinition Statement
hi! link elixirDefine Statement
hi! link elixirPrivateDefine Statement
hi! link elixirGuard Statement
hi! link elixirPrivateGuard Statement
hi! link elixirModuleDefine Statement
hi! link elixirProtocolDefine Statement
hi! link elixirImplDefine Statement
hi! link elixirRecordDefine Statement
hi! link elixirPrivateRecordDefine Statement
hi! link elixirMacroDefine Statement
hi! link elixirPrivateMacroDefine Statement
hi! link elixirDelegateDefine Statement
hi! link elixirOverridableDefine Statement
hi! link elixirExceptionDefine Statement
hi! link elixirCallbackDefine Statement
hi! link elixirStructDefine Statement
hi! link elixirExUnitMacro Statement
hi! link elixirInclude Statement
hi! link elixirVariable Special
hi! link elixirAtom Constant
hi! link elixirDocTest String
hi! link Terminal Normal
hi! link StatuslineTerm Statusline
hi! link StatuslineTermNC StatuslineNC
hi Normal guifg=#c6c6c6 guibg=#000000 gui=NONE cterm=NONE
hi Statusline guifg=#000000 guibg=#c6c6c6 gui=bold cterm=bold
hi StatuslineNC guifg=#000000 guibg=#878787 gui=NONE cterm=NONE
hi VertSplit guifg=#878787 guibg=#878787 gui=NONE cterm=NONE
hi TabLine guifg=#c6c6c6 guibg=#585858 gui=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=#878787 gui=NONE cterm=NONE
hi TabLineSel guifg=#c6c6c6 guibg=#000000 gui=bold cterm=bold
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton guifg=#000000 guibg=#ffffff gui=bold cterm=bold
hi QuickFixLine guifg=#000000 guibg=#87afd7 gui=NONE cterm=NONE
hi CursorLineNr guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi LineNr guifg=#585858 guibg=NONE gui=NONE cterm=NONE
hi LineNrAbove guifg=#585858 guibg=NONE gui=NONE cterm=NONE
hi LineNrBelow guifg=#585858 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#585858 guibg=NONE gui=NONE cterm=NONE
hi FoldColumn guifg=#585858 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#585858 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#585858 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=NONE guibg=#262626 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#c6c6c6 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSel guifg=#000000 guibg=#af875f gui=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#ff5f5f guibg=#ffffff gui=reverse cterm=reverse
hi ErrorMsg guifg=#ff5f5f guibg=#ffffff gui=bold,reverse cterm=bold,reverse
hi ModeMsg guifg=#ffdf87 guibg=NONE gui=bold,reverse cterm=bold,reverse
hi MoreMsg guifg=#87ff5f guibg=NONE gui=bold cterm=bold
hi Question guifg=#ffafd7 guibg=NONE gui=bold cterm=bold
hi WarningMsg guifg=#ff5f5f guibg=NONE gui=bold cterm=bold
hi Todo guifg=#87dfdf guibg=#000000 gui=bold,reverse cterm=bold,reverse
hi Search guifg=#000000 guibg=#ffdf87 gui=NONE cterm=NONE
hi IncSearch guifg=#000000 guibg=#87ff5f gui=NONE cterm=NONE
hi CurSearch guifg=#000000 guibg=#87ff5f gui=NONE cterm=NONE
hi WildMenu guifg=#000000 guibg=#ffdf87 gui=bold cterm=bold
hi debugPC guifg=#5f87af guibg=NONE gui=reverse cterm=reverse
hi debugBreakpoint guifg=#5fafaf guibg=NONE gui=reverse cterm=reverse
hi Cursor guifg=#ffffff guibg=#000000 gui=reverse cterm=reverse
hi lCursor guifg=#0000ff guibg=#000000 gui=reverse cterm=reverse
hi Visual guifg=#ffffff guibg=#005f87 gui=NONE cterm=NONE
hi MatchParen guifg=#c5e7c5 guibg=#000000 gui=reverse cterm=reverse
hi VisualNOS guifg=#000000 guibg=#5fafaf gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi Folded guifg=#878787 guibg=#262626 gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#262626 gui=NONE cterm=NONE
hi SpellBad guifg=NONE guibg=NONE guisp=#ff5f5f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellCap guifg=NONE guibg=NONE guisp=#5f87af gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellLocal guifg=NONE guibg=NONE guisp=#5fd75f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellRare guifg=NONE guibg=NONE guisp=#ffafd7 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi Comment guifg=#87afd7 guibg=NONE gui=NONE cterm=NONE
hi Constant guifg=#ffdf87 guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Statement guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi Type guifg=#5fd75f guibg=NONE gui=bold cterm=bold
hi PreProc guifg=#878787 guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#878787 guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
hi Title guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi Directory guifg=#87dfdf guibg=NONE gui=bold cterm=bold
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#000000 guibg=#5faf5f gui=NONE cterm=NONE
hi DiffChange guifg=#000000 guibg=#d0d0d0 gui=NONE cterm=NONE
hi DiffText guifg=#000000 guibg=#b0b0b0 gui=NONE cterm=NONE
hi DiffDelete guifg=#d78787 guibg=NONE gui=NONE cterm=NONE
hi diffAdded guifg=#87ff5f guibg=NONE gui=NONE cterm=NONE
hi diffRemoved guifg=#d78787 guibg=NONE gui=NONE cterm=NONE
hi diffSubname guifg=#ffafd7 guibg=NONE gui=NONE cterm=NONE
hi dirType guifg=#ffdf87 guibg=NONE gui=NONE cterm=NONE
hi dirPermissionUser guifg=#5fafaf guibg=NONE gui=NONE cterm=NONE
hi dirPermissionGroup guifg=#d787af guibg=NONE gui=NONE cterm=NONE
hi dirPermissionOther guifg=#5f87af guibg=NONE gui=NONE cterm=NONE
hi dirOwner guifg=#af5f5f guibg=NONE gui=NONE cterm=NONE
hi dirGroup guifg=#af5f5f guibg=NONE gui=NONE cterm=NONE
hi dirTime guifg=#878787 guibg=NONE gui=NONE cterm=NONE
hi dirSize guifg=#ffdf87 guibg=NONE gui=NONE cterm=NONE
hi dirSizeMod guifg=#d787af guibg=NONE gui=NONE cterm=NONE

if s:t_Co >= 256
  hi! link helpVim Title
  hi! link helpHeader Title
  hi! link helpHyperTextJump Underlined
  hi! link fugitiveSymbolicRef Type
  hi! link fugitiveHeading Statement
  hi! link fugitiveStagedHeading Statement
  hi! link fugitiveUnstagedHeading Statement
  hi! link fugitiveStagedModifier Special
  hi! link fugitiveUnstagedModifier Special
  hi! link fugitiveHash Constant
  hi! link diffFile Preproc
  hi! link markdownHeadingDelimiter PreProc
  hi! link rstSectionDelimiter Statement
  hi! link rstDirective Special
  hi! link rstHyperlinkReference Special
  hi! link rstFieldName Special
  hi! link rstDelimiter Special
  hi! link colortemplateKey Statement
  hi! link xmlTagName Statement
  hi! link javaScriptFunction Statement
  hi! link javaScriptIdentifier Statement
  hi! link sqlKeyword Statement
  hi! link yamlBlockMappingKey Statement
  hi! link rubyMacro Statement
  hi! link rubyDefine Statement
  hi! link vimGroup Normal
  hi! link vimVar Normal
  hi! link vimOper Normal
  hi! link vimSep Normal
  hi! link vimParenSep Normal
  hi! link vimCommentString Comment
  hi! link pythonInclude Statement
  hi! link elixirOperator Statement
  hi! link elixirKeyword Statement
  hi! link elixirBlockDefinition Statement
  hi! link elixirDefine Statement
  hi! link elixirPrivateDefine Statement
  hi! link elixirGuard Statement
  hi! link elixirPrivateGuard Statement
  hi! link elixirModuleDefine Statement
  hi! link elixirProtocolDefine Statement
  hi! link elixirImplDefine Statement
  hi! link elixirRecordDefine Statement
  hi! link elixirPrivateRecordDefine Statement
  hi! link elixirMacroDefine Statement
  hi! link elixirPrivateMacroDefine Statement
  hi! link elixirDelegateDefine Statement
  hi! link elixirOverridableDefine Statement
  hi! link elixirExceptionDefine Statement
  hi! link elixirCallbackDefine Statement
  hi! link elixirStructDefine Statement
  hi! link elixirExUnitMacro Statement
  hi! link elixirInclude Statement
  hi! link elixirVariable Special
  hi! link elixirAtom Constant
  hi! link elixirDocTest String
  hi! link Terminal Normal
  hi! link StatuslineTerm Statusline
  hi! link StatuslineTermNC StatuslineNC
  hi Normal ctermfg=251 ctermbg=16 cterm=NONE
  hi Statusline ctermfg=16 ctermbg=251 cterm=bold
  hi StatuslineNC ctermfg=16 ctermbg=102 cterm=NONE
  hi VertSplit ctermfg=102 ctermbg=102 cterm=NONE
  hi TabLine ctermfg=251 ctermbg=240 cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=102 cterm=NONE
  hi TabLineSel ctermfg=251 ctermbg=16 cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=16 ctermbg=231 cterm=bold
  hi QuickFixLine ctermfg=16 ctermbg=110 cterm=NONE
  hi CursorLineNr ctermfg=231 ctermbg=NONE cterm=bold
  hi LineNr ctermfg=240 ctermbg=NONE cterm=NONE
  hi LineNrAbove ctermfg=240 ctermbg=NONE cterm=NONE
  hi LineNrBelow ctermfg=240 ctermbg=NONE cterm=NONE
  hi NonText ctermfg=240 ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=240 ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=240 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=240 ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=235 cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=251 cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=16 ctermbg=137 cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=203 ctermbg=231 cterm=reverse
  hi ErrorMsg ctermfg=203 ctermbg=231 cterm=bold,reverse
  hi ModeMsg ctermfg=222 ctermbg=NONE cterm=bold,reverse
  hi MoreMsg ctermfg=119 ctermbg=NONE cterm=bold
  hi Question ctermfg=218 ctermbg=NONE cterm=bold
  hi WarningMsg ctermfg=203 ctermbg=NONE cterm=bold
  hi Todo ctermfg=116 ctermbg=16 cterm=bold,reverse
  hi Search ctermfg=16 ctermbg=222 cterm=NONE
  hi IncSearch ctermfg=16 ctermbg=119 cterm=NONE
  hi CurSearch ctermfg=16 ctermbg=119 cterm=NONE
  hi WildMenu ctermfg=16 ctermbg=222 cterm=bold
  hi debugPC ctermfg=67 ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=73 ctermbg=NONE cterm=reverse
  hi Visual ctermfg=231 ctermbg=24 cterm=NONE
  hi MatchParen ctermfg=30 ctermbg=16 cterm=reverse
  hi VisualNOS ctermfg=16 ctermbg=73 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE
  hi Folded ctermfg=102 ctermbg=235 cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=235 cterm=NONE
  hi SpellBad ctermfg=203 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=110 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=119 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=218 ctermbg=NONE cterm=underline
  hi Comment ctermfg=110 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=222 ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Statement ctermfg=231 ctermbg=NONE cterm=bold
  hi Type ctermfg=77 ctermbg=NONE cterm=bold
  hi PreProc ctermfg=102 ctermbg=NONE cterm=NONE
  hi Special ctermfg=102 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=231 ctermbg=NONE cterm=bold
  hi Directory ctermfg=116 ctermbg=NONE cterm=bold
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=16 ctermbg=71 cterm=NONE
  hi DiffChange ctermfg=16 ctermbg=252 cterm=NONE
  hi DiffText ctermfg=16 ctermbg=145 cterm=NONE
  hi DiffDelete ctermfg=174 ctermbg=NONE cterm=NONE
  hi diffAdded ctermfg=119 ctermbg=NONE cterm=NONE
  hi diffRemoved ctermfg=174 ctermbg=NONE cterm=NONE
  hi diffSubname ctermfg=218 ctermbg=NONE cterm=NONE
  hi dirType ctermfg=222 ctermbg=NONE cterm=NONE
  hi dirPermissionUser ctermfg=73 ctermbg=NONE cterm=NONE
  hi dirPermissionGroup ctermfg=175 ctermbg=NONE cterm=NONE
  hi dirPermissionOther ctermfg=67 ctermbg=NONE cterm=NONE
  hi dirOwner ctermfg=131 ctermbg=NONE cterm=NONE
  hi dirGroup ctermfg=131 ctermbg=NONE cterm=NONE
  hi dirTime ctermfg=102 ctermbg=NONE cterm=NONE
  hi dirSize ctermfg=222 ctermbg=NONE cterm=NONE
  hi dirSizeMod ctermfg=175 ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 16
  hi Normal ctermfg=grey ctermbg=black cterm=NONE
  hi Statusline ctermfg=black ctermbg=grey cterm=bold
  hi StatuslineNC ctermfg=black ctermbg=darkgrey cterm=NONE
  hi VertSplit ctermfg=darkgrey ctermbg=darkgrey cterm=NONE
  hi TabLine ctermfg=grey ctermbg=grey cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=darkgrey cterm=NONE
  hi TabLineSel ctermfg=grey ctermbg=black cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=black ctermbg=white cterm=bold
  hi QuickFixLine ctermfg=black ctermbg=blue cterm=NONE
  hi CursorLineNr ctermfg=white ctermbg=NONE cterm=bold
  hi LineNr ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi LineNrAbove ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi LineNrBelow ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi NonText ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=black cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=grey cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=red ctermbg=white cterm=reverse
  hi ErrorMsg ctermfg=red ctermbg=white cterm=bold,reverse
  hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=bold,reverse
  hi MoreMsg ctermfg=green ctermbg=NONE cterm=bold
  hi Question ctermfg=magenta ctermbg=NONE cterm=bold
  hi WarningMsg ctermfg=red ctermbg=NONE cterm=bold
  hi Todo ctermfg=cyan ctermbg=black cterm=bold,reverse
  hi Search ctermfg=black ctermbg=yellow cterm=NONE
  hi IncSearch ctermfg=black ctermbg=green cterm=NONE
  hi CurSearch ctermfg=black ctermbg=green cterm=NONE
  hi WildMenu ctermfg=black ctermbg=yellow cterm=bold
  hi debugPC ctermfg=darkblue ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=darkcyan ctermbg=NONE cterm=reverse
  hi Visual ctermfg=white ctermbg=darkblue cterm=NONE
  hi MatchParen ctermfg=darkcyan ctermbg=black cterm=reverse
  hi VisualNOS ctermfg=black ctermbg=darkcyan cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorColumn ctermfg=black ctermbg=yellow cterm=NONE
  hi Folded ctermfg=black ctermbg=darkyellow cterm=NONE
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SpellBad ctermfg=red ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=blue ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=green ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
  hi Comment ctermfg=blue ctermbg=NONE cterm=NONE
  hi Constant ctermfg=yellow ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Statement ctermfg=white ctermbg=NONE cterm=bold
  hi Type ctermfg=darkgreen ctermbg=NONE cterm=bold
  hi PreProc ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Special ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=white ctermbg=NONE cterm=bold
  hi Directory ctermfg=cyan ctermbg=NONE cterm=bold
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=black ctermbg=darkyellow cterm=NONE
  hi DiffChange ctermfg=black ctermbg=lightgray cterm=NONE
  hi DiffText ctermfg=black ctermbg=darkgray cterm=NONE
  hi DiffDelete ctermfg=darkred ctermbg=NONE cterm=NONE
  hi diffAdded ctermfg=green ctermbg=NONE cterm=NONE
  hi diffRemoved ctermfg=darkred ctermbg=NONE cterm=NONE
  hi diffSubname ctermfg=magenta ctermbg=NONE cterm=NONE
  hi dirType ctermfg=yellow ctermbg=NONE cterm=NONE
  hi dirPermissionUser ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi dirPermissionGroup ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi dirPermissionOther ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi dirOwner ctermfg=darkred ctermbg=NONE cterm=NONE
  hi dirGroup ctermfg=darkred ctermbg=NONE cterm=NONE
  hi dirTime ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi dirSize ctermfg=yellow ctermbg=NONE cterm=NONE
  hi dirSizeMod ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  unlet s:t_Co
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
  unlet s:t_Co
  finish
endif

" Background: dark
" Color: color00     #000000        16             black
" Color: color08     #878787        102            darkgrey
" Color: color01     #AF5F5F        131            darkred
" Color: color09     #FF5F5F        203            red
" Color: color02     #5FD75F        77             darkgreen
" Color: color10     #87FF5F        119            green
" Color: color03     #AF875F        137            darkyellow
" Color: color11     #FFDF87        222            yellow
" Color: color04     #5F87AF        67             darkblue
" Color: color12     #87AFD7        110            blue
" Color: color05     #D787AF        175            darkmagenta
" Color: color13     #FFAFD7        218            magenta
" Color: color06     #5FAFAF        73             darkcyan
" Color: color14     #87DFDF        116            cyan
" Color: color07     #C6C6C6        251            grey
" Color: color15     #FFFFFF        231            white
" Color: colorLine   #303030        236            darkgrey
" Color: colorB      #262626        235            black
" Color: colorNonT   #585858        240            darkgrey
" Color: colorTab    #585858        240            grey
" Color: colorC      #FFFFFF        231            white
" Color: colorlC     #0000FF        21             blue
" Color: colorV      #005F87        24             darkblue
" Color: colorMP     #C5E7C5        30             darkcyan
" Color: diffAdd     #5FAF5F        71             darkyellow
" Color: diffDelete  #D78787        174            darkred
" Color: diffChange  #D0D0D0        252            lightgray
" Color: diffText    #B0B0B0        145            darkgray
" Color: fgDiff      #000000        16             black
" Term colors: color00 color01 color02 color03 color04 color05 color06 color07
" Term colors: color08 color09 color10 color11 color12 color13 color14 color15
" vim: et ts=2 sw=2
