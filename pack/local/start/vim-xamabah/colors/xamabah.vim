" Name:         xamabah
" Description:  anti habamax
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Website:      https://github.com/habamax/vim-xamabah
" License:      Same as Vim
" Last Updated: Sat 27 Jul 2024 15:18:46

" Generated by Colortemplate v2.2.3

set background=light

hi clear
let g:colors_name = 'xamabah'

let s:t_Co = has('gui_running') ? -1 : (&t_Co ?? 0)

hi! link Terminal Normal
hi! link StatuslineTerm Statusline
hi! link StatuslineTermNC StatuslineNC
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link MessageWindow PMenu
hi! link PopupNotification Todo
hi! link CurSearch IncSearch
hi! link gitcommitSummary Title
hi! link vimCommentString Comment
hi! link vimVar Normal
hi! link vimOper Normal
hi! link vimSep Normal
hi! link vimParenSep Normal
hi! link yamlBlockMappingKey Statement
hi! link rubyMacro Statement
hi! link rubyDefine Statement
hi! link javaScriptFunction Statement
hi! link javaScriptIdentifier Statement
hi! link sqlKeyword Statement
hi! link sqlSpecial Constant
hi! link Quote String
hi! link markdownUrl String
hi! link markdownHeadingDelimiter Statement
hi! link markdownHeadingRule Statement
hi! link markdownListMarker Constant
hi! link asciidoctorH1Delimiter Statement
hi! link asciidoctorH2Delimiter Statement
hi! link asciidoctorH3Delimiter Statement
hi! link asciidoctorH4Delimiter Statement
hi! link asciidoctorH5Delimiter Statement
hi! link asciidoctorH6Delimiter Statement
hi! link asciidoctorSetextHeaderDelimiter Statement
hi! link asciidoctorTitleDelimiter Statement
hi! link asciidoctorListMarker Constant
hi! link asciidoctorBlock Special
hi! link asciidoctorCode String
hi! link asciidoctorOption Special
hi! link asciidoctorMacro Special
hi! link lspDiagVirtualTextError Removed
hi! link lspDiagSignErrorText Removed
hi! link lspDiagInlineError ColorColumn
hi! link lspDiagVirtualTextWarning Changed
hi! link lspDiagSignWarningText Changed
hi! link lspDiagInlineWarning ColorColumn
hi! link lspDiagVirtualTextHint Added
hi! link lspDiagSignHintText Added
hi! link lspDiagInlineHint ColorColumn
hi! link lspDiagVirtualTextInfo Question
hi! link lspDiagSignInfoText Question
hi! link lspDiagInlineInfo ColorColumn

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#d7005f', '#208020', '#af5f00', '#005faf', '#870087', '#005f5f', '#dadada', '#767676', '#ff0087', '#20a020', '#d38120', '#0087d7', '#af00af', '#00875f', '#ffffff']
endif
hi Normal guifg=#000000 guibg=#e4e4e4 gui=NONE cterm=NONE
hi Statusline guifg=#e4e4e4 guibg=#626262 gui=NONE cterm=NONE
hi StatuslineNC guifg=#e4e4e4 guibg=#949494 gui=NONE cterm=NONE
hi VertSplit guifg=#626262 guibg=NONE gui=NONE cterm=NONE
hi TabLine guifg=#e4e4e4 guibg=#949494 gui=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#e4e4e4 guibg=#626262 gui=bold cterm=bold
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton guifg=#e4e4e4 guibg=#626262 gui=bold cterm=bold
hi QuickFixLine guifg=#e4e4e4 guibg=#005faf gui=NONE cterm=NONE
hi CursorLineNr guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi LineNr guifg=#a2a2a2 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#a2a2a2 guibg=NONE gui=NONE cterm=NONE
hi FoldColumn guifg=#a2a2a2 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#a2a2a2 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#a2a2a2 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=NONE guibg=#d0d0d0 gui=NONE cterm=NONE
hi PmenuSel guifg=NONE guibg=#b2b2b2 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#767676 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuKind guifg=#ff0087 guibg=#d0d0d0 gui=NONE cterm=NONE
hi PmenuKindSel guifg=#d7005f guibg=#b2b2b2 gui=NONE cterm=NONE
hi PmenuExtra guifg=#767676 guibg=#d0d0d0 gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#767676 guibg=#b2b2b2 gui=NONE cterm=NONE
hi PmenuMatch guifg=#af5f00 guibg=#d0d0d0 gui=NONE cterm=NONE
hi PmenuMatchSel guifg=#af5f00 guibg=#b2b2b2 gui=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#d7005f guibg=#e4e4e4 gui=reverse cterm=reverse
hi ErrorMsg guifg=#d7005f guibg=#e4e4e4 gui=reverse cterm=reverse
hi ModeMsg guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi MoreMsg guifg=#208020 guibg=NONE gui=NONE cterm=NONE
hi Question guifg=#af5f00 guibg=NONE gui=NONE cterm=NONE
hi WarningMsg guifg=#ff0087 guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#af5f00 guibg=#ffffff gui=reverse cterm=reverse
hi Search guifg=#208020 guibg=#ffffff gui=reverse cterm=reverse
hi IncSearch guifg=#d38120 guibg=#ffffff gui=reverse cterm=reverse
hi WildMenu guifg=#ffffff guibg=#d38120 gui=bold cterm=bold
hi debugPC guifg=#005faf guibg=NONE gui=reverse cterm=reverse
hi debugBreakpoint guifg=#005f5f guibg=NONE gui=reverse cterm=reverse
hi Cursor guifg=#ffffff guibg=#000000 gui=NONE cterm=NONE
hi lCursor guifg=#000000 guibg=#ff5fff gui=NONE cterm=NONE
hi Visual guifg=#5f8787 guibg=#ffffff gui=reverse cterm=reverse
hi VisualNOS guifg=#e4e4e4 guibg=#767676 gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#d9d9d9 gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#d9d9d9 gui=NONE cterm=NONE
hi Folded guifg=#878787 guibg=#ededed gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#ededed gui=NONE cterm=NONE
hi MatchParen guifg=#ff00af guibg=NONE gui=bold cterm=bold
hi SpellBad guifg=NONE guibg=NONE guisp=#ff0087 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellCap guifg=NONE guibg=NONE guisp=#d38120 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellLocal guifg=NONE guibg=NONE guisp=#20a020 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellRare guifg=NONE guibg=NONE guisp=#af00af gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi Comment guifg=#767676 guibg=NONE gui=NONE cterm=NONE
hi Constant guifg=#d7005f guibg=NONE gui=NONE cterm=NONE
hi String guifg=#208020 guibg=NONE gui=NONE cterm=NONE
hi Character guifg=#20a020 guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#00875f guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#870087 guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#005faf guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#af5f00 guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#005f5f guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
hi Title guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi Directory guifg=#005f5f guibg=NONE gui=bold cterm=bold
hi Conceal guifg=#a2a2a2 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#5f87af guibg=#e4e4e4 gui=reverse cterm=reverse
hi DiffChange guifg=#875f87 guibg=#e4e4e4 gui=reverse cterm=reverse
hi DiffText guifg=#5f87af guibg=#e4e4e4 gui=reverse cterm=reverse
hi DiffDelete guifg=#af5f5f guibg=#e4e4e4 gui=reverse cterm=reverse
hi Added guifg=#20a020 guibg=NONE gui=NONE cterm=NONE
hi Changed guifg=#d38120 guibg=NONE gui=NONE cterm=NONE
hi Removed guifg=#ff0087 guibg=NONE gui=NONE cterm=NONE

if s:t_Co >= 256
  hi Normal ctermfg=16 ctermbg=254 cterm=NONE
  hi Statusline ctermfg=254 ctermbg=241 cterm=NONE
  hi StatuslineNC ctermfg=254 ctermbg=246 cterm=NONE
  hi VertSplit ctermfg=241 ctermbg=NONE cterm=NONE
  hi TabLine ctermfg=254 ctermbg=246 cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=254 ctermbg=241 cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=254 ctermbg=241 cterm=bold
  hi QuickFixLine ctermfg=254 ctermbg=25 cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi LineNr ctermfg=248 ctermbg=NONE cterm=NONE
  hi NonText ctermfg=248 ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=248 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=248 ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=248 ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=255 cterm=NONE
  hi PmenuSel ctermfg=NONE ctermbg=252 cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=243 cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuKind ctermfg=198 ctermbg=255 cterm=NONE
  hi PmenuKindSel ctermfg=161 ctermbg=252 cterm=NONE
  hi PmenuExtra ctermfg=243 ctermbg=255 cterm=NONE
  hi PmenuExtraSel ctermfg=243 ctermbg=252 cterm=NONE
  hi PmenuMatch ctermfg=130 ctermbg=255 cterm=NONE
  hi PmenuMatchSel ctermfg=130 ctermbg=252 cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=161 ctermbg=254 cterm=reverse
  hi ErrorMsg ctermfg=161 ctermbg=254 cterm=reverse
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=28 ctermbg=NONE cterm=NONE
  hi Question ctermfg=130 ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=198 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=130 ctermbg=231 cterm=reverse
  hi Search ctermfg=28 ctermbg=231 cterm=reverse
  hi IncSearch ctermfg=172 ctermbg=231 cterm=reverse
  hi WildMenu ctermfg=231 ctermbg=172 cterm=bold
  hi debugPC ctermfg=25 ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=23 ctermbg=NONE cterm=reverse
  hi Visual ctermfg=66 ctermbg=231 cterm=reverse
  hi VisualNOS ctermfg=254 ctermbg=243 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=231 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=231 cterm=NONE
  hi Folded ctermfg=102 ctermbg=255 cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=255 cterm=NONE
  hi MatchParen ctermfg=199 ctermbg=NONE cterm=bold
  hi SpellBad ctermfg=198 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=172 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=34 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=127 ctermbg=NONE cterm=underline
  hi Comment ctermfg=243 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=161 ctermbg=NONE cterm=NONE
  hi String ctermfg=28 ctermbg=NONE cterm=NONE
  hi Character ctermfg=34 ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=30 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=90 ctermbg=NONE cterm=NONE
  hi Type ctermfg=25 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=130 ctermbg=NONE cterm=NONE
  hi Special ctermfg=23 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Directory ctermfg=23 ctermbg=NONE cterm=bold
  hi Conceal ctermfg=248 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=67 ctermbg=254 cterm=reverse
  hi DiffChange ctermfg=96 ctermbg=254 cterm=reverse
  hi DiffText ctermfg=67 ctermbg=254 cterm=reverse
  hi DiffDelete ctermfg=131 ctermbg=254 cterm=reverse
  hi Added ctermfg=34 ctermbg=NONE cterm=NONE
  hi Changed ctermfg=172 ctermbg=NONE cterm=NONE
  hi Removed ctermfg=198 ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 16
  hi Normal ctermfg=black ctermbg=white cterm=NONE
  hi Statusline ctermfg=white ctermbg=black cterm=NONE
  hi StatuslineNC ctermfg=white ctermbg=darkgrey cterm=NONE
  hi VertSplit ctermfg=black ctermbg=NONE cterm=NONE
  hi TabLine ctermfg=white ctermbg=darkgrey cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=white ctermbg=black cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=white ctermbg=black cterm=bold
  hi QuickFixLine ctermfg=white ctermbg=darkblue cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi LineNr ctermfg=grey ctermbg=NONE cterm=NONE
  hi NonText ctermfg=grey ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=grey ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=grey ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=white ctermbg=darkgrey cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=darkgreen cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=white ctermbg=darkyellow cterm=NONE
  hi PmenuKind ctermfg=darkred ctermbg=black cterm=NONE
  hi PmenuKindSel ctermfg=darkred ctermbg=darkyellow cterm=NONE
  hi PmenuExtra ctermfg=darkgrey ctermbg=black cterm=NONE
  hi PmenuExtraSel ctermfg=white ctermbg=darkyellow cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=white cterm=reverse
  hi ErrorMsg ctermfg=darkred ctermbg=white cterm=reverse
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Question ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=red ctermbg=NONE cterm=NONE
  hi Todo ctermfg=darkyellow ctermbg=white cterm=reverse
  hi Search ctermfg=darkgreen ctermbg=white cterm=reverse
  hi IncSearch ctermfg=yellow ctermbg=white cterm=reverse
  hi WildMenu ctermfg=white ctermbg=yellow cterm=bold
  hi debugPC ctermfg=darkblue ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=darkcyan ctermbg=NONE cterm=reverse
  hi Visual ctermfg=darkcyan ctermbg=white cterm=reverse
  hi VisualNOS ctermfg=white ctermbg=darkgrey cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorColumn ctermfg=black ctermbg=yellow cterm=NONE
  hi Folded ctermfg=black ctermbg=NONE cterm=bold
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi SpellBad ctermfg=red ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=yellow ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=green ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
  hi Comment ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
  hi String ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Character ctermfg=green ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=cyan ctermbg=NONE cterm=NONE
  hi Statement ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi Type ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Special ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Directory ctermfg=darkcyan ctermbg=NONE cterm=bold
  hi Conceal ctermfg=grey ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=darkblue ctermbg=white cterm=reverse
  hi DiffChange ctermfg=darkmagenta ctermbg=white cterm=reverse
  hi DiffText ctermfg=darkblue ctermbg=white cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=white cterm=reverse
  hi Added ctermfg=green ctermbg=NONE cterm=NONE
  hi Changed ctermfg=yellow ctermbg=NONE cterm=NONE
  hi Removed ctermfg=red ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 8
  hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Statusline ctermfg=grey ctermbg=black cterm=bold,reverse
  hi StatuslineNC ctermfg=black ctermbg=grey cterm=NONE
  hi VertSplit ctermfg=grey ctermbg=NONE cterm=NONE
  hi TabLine ctermfg=black ctermbg=grey cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=black ctermbg=grey cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=grey ctermbg=black cterm=bold,reverse
  hi QuickFixLine ctermfg=black ctermbg=darkblue cterm=NONE
  hi CursorLineNr ctermfg=darkyellow ctermbg=NONE cterm=bold
  hi LineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi NonText ctermfg=NONE ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=bold
  hi SpecialKey ctermfg=NONE ctermbg=NONE cterm=bold
  hi Pmenu ctermfg=black ctermbg=grey cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=darkgreen cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi PmenuKind ctermfg=darkred ctermbg=grey cterm=NONE
  hi PmenuKindSel ctermfg=darkred ctermbg=darkyellow cterm=NONE
  hi PmenuExtra ctermfg=black ctermbg=grey cterm=NONE
  hi PmenuExtraSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=black cterm=reverse
  hi ErrorMsg ctermfg=darkred ctermbg=black cterm=reverse
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Question ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=darkred ctermbg=NONE cterm=NONE
  hi Todo ctermfg=darkyellow ctermbg=black cterm=reverse
  hi Search ctermfg=black ctermbg=darkgreen cterm=NONE
  hi IncSearch ctermfg=black ctermbg=darkyellow cterm=NONE
  hi WildMenu ctermfg=black ctermbg=darkyellow cterm=NONE
  hi debugPC ctermfg=darkblue ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=darkcyan ctermbg=NONE cterm=reverse
  hi Visual ctermfg=darkyellow ctermbg=black cterm=reverse
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi VisualNOS ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi Folded ctermfg=grey ctermbg=NONE cterm=bold
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=reverse
  hi SpellCap ctermfg=darkyellow ctermbg=NONE cterm=reverse
  hi SpellLocal ctermfg=darkgreen ctermbg=NONE cterm=reverse
  hi SpellRare ctermfg=darkmagenta ctermbg=NONE cterm=reverse
  hi Comment ctermfg=NONE ctermbg=NONE cterm=bold
  hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
  hi String ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Statement ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi Type ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Special ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Directory ctermfg=NONE ctermbg=NONE cterm=bold
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=darkblue ctermbg=black cterm=reverse
  hi DiffChange ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi DiffText ctermfg=darkblue ctermbg=black cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=black cterm=reverse
  hi Added ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Changed ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Removed ctermfg=darkred ctermbg=NONE cterm=NONE
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
  hi CurSearch term=reverse
  hi CursorLineFold term=underline
  hi CursorLineSign term=underline
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

" Background: light
" Color: colorFg                 #000000        16             black
" Color: colorBg                 #e4e4e4        254            white
" Color: color00                 #000000        16             black
" Color: color08                 #767676        243            darkgrey
" Color: color01                 #d7005f        161            darkred
" Color: color09                 #ff0087        198            red
" Color: color02                 #208020        28             darkgreen
" Color: color10                 #20a020        34             green
" Color: color03                 #af5f00        130            darkyellow
" Color: color11                 #d38120        172            yellow
" Color: color04                 #005faf        25             darkblue
" Color: color12                 #0087d7        32             blue
" Color: color05                 #870087        90             darkmagenta
" Color: color13                 #af00af        127            magenta
" Color: color06                 #005f5f        23             darkcyan
" Color: color14                 #00875f        30             cyan
" Color: color07                 #dadada        253            grey
" Color: color15                 #ffffff        231            white
" Color: colorLine               #d9d9d9        231            grey
" Color: colorPmenu              #d0d0d0        255            grey
" Color: colorPmenuSel           #b2b2b2        252            grey
" Color: colorB                  #ededed        255            grey
" Color: colorNonT               #a2a2a2        248            grey
" Color: colorFold               #878787        102            grey
" Color: colorlC                 #ff5fff        207            magenta
" Color: colorMP                 #ff00af        199            magenta
" Color: colorSt                 #626262        241            black
" Color: colorStIn               #949494        246            darkgrey
" Color: colorV                  #5f8787        66             darkcyan
" Color: diffAdd                 #5f87af        67             darkblue
" Color: diffDelete              #af5f5f        131            darkred
" Color: diffChange              #875f87        96             darkmagenta
" Color: diffText                #5f87af        67             darkblue
" Term colors: color00 color01 color02 color03 color04 color05 color06 color07
" Term colors: color08 color09 color10 color11 color12 color13 color14 color15
" vim: et ts=8 sw=2 sts=2
